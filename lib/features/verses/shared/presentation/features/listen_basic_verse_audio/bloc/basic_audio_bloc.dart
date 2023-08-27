

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/data/mapper/param_mapper.dart';
import 'package:hadith/features/verses/shared/domain/enums/listen_audio_enum.dart';
import 'package:hadith/features/verses/shared/domain/manager/verse_audio_download_manager.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_audio_repo.dart';
import 'package:hadith/features/verses/shared/domain/services/i_verse_audio_service.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/services/connectivity_service.dart';

import 'basic_audio_event.dart';
import 'basic_audio_state.dart';

class BasicAudioBloc extends Bloc<IBasicAudioEvent,BasicAudioState>{

  late final IVerseAudioServiceManager _audioPlayerService;
  late final VerseAudioDownloadManager _downloadManager;
  late final AppPreferences _appPreferences;
  late final VerseAudioRepo _verseAudioRepo;


  BasicAudioBloc({
    required IVerseAudioServiceManager verseAudioService,
    required VerseAudioDownloadManager downloadManager,
    required AppPreferences appPreferences,
    required VerseAudioRepo verseAudioRepo
  }) : super(BasicAudioState.init()){

    _audioPlayerService = verseAudioService;
    _downloadManager = downloadManager;
    _appPreferences = appPreferences;
    _verseAudioRepo = verseAudioRepo;

    on<BasicAudioEventStartWithIdentifier>(_onStartWithIdentifier,transformer: droppable());
    on<BasicAudioEventPause>(_onPause,transformer: restartable());
    on<BasicAudioEventResume>(_onResume,transformer: restartable());
    on<BasicAudioEventInit>(_onInit,transformer: restartable());
    on<BasicAudioEventClearMessage>(_onClearMessage,transformer: restartable());
    on<BasicAudioEventStopListening>(_onDisabled,transformer: restartable());


    add(BasicAudioEventInit());
  }



  void _onInit(BasicAudioEventInit event,Emitter<BasicAudioState>emit)async{
    final streamData = _audioPlayerService.broadcastListener;

    await emit.forEach<ListenAudioServiceState>(streamData, onData: (data){
      return state.copyWith(
          setAudioServiceState: true,
          audioServiceState: data,
          setActiveIdentifier: true,
          activeIdentifier: data.audio?.identifier
      );
    });
  }


  void _onStartWithIdentifier(BasicAudioEventStartWithIdentifier event,Emitter<BasicAudioState>emit)async{
    if(state.isDownloading){
      return _showMessage("indirme işleminiz devam ediyor", emit);
    }

    final listenParam = ListenAudioParam(
        identifier: event.identifier,
        itemId: event.verseId,
        op: QuranAudioOption.verse
    );
    final downloadParam = listenParam.toDownloadAudioParam(
      qualityEnum: event.audioQuality ?? _appPreferences.getEnumItem(KPref.audioQualityEnum)
    );

    final isItemExists = await _verseAudioRepo.hasVerseAudios(listenParam);

    if(state.activeIdentifier != listenParam.identifier){
      await _audioPlayerService.stop();
      emit(state.copyWith(setAudioServiceState: true));
    }

    if(isItemExists){
      _audioPlayerService.playAudios(listenParam);
    }else{

      if(!await ConnectivityService.isConnectedInternet()){
        return _showMessage("internet bağlantınızı kontrol edin",emit);
      }
      emit(state.copyWith(
          isDownloading: true,
          setActiveIdentifier: true,
          activeIdentifier: listenParam.identifier,
      ));

      final response = await _downloadManager.downloadSingle(downloadParam);
      emit(state.copyWith(isDownloading: false));
      if(response is ResourceSuccess<void>){
        _audioPlayerService.playAudios(listenParam);
      }else{
        _showMessage("bir şeyler yanlış gitti",emit);
      }
    }

  }

  void _onPause(BasicAudioEventPause event,Emitter<BasicAudioState>emit)async{
    await _audioPlayerService.pause();
  }

  void _onResume(BasicAudioEventResume event,Emitter<BasicAudioState>emit)async{
    await _audioPlayerService.resume();
  }

  void _onDisabled(BasicAudioEventStopListening event,Emitter<BasicAudioState>emit)async{
    await _downloadManager.cancel();
    await _audioPlayerService.stop();
  }

  void _onClearMessage(BasicAudioEventClearMessage event,Emitter<BasicAudioState>emit){
    emit(state.copyWith(setMessage: true));
  }

  void _showMessage(String message,Emitter<BasicAudioState>emit){
    emit(state.copyWith(message: message,setMessage: true));
  }

}