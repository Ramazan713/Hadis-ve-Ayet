import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/use_cases/save_point/save_point_use_cases.dart';
import 'package:hadith/features/verses/shared/data/mapper/param_mapper.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/manager/background_verse_audio_manager.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/features/verses/shared/domain/model/service_audio/background_event.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/audio_listen_event.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/features/verses/shared/domain/model/select_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/notification/i_verse_listen_audio_notification.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_audio_repo.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/listen_audio_dialog_event.dart';
import 'package:hadith/features/verses/shared/presentation/models/audio_param_builder.dart';
import 'package:hadith/models/resource.dart';
import 'package:rxdart/rxdart.dart';

import 'verse_audio_event.dart';
import 'verse_audio_state.dart';

class ListenVerseAudioBloc extends Bloc<IListenVerseAudioEvent,ListenVerseAudioState>{

  late final VerseAudioRepo _audioRepo;
  late final EditionRepo _editionRepo;
  late final AppPreferences _appPreferences;
  late final IVerseListenAudioNotification _notification;
  late final SavePointUseCases _savePointUseCases;


  ListenVerseAudioBloc({
    required VerseAudioRepo audioRepo,
    required EditionRepo editionRepo,
    required AppPreferences appPreferences,
    required IVerseListenAudioNotification notification,
    required SavePointUseCases savePointUseCases
  }) : super(ListenVerseAudioState.init()){

    _audioRepo = audioRepo;
    _editionRepo = editionRepo;
    _appPreferences = appPreferences;
    _notification = notification;
    _savePointUseCases = savePointUseCases;

    on<ListenAudioEventResume>(_onResume,transformer: restartable());
    on<ListenAudioEventPause>(_onPause,transformer: restartable());
    on<ListenAudioEventStop>(_onStop,transformer: restartable());
    on<ListenAudioEventSetSavePointId>(_onSetSavepointId,transformer: restartable());
    on<ListenAudioEventChangeSpeed>(_onSetSpeed,transformer: restartable());
    on<ListenAudioEventChangePosition>(_onSetPosition,transformer: restartable());
    on<ListenAudioEventSetLoop>(_onSetLoop,transformer: restartable());

    on<ListenAudioEventClearMessage>(_onClearMessage, transformer: restartable());
    on<ListenAudioEventClearDialogEvent>(_onClearDialogEvent, transformer: restartable());
    on<ListenAudioEventSelectedSavePointListener>(_onSelectedSavePointListener);
    on<ListenAudioEventToggleVisibilityAudioWidget>(_onVisibilityAudioPlayerWidget,transformer: restartable());

    on<ListenAudioEventStartListeningWithVerse>(_onStartListeningWithVerse, transformer: restartable());
    on<ListenAudioEventStartListeningWithParam>(_onStartListeningWithParam, transformer: restartable());
    on<ListenAudioEventListeningBuilder>(_onStartListeningBuilder, transformer: restartable());
    on<ListenAudioEventHandleOption>(_onHandleOption, transformer: restartable());
    on<ListenAudioEventHandleAfterDownloading>(_onHandleAfterDownloading, transformer: restartable());

    on<ListenAudioEventStateListener>(_onStateListener);
    on<ListenAudioEventAppPreferenceListener>(_onAppPreferenceListener);
    on<ListenAudioEventCancelServiceListener>(_onCancelServiceListener);


    add(ListenAudioEventStateListener());
    add(ListenAudioEventCancelServiceListener());
    add(ListenAudioEventSelectedSavePointListener());
    add(ListenAudioEventAppPreferenceListener());
  }


  void _onStartListeningWithVerse(ListenAudioEventStartListeningWithVerse event,Emitter<ListenVerseAudioState> emit)async {

    final paramBuilder = const AudioParamBuilder().copyWith(
      setStartVerseId: true,
      startVerseId: event.verse.id,
      setVerse: true,
      verse: event.verse,
      checkNotification: state.audioParamBuilder.checkNotification
    );
    emit(state.copyWith(audioParamBuilder: paramBuilder));

    add(ListenAudioEventListeningBuilder());
  }

  void _onStartListeningWithParam(ListenAudioEventStartListeningWithParam event,Emitter<ListenVerseAudioState> emit)async{
    emit(state.copyWith(audioParamBuilder: event.paramBuilder));
    add(ListenAudioEventListeningBuilder());
  }


  void _onStartListeningBuilder(ListenAudioEventListeningBuilder event,Emitter<ListenVerseAudioState> emit)async{
    var paramBuilder = state.audioParamBuilder;

    if(paramBuilder.checkNotification){
      final hasNotificationPermission = await _notification.checkPermission();
      if(!hasNotificationPermission){
        final askNotification = _appPreferences.getItem(KPref.askListenAudioNotificationPermission);
        if(askNotification){
          _appPreferences.setItem(KPref.askListenAudioNotificationPermission, false);
          return emit(state.copyWith(
            audioParamBuilder: paramBuilder.copyWith(
              checkNotification: false
            ),
            setDialogEvent: true,
            dialogEvent: ListenAudioDialogEventRequestPermission()
          ));
        }else{
          _sendStateMessage("bildirimler kapalıdır. Açmak için uygulamalar ayarından açabilirsiniz", emit);
        }
      }
      paramBuilder = paramBuilder.copyWith(checkNotification: false);
      emit(state.copyWith(audioParamBuilder: paramBuilder));
    }

    if(!paramBuilder.hasOption){
      return emit(state.copyWith(
          setDialogEvent: true,
          dialogEvent: ListenAudioDialogEventShowOption(
            selectAudioOption: SelectAudioOption.cuz
          )
      ));
    }

    if(!paramBuilder.hasIdentifier){
      final selectedEditionResponse = await _editionRepo.getSelectedEdition();

      if(selectedEditionResponse is ResourceSuccess<AudioEdition?>){
        final identifier = selectedEditionResponse.data?.identifier;
        if(identifier==null){
          return _sendStateMessage("bir şeyler yanlış gitti",emit);
        }
        paramBuilder = paramBuilder.copyWith(
          identifier: identifier,
          setIdentifier: true
        );
        emit(state.copyWith(audioParamBuilder: paramBuilder));
      }else if(selectedEditionResponse is ResourceError<AudioEdition?>){
        return _sendStateMessage(selectedEditionResponse.error,emit);
      }else{
        return _sendStateMessage("bir şeyler yanlış gitti",emit);
      }
    }

    final audioParam = paramBuilder.toListenAudioParam();

    if(audioParam==null) return _sendStateMessage("bir şeyler yanlış gitti", emit);

    final isItemsExists = await _audioRepo.hasVerseAudios(audioParam);

    if(isItemsExists){
      await _audioRepo.editUnEditedAudios(audioParam);
      emit(state.copyWith(showAudioPlayerWidget: true));
      BackgroundVerseAudioManager.onEvent(BackgroundEventStartListenAudio(audioParam: audioParam));
    }else{

      final qualityEnum = _appPreferences.getEnumItem(KPref.audioQualityEnum);
      final downloadParam = audioParam.toDownloadAudioParam(qualityEnum: qualityEnum);

      if(state.isActiveRunning){
        emit(state.copyWith(
            dialogEvent: ListenAudioDialogEventInterruptAndReDownload(downloadParam: downloadParam),
            setDialogEvent: true,
            setExpectedListenParam: true,
            expectedListenParam: audioParam,

        ));
      }else{
        emit(state.copyWith(
            dialogEvent: ListenAudioDialogEventAskDownload(downloadParam: downloadParam),
            setDialogEvent: true,
            setExpectedListenParam: true,
            expectedListenParam: audioParam
        ));
      }
    }
  }

  void _onHandleOption(ListenAudioEventHandleOption event,Emitter<ListenVerseAudioState> emit)async{

    final paramBuilder = state.audioParamBuilder.copyWith(
      setOption: true,
      op: event.op
    );
    emit(state.copyWith(audioParamBuilder: paramBuilder));

    add(ListenAudioEventListeningBuilder());
  }

  void _onHandleAfterDownloading(ListenAudioEventHandleAfterDownloading event,Emitter<ListenVerseAudioState> emit)async{
    if(state.expectedListenParam == event.listenAudioParam){
      final paramBuilder = event.listenAudioParam.toAudioParamBuilder();

      emit(state.copyWith(
        audioParamBuilder: paramBuilder,
        setExpectedListenParam: true
      ));
      add(ListenAudioEventListeningBuilder());
    }
  }

  void _onVisibilityAudioPlayerWidget(ListenAudioEventToggleVisibilityAudioWidget event,Emitter<ListenVerseAudioState> emit)async{
    if(state.isActiveRunning){
      emit(state.copyWith(showAudioPlayerWidget: !state.showAudioPlayerWidget));
    }
  }

  void _onStateListener(ListenAudioEventStateListener event,Emitter<ListenVerseAudioState> emit)async{
    final dataStream = BackgroundVerseAudioManager.getListenAudioData();
    await emit.forEach<ListenAudioServiceState?>(dataStream, onData: (data){
      if(data?.error!=null){
        _sendStateMessage(data!.error!, emit);
      }
      return state.copyWith(serviceState: data, setServiceState: true);
    });
  }

  void _onCancelServiceListener(ListenAudioEventCancelServiceListener event,Emitter<ListenVerseAudioState> emit)async{
    final streamActiveServiceData = BackgroundVerseAudioManager.getActiveServices();

    await emit.forEach(streamActiveServiceData, onData: (activeServices){
      if(!activeServices.contains(AudioServiceEnum.listenAudio)){
        return state.copyWith(
            showAudioPlayerWidget: false,
            setServiceState: true
        );
      }
      return state;
    });
  }

  void _onAppPreferenceListener(ListenAudioEventAppPreferenceListener event,Emitter<ListenVerseAudioState> emit)async{
    final streamData = _appPreferences.listenerFiltered([KPref.audioFollowWithText],initValue: KPref.audioFollowWithText);

    await emit.forEach(streamData, onData: (key){
      final audioFollowWithText = _appPreferences.getItem(KPref.audioFollowWithText);
      return state.copyWith(followAudioText: audioFollowWithText);
    });

  }

  void _onSelectedSavePointListener(ListenAudioEventSelectedSavePointListener event,Emitter<ListenVerseAudioState> emit)async{
    final streamSelectedSavePointId = BackgroundVerseAudioManager.getListenAudioSelectedSavePointId();

    final streamData = streamSelectedSavePointId.distinct().switchMap<int?>((value){
      if(value == null) return Stream<int?>.value(null);
      return _savePointUseCases.getSavePoints.callById(id: value).map((e) => e?.id);
    }).distinct();

    await emit.forEach<int?>(streamData, onData: (id){
      add(ListenAudioEventSetSavePointId(savepointId: id));
      return state.copyWith(
        setSelectedSavePointId: true,
        selectedSavePointId: id
      );
    });
  }

  void _onClearMessage(ListenAudioEventClearMessage event,Emitter<ListenVerseAudioState> emit){
    emit(state.copyWith(setMessage: true));
  }

  void _onClearDialogEvent(ListenAudioEventClearDialogEvent event,Emitter<ListenVerseAudioState> emit){
    emit(state.copyWith(setDialogEvent: true));
  }

  void _sendStateMessage(String message,Emitter<ListenVerseAudioState> emit){
    emit(state.copyWith(message: message,setMessage: true));
  }

  void _onResume(ListenAudioEventResume event,Emitter<ListenVerseAudioState> emit){
    BackgroundVerseAudioManager.onListenAudioEvent(AudioListenEventResume());
  }

  void _onPause(ListenAudioEventPause event,Emitter<ListenVerseAudioState> emit){
    BackgroundVerseAudioManager.onListenAudioEvent(AudioListenEventPause());
  }

  void _onSetSpeed(ListenAudioEventChangeSpeed event,Emitter<ListenVerseAudioState> emit){
    BackgroundVerseAudioManager.onListenAudioEvent(AudioListenEventSetSpeed(speed: event.newSpeed));
  }

  void _onSetPosition(ListenAudioEventChangePosition event,Emitter<ListenVerseAudioState> emit){
    BackgroundVerseAudioManager.onListenAudioEvent(AudioListenEventSetPosition(duration: event.duration));
  }

  void _onSetSavepointId(ListenAudioEventSetSavePointId event,Emitter<ListenVerseAudioState> emit)async{
    BackgroundVerseAudioManager.onListenAudioEvent(AudioListenEventSetSavePoint(savePointId: event.savepointId));
  }

  void _onSetLoop(ListenAudioEventSetLoop event,Emitter<ListenVerseAudioState> emit){
    BackgroundVerseAudioManager.onListenAudioEvent(AudioListenEventSetLoop(loop: event.isLoop));
  }

  void _onStop(ListenAudioEventStop event,Emitter<ListenVerseAudioState>emit){
    BackgroundVerseAudioManager.onEvent(BackgroundEventStopListenAudio());
  }

}