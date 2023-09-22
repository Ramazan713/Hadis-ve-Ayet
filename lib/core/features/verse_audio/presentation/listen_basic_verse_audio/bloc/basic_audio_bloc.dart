

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/verse_audio_download_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_audio_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/services/i_verse_audio_service.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';

import 'basic_audio_event.dart';
import 'basic_audio_state.dart';

class BasicAudioBloc extends Bloc<IBasicAudioEvent,BasicAudioState>{

  late final IVerseAudioServiceManager _audioPlayerService;
  late final VerseAudioDownloadManager _downloadManager;
  late final AppPreferences _appPreferences;
  late final VerseAudioRepo _verseAudioRepo;
  late final EditionRepo _editionRepo;
  late final ConnectivityService _connectivityService;


  BasicAudioBloc({
    required IVerseAudioServiceManager verseAudioService,
    required VerseAudioDownloadManager downloadManager,
    required AppPreferences appPreferences,
    required VerseAudioRepo verseAudioRepo,
    required EditionRepo editionRepo,
    required ConnectivityService connectivityService
  }) : super(BasicAudioState.init()){

    _audioPlayerService = verseAudioService;
    _downloadManager = downloadManager;
    _appPreferences = appPreferences;
    _verseAudioRepo = verseAudioRepo;
    _editionRepo = editionRepo;
    _connectivityService = connectivityService;

    on<BasicAudioEventStartWithIdentifier>(_onStartWithIdentifier,transformer: droppable());
    on<BasicAudioEventStartWithCustomVerseIds>(_onStartWithCustomVerseIds,transformer: droppable());
    on<BasicAudioEventPause>(_onPause,transformer: restartable());
    on<BasicAudioEventResume>(_onResume,transformer: restartable());
    on<BasicAudioEventInit>(_onInit,transformer: restartable());
    on<BasicAudioEventClearMessage>(_onClearMessage,transformer: restartable());
    on<BasicAudioEventCancel>(_onCancel,transformer: restartable());


    on<BasicAudioEventChangeSpeed>(_onSetSpeed,transformer: restartable());
    on<BasicAudioEventChangePosition>(_onSetPosition,transformer: restartable());
    on<BasicAudioEventSetLoop>(_onSetLoop,transformer: restartable());
    on<BasicAudioEventToggleVisibilityAudioWidget>(_onVisibilityAudioPlayerWidget,transformer: restartable());

    add(BasicAudioEventInit());
  }


  void _onInit(BasicAudioEventInit event,Emitter<BasicAudioState>emit)async{
    final streamData = _audioPlayerService.broadcastListener;
    await emit.forEach<ListenAudioServiceState>(streamData, onData: (data){
      return state.copyWith(
        audioServiceState: data,
        activeIdentifier: data.audio?.identifier,
      );
    });
  }

  void _onStartWithCustomVerseIds(BasicAudioEventStartWithCustomVerseIds event,Emitter<BasicAudioState>emit)async{
    if(state.isDownloading){
      return _showMessage("indirme işleminiz devam ediyor", emit);
    }
    final qualityEnum = event.audioQuality ?? _appPreferences.getEnumItem(KPref.audioQualityEnum);
    final verseIds = event.verseIds;

    final String? identifier = await _getIdentifier(event.identifier);
    if(identifier == null) return _showMessage("bilinmeyen bir hata oluştu", emit);

    final isItemExists = await _verseAudioRepo.hasVerseAudiosWithIds(verseIds: verseIds, identifier: identifier);

    if(state.activeIdentifier != identifier){
      await _audioPlayerService.stop();
      emit(state.copyWith(audioServiceState: null));
    }

    if(isItemExists){
      await _startListening(verseIds: verseIds, identifier: identifier);
      emit(state.copyWith(
        showAudioPlayerWidget: true,
        audioTag: event.audioTag
      ));
    }else{
      if(!(await _connectivityService.hasConnected)){
        return _showMessage("internet bağlantınızı kontrol edin",emit);
      }
      emit(state.copyWith(
        isDownloading: true,
        activeIdentifier: identifier,
      ));

      final response = await _downloadManager.downloadMultiVerse(
          verseIds: verseIds,
          identifier: identifier,
          quality: qualityEnum
      );
      await response.handleAsync(
        onSuccess: (data)async{
          await _startListening(verseIds: verseIds, identifier: identifier);
          emit(state.copyWith(
            isDownloading: false,
            showAudioPlayerWidget: true,
            audioTag: event.audioTag
          ));
        },
        onError: (error)async{
          emit(state.copyWith(
            isDownloading: false,
            message: error,
          ));
        }
      );
    }
  }



  void _onStartWithIdentifier(BasicAudioEventStartWithIdentifier event,Emitter<BasicAudioState>emit)async{
    add(BasicAudioEventStartWithCustomVerseIds(
      verseIds: [event.verseId],
      identifier: event.identifier,
      audioQuality: event.audioQuality
    ));
  }

  void _onPause(BasicAudioEventPause event,Emitter<BasicAudioState>emit)async{
    if(state.isActiveRunning){
      await _audioPlayerService.pause();
    }
  }

  void _onResume(BasicAudioEventResume event,Emitter<BasicAudioState>emit)async{
    await _audioPlayerService.resume();
  }

  void _onCancel(BasicAudioEventCancel event,Emitter<BasicAudioState>emit)async{
    await _downloadManager.cancel();
    await _audioPlayerService.stop();
    emit(state.copyWith(
      showAudioPlayerWidget: false,
      audioServiceState: null,
      audioTag: null
    ));
  }

  void _onVisibilityAudioPlayerWidget(BasicAudioEventToggleVisibilityAudioWidget event,Emitter<BasicAudioState> emit)async{
    if(state.isActiveRunning){
      emit(state.copyWith(showAudioPlayerWidget: !state.showAudioPlayerWidget));
    }
  }

  void _onSetSpeed(BasicAudioEventChangeSpeed event,Emitter<BasicAudioState> emit){
    _audioPlayerService.changeSpeed(event.newSpeed);
  }

  void _onSetPosition(BasicAudioEventChangePosition event,Emitter<BasicAudioState> emit){
    _audioPlayerService.changePosition(event.duration);
  }

  void _onSetLoop(BasicAudioEventSetLoop event,Emitter<BasicAudioState> emit){
    _audioPlayerService.setLoop(event.isLoop);
  }

  void _onClearMessage(BasicAudioEventClearMessage event,Emitter<BasicAudioState>emit){
    emit(state.copyWith(message: null));
  }

  void _showMessage(String message,Emitter<BasicAudioState>emit){
    emit(state.copyWith(message: message));
  }


  Future<String?> _getIdentifier(String? identifier)async{
    if(identifier != null) return identifier;
    final selectedEditionResponse = await _editionRepo.getSelectedEdition();
    return selectedEditionResponse.handle<String?>(
      onSuccess: (selectedEdition){
        return selectedEdition?.identifier;
      },
      onError: (error){
        return null;
      }
    );
  }

  Future<void> _startListening({
    required List<int> verseIds,
    required String identifier
  })async{
    for (var verseId in verseIds) {
      final param = ListenAudioParam(identifier: identifier, itemId: verseId, op: QuranAudioOption.verse);
      await _verseAudioRepo.editUnEditedAudios(param);
    }
    _audioPlayerService.playAudiosWithCustom(identifier: identifier,verseIds: verseIds);
  }

}