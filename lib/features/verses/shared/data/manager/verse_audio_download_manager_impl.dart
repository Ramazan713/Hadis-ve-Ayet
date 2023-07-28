

import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/enums/download_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_audio_repo.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_downloaded_voice_repo.dart';
import 'package:hadith/features/verses/shared/domain/services/quran_download_service.dart';
import 'package:hadith/features/verses/shared/domain/util/stream_resource.dart';
import 'package:hadith/features/verses/shared/domain/manager/verse_audio_download_manager.dart';
import 'package:hadith/models/resource.dart';
import 'package:rxdart/rxdart.dart';

class VerseAudioDownloadManagerImpl extends VerseAudioDownloadManager{

  late final QuranDownloadService _quranDownloadService;
  late final VerseAudioRepo _verseAudioRepo;
  late final ConnectivityService _connectivityService;
  late final VerseDownloadedVoiceRepo _verseDownloadedVoiceRepo;

  StreamSubscription<StreamResource<VerseDownloadedVoiceModel>>? _quranServiceListener;
  StreamSubscription<bool>? _networkConnectionListener;

  final BehaviorSubject<DownloadAudioManagerState> _streamResource = BehaviorSubject();

  @override
  ValueStream<DownloadAudioManagerState>? get broadcastListener => _streamResource.stream.shareValue();


  DownloadAudioManagerState _state = DownloadAudioManagerState.init();

  @override
  DownloadAudioManagerState get state => _state;

  VerseAudioDownloadManagerImpl({
    required QuranDownloadService quranDownloadService,
    required VerseAudioRepo verseAudioRepo,
    required ConnectivityService connectivityService,
    required VerseDownloadedVoiceRepo verseDownloadedVoiceRepo
  }){
    _quranDownloadService = quranDownloadService;
    _verseAudioRepo = verseAudioRepo;
    _connectivityService = connectivityService;
    _verseDownloadedVoiceRepo = verseDownloadedVoiceRepo;

    _setNetworkListener();
  }


  void _setNetworkListener(){
    _networkConnectionListener = _connectivityService.hasConnectionStream().listen((hasConnection) {
      if(!hasConnection){
        if(_state.downloadEnum == DownloadEnum.downloading){
          pause();
        }
        _addState(_state.copyWith(setError: true,error: "internet bağlantınızı kontrol edin",downloadEnum: DownloadEnum.error));
      }else{
        if(_state.downloadEnum == DownloadEnum.error){
          _addState(_state.copyWith(setError: true,downloadEnum: DownloadEnum.retry));
        }
      }
    });
  }



  @override
  void addQueue(DownloadAudioParam param)async{
    if(_state.currentParam == null && _state.downloadEnum.isAvailable){
      _addState(_state.copyWith(currentParam: param,setCurrentParam: true));
      _startDownload(param);
    }else if(!_state.queueParams.contains(param)){
      final params = _state.queueParams.toList()..add(param);
      _addState(_state.copyWith(queueParams: params));
    }
  }

  @override
  void pause(){
    _addState(_state.copyWith(downloadEnum: DownloadEnum.pause));
    _quranServiceListener?.pause();
    _quranDownloadService.pause();
  }

  @override
  void resume()async{
    _addState(_state.copyWith(downloadEnum: DownloadEnum.downloading));
    _quranServiceListener?.resume();
    _quranDownloadService.resume();
  }

  @override
  void retry()async{
    final currentParam = _state.currentParam;
    if(currentParam!=null){
      _startDownload(currentParam);
    }else{
      await _downloadNextParamIfExists(
        existsNextPreState: _state.copyWith(
          downloadEnum: DownloadEnum.downloading
        )
      );
    }
  }

  @override
  Future<void> cancel()async{
    await _resetState();
    await _cancelListeners();
  }

  @override
  void dispose()async{
    await _cancelListeners();
    await _streamResource.close();
    await _networkConnectionListener?.cancel();
  }

  Future<void> _resetState() async{

    EasyThrottle.throttle("init_download_service", Duration(milliseconds: K.service.resetDownloadStateInMilli), () async{
      if(_state.downloadEnum != DownloadEnum.idle){
        _addState(DownloadAudioManagerState.init());
        await Future.delayed(Duration(milliseconds: K.service.delayForResetDownloadStateInMilli));
      }
    });
  }

  Future<void> _downloadNextParamIfExists({
    required DownloadAudioManagerState existsNextPreState,
    DownloadAudioManagerState? notExistsState
  })async{
    final queueParams = _state.queueParams;
    final nextParam = queueParams.firstOrNull;
    if(nextParam!=null){
      final lastCurrentParam = existsNextPreState.currentParam;
      queueParams.remove(nextParam);
      _addState(existsNextPreState.copyWith(
        queueParams: queueParams,
        currentParam: nextParam, setCurrentParam: true,
        lastDownloaded: lastCurrentParam, setLastDownloaded: true
      ));
      _startDownload(nextParam);
    }else{
      if(notExistsState!=null){
        _addState(notExistsState);
      }
    }
  }

  Future<void> _downloadOrFinishAsSuccessAll()async{
    await _downloadNextParamIfExists(
        notExistsState: _state.copyWith( // if queue is empty add success
            downloadEnum: DownloadEnum.successAll,
            current: state.total,
            setLastDownloaded: true, lastDownloaded: _state.currentParam,
            setCurrentParam: true
        ),
        existsNextPreState: _state.copyWith( // download next param
            current: state.total,
            downloadEnum: DownloadEnum.successStep
        )
    );
  }

  void _startDownload(DownloadAudioParam param)async{

    if(!await _connectivityService.hasConnected()){
      return _addState(_state.copyWith(setError: true,error: "internet bağlantınızı kontrol edin",downloadEnum: DownloadEnum.error));
    }
    final voiceModelsWithGroup = await _verseDownloadedVoiceRepo.getNotDownloadedAudioVersesWithGroupByMealId(
        itemId: param.itemIdForOption,
        op: param.op,
        identifier: param.identifier,
        startVerseId: param.startVerseId
    );

    //if downloaded before, continue next param
    if(voiceModelsWithGroup.isEmpty){
      return _downloadOrFinishAsSuccessAll();
    }

    var index = 0;
    var voiceGroup = voiceModelsWithGroup[index];

    await _quranServiceListener?.cancel();
    await _quranDownloadService.initStream(voiceModelsWithGroup.map((e) => e.length).sum);

    _addState(_state.copyWith(downloadEnum: DownloadEnum.downloading));

    await _quranDownloadService.startStreamDownloading(
      identifier: param.identifier,
      audioQuality: param.audioQualityEnum,
      models: voiceGroup
    );

    _quranServiceListener = _quranDownloadService.streamDownloadListener?.listen((event) async{
      if(event is StreamResourceSuccessAll<VerseDownloadedVoiceModel,List<int>>){
        index++;
        //add audio file and metadata to database
        await _addAudioFile(param, event.result, voiceGroup);

        // continue to download other verse meals
        if(index < voiceModelsWithGroup.length){
          voiceGroup = voiceModelsWithGroup[index];
          await _quranDownloadService.startStreamDownloading(
            models: voiceGroup,
            audioQuality: param.audioQualityEnum,
            identifier: param.identifier
          );
        }else{ // if no more verse meal to download

          // check queue to have params to continue
          await _downloadOrFinishAsSuccessAll();

        }
      }else if(event is StreamResourceLoadingWithData<VerseDownloadedVoiceModel>){
        if(_state.downloadEnum == DownloadEnum.downloading){
          _addState(_state.copyWith(voiceModel: event.data,total: event.total,current: event.progress));
        }else if(_state.downloadEnum == DownloadEnum.pause){
          _quranDownloadService.pause();
        }
      } else if(event is StreamResourceError<VerseDownloadedVoiceModel>){
        _addState(_state.copyWith(setError: true,error: event.error,downloadEnum: DownloadEnum.error));
        _quranDownloadService.cancel();
      }
    });
  }

  Future<void> _addAudioFile(DownloadAudioParam param, List<int> bytes, List<VerseDownloadedVoiceModel> voiceGroups)async{
    final mealId = voiceGroups.firstOrNull?.mealId;
    if(mealId == null) return;
    await _verseAudioRepo.createVerseAudioAndFile(
        mealId: mealId,
        identifier: param.identifier,
        bytes: bytes,
        hasEdited: voiceGroups.length == 1
    );
  }

  void _addState(DownloadAudioManagerState newState){
    _state = newState;
    _streamResource.add(_state);
  }


  Future<void> _cancelListeners()async{
    await _quranServiceListener?.cancel();
    await _quranDownloadService.cancel();
  }

  @override
  Future<Resource<void>> downloadSingle(DownloadAudioParam param) async{
    if(param.op != QuranAudioOption.verse) return ResourceError("bir şeyler yanlış");

    final response = await _quranDownloadService.downloadSingleAudio(
        identifier: param.identifier,
        verseId: param.itemIdForOption,
        audioQuality: param.audioQualityEnum
    );

    if(response is ResourceError<Uint8List>){
      return ResourceError(response.error);
    }
    final data = (response as ResourceSuccess<Uint8List>).data;
    await _addAudioFile(param, data.toList(), [VerseDownloadedVoiceModel(
      mealId: param.itemIdForOption,pageNo: 1,cuzNo: 1,surahName: "",
      surahId: 1,verseNumberTr: 1,verseId: param.itemIdForOption
    )]);

    return ResourceSuccess(null);
  }


}