

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/features/verse/verse_download_audio/services/quran_download_service.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/services/i_verse_audio_service.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';
import 'package:hadith/models/resource.dart';
import 'package:hadith/services/connectivity_service.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicAudioBloc extends Bloc<IBasicAudioEvent,BasicAudioState>{

  late final IVerseAudioService _audioService;
  late final QuranDownloadService _downloadService;
  late final VerseAudioRepo _audioRepo;

  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  BasicAudioBloc({required IVerseAudioService audioService,required QuranDownloadService downloadService,
    required VerseAudioRepo audioRepo
  }) : super(BasicAudioState.init()){

    _audioService = audioService;
    _downloadService = downloadService;
    _audioRepo = audioRepo;

    on<BasicAudioEventStartWithIdentifier>(_onStartWithIdentifier,transformer: droppable());
    on<BasicAudioEventPause>(_onPause,transformer: restartable());
    on<BasicAudioEventResume>(_onResume,transformer: restartable());
    on<BasicAudioEventInit>(_onInit,transformer: restartable());
    on<BasicAudioEventStopListening>(_onDisabled,transformer: restartable());


    add(BasicAudioEventInit());
  }

  void _onInit(BasicAudioEventInit event,Emitter<BasicAudioState>emit)async{

    final streamData = _audioService.broadcastListener;
    if(streamData!=null){
      await emit.forEach<VerseAudioModel>(streamData, onData: (data){
        if(data.error!=null){
          _addMessage(data.error!, emit);
        }
        return state.copyWith(audioModel: data,setAudio: true,currentIdentifier: data.audio?.identifier,setIdentifier: true);
      });
    }
  }

  void _addMessage(String message,Emitter<BasicAudioState>emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true,audioModel: state.audioModel?.copyWith(setError: true)));
  }

  void _onStartWithIdentifier(BasicAudioEventStartWithIdentifier event,Emitter<BasicAudioState>emit)async{

    if(state.isDownloading){
      return _addMessage("indirme işleminiz devam ediyor", emit);
    }

    final audioParam = AudioParam(mealId: 1, cuzNo: 1, pageNo: 1, surahId: 1,
        option: QuranAudioOption.verse);
    final identifier = event.identifier;
    final isItemExists = await _audioRepo.isVerseAudioExits(audioParam, identifier);

    await _audioService.stop();
    if(isItemExists){
      _audioService.playAudios(audioParam, identifier);
    }else{
      if(!await ConnectivityService.isConnectedInternet()){
        return _addMessage("internet bağlantınızı kontrol edin",emit);
      }
      emit(state.copyWith(isDownloading: true,currentIdentifier: identifier,setIdentifier: true,
          isDisabled: false));

      final response = await _downloadService.downloadSingleVoice(identifier, 1, 1
          ,audioQuality: event.audioQuality);
      emit(state.copyWith(isDownloading: false));
      if(response is ResourceSuccess<bool> && !state.isDisabled){
        _audioService.playAudios(audioParam, identifier);
      }else{
        _addMessage("bir şeyler yanlış gitti",emit);
      }
    }

  }

  void _onPause(BasicAudioEventPause event,Emitter<BasicAudioState>emit)async{
    await _audioService.pause();
  }

  void _onResume(BasicAudioEventResume event,Emitter<BasicAudioState>emit)async{
    await _audioService.resume();
  }

  void _onDisabled(BasicAudioEventStopListening event,Emitter<BasicAudioState>emit)async{
    await _audioService.stop();
    emit(state.copyWith(isDisabled: true));
  }


}