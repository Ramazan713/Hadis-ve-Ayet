

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/constants/verse_constant.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/entities/verse_arabic.dart';
import 'package:hadith/db/repos/audio_edition_repo.dart';
import 'package:hadith/db/repos/verse_arabic_repo.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/db/repos/verse_audio_state_repo.dart';
import 'package:hadith/db/remote/dto/edition_dto.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/features/verse/verse_download_audio/constants/download_enum.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:hadith/features/verse/verse_download_audio/models/download_voice_service_state.dart';
import 'package:hadith/features/verse/verse_download_audio/services/quran_download_service.dart';
import 'package:hadith/models/resource.dart';
import 'package:hadith/models/stream_resource.dart';
import 'package:hadith/services/connectivity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranDownloadManager{
  late final VerseAudioStateRepo _verseAudioStateRepo;
  late final AudioEditionRepo _audioEditionRepo;
  late final QuranDownloadService _quranService;
  late final SharedPreferences _sharedPreferences;

  final StreamController<DownloadVoiceServiceState> _streamResource = StreamController();
  Stream<DownloadVoiceServiceState>? broadcastListener;
  StreamSubscription<StreamResource<DownloadVoiceEntity>>? _quranServiceListener;
  StreamSubscription<ConnectivityResult>? _networkConnectionListener;

  String _identifier="";
  DownloadVoiceServiceState _state = DownloadVoiceServiceState.init();

  AudioParam? prevAudioParam;

  QuranDownloadManager({required AudioEditionRepo audioEditionRepo ,required SharedPreferences sharedPreferences,
    required QuranDownloadService quranService,required VerseAudioStateRepo verseAudioStateRepo
  }){
    _audioEditionRepo = audioEditionRepo;
    _quranService = quranService;
    _verseAudioStateRepo = verseAudioStateRepo;
    _sharedPreferences = sharedPreferences;

    _networkConnectionListener=ConnectivityService.getConnectionStream().listen((event) {
      final hasConnection = event == ConnectivityResult.wifi || event == ConnectivityResult.mobile;
      if(!hasConnection){
        if(_state.downloadEnum == DownloadEnum.downloading){
          pause();
        }
        _state = _state.copyWith(setError: true,error: "internet bağlantınızı kontrol edin",downloadEnum: DownloadEnum.error);
        _streamResource.add(_state);
      }else{
        if(_state.downloadEnum == DownloadEnum.error){
          _state = _state.copyWith(setError: true,downloadEnum: DownloadEnum.retry);
          _streamResource.add(_state);
        }
      }
    });
    broadcastListener = _streamResource.stream.asBroadcastStream();
  }

  List<List<DownloadVoiceEntity>> _groupByMealId(List<DownloadVoiceEntity> models,{bool addMention=true}){
    List<List<DownloadVoiceEntity>> items = [];
    List<DownloadVoiceEntity> tempArr = [];
    if(models.isEmpty){
      return items;
    }
    int mealId = models[0].mealId;
    for (var model in models){
      if(mealId!=model.mealId){
        items.add(tempArr);
        tempArr = [];
        mealId = model.mealId;
      }
      if(model.verseNumber == 1 && addMention && !VerseConstant.mentionExclusiveIds.contains(model.surahId)){
        final newModel=model.copyWith(verseNumber: 0,surahId: 1,verseId: 1);
        tempArr.add(newModel);
      }
      tempArr.add(model);
    }
    if(tempArr.isNotEmpty){
      items.add(tempArr);
    }
    return items;
  }

  Future<List<DownloadVoiceEntity>> _getUnDownloadedItems(AudioParam audioParam)async{
    return _verseAudioStateRepo.getNotDownloadedAudioVerses(audioParam, _identifier);
  }

  Future<bool>_setIdentifier()async{
    final edition = await _audioEditionRepo.getSelectedEditionResource();
    if(edition is ResourceSuccess<AudioEdition?>){
      final identifier = edition.data?.identifier;
      if(identifier!=null){
        _identifier = identifier;
        return true;
      }
    }
    return false;
  }

  void _addState(DownloadVoiceServiceState newState){
    _state = newState;
    _streamResource.add(_state);
  }

  void startDownload(AudioParam audioParam)async{

    if(!await ConnectivityService.isConnectedInternet()){
      return _streamResource.add(_state.copyWith(setError: true,error: "internet bağlantınızı kontrol edin",downloadEnum: DownloadEnum.error));
    }

    if(!await _setIdentifier()){
      return;
    }
    final audioQualityIndex = _sharedPreferences.getInt(PrefConstants.audioQuality.key)??
      PrefConstants.audioQuality.defaultValue;

    final audioQuality = AudioQualityEnum.values[audioQualityIndex];

    final voiceModels = await _getUnDownloadedItems(audioParam);

    final voiceModelsWithGroup = _groupByMealId(voiceModels);

    var index = 0;
    var voiceGroup = voiceModelsWithGroup[index];

    await _quranServiceListener?.cancel();
    _quranService.initForStreamDownloading(voiceModels.length);
    _addState(_state.copyWith(downloadEnum: DownloadEnum.downloading));
    await _quranService.startStreamDownloading(_identifier, voiceGroup,audioQuality: audioQuality);

    prevAudioParam = audioParam;

    _quranServiceListener=_quranService.broadcastStream?.listen((event) async{
      if(event is StreamResourceSuccessFinish<DownloadVoiceEntity>){
          index++;
          if(index < voiceModelsWithGroup.length){
            voiceGroup = voiceModelsWithGroup[index];
            await _quranService.startStreamDownloading(_identifier, voiceGroup,audioQuality: audioQuality);
          }else{
            _addState(_state.copyWith(downloadEnum: DownloadEnum.success));
          }
        }else if(event is StreamResourceLoadingWithData<DownloadVoiceEntity>){
          if(_state.downloadEnum == DownloadEnum.downloading){
            _addState(_state.copyWith(voiceModel: event.data,total: event.total,current: event.downloaded));
          }else if(_state.downloadEnum == DownloadEnum.pause){
            _quranService.onPause();
          }
        } else if(event is StreamResourceError<DownloadVoiceEntity>){
          _addState(_state.copyWith(setError: true,error: event.error,downloadEnum: DownloadEnum.error));
          _quranService.onCancel();
        }
    });
  }

  void pause(){
    _addState(_state.copyWith(downloadEnum: DownloadEnum.pause));
    _quranServiceListener?.pause();
    _quranService.onPause();
  }

  void resume()async{
    _addState(_state.copyWith(downloadEnum: DownloadEnum.downloading));
    _quranServiceListener?.resume();
    _quranService.onResume();
  }

  void retry()async{
    if(prevAudioParam!=null){
      startDownload(prevAudioParam!);
    }
  }

  Future<void>_cancelListeners()async{
    await _quranServiceListener?.cancel();
    await _quranService.onCancel();
    await _networkConnectionListener?.cancel();
  }

  Future<void> cancel()async{
    _addState(_state.copyWith(downloadEnum: DownloadEnum.idle));
    await _cancelListeners();
  }

  void dispose()async{
    await _cancelListeners();
    await _streamResource.close();
  }


}