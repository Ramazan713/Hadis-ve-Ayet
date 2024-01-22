
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';
import 'package:hadith/core/features/verse_audio/data/mapper/param_mapper.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_service_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/background_verse_audio_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/audio_download_event.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_manager_state.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';
import 'package:hadith/core/features/verse_audio/domain/model/service_audio/background_event.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/i_verse_download_audio_notification.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_audio_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/model/audio_param_builder.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_dialog_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_state.dart';
import 'package:hadith/core/utils/resource.dart';

class DownloadAudioBloc extends Bloc<IDownloadAudioEvent,DownloadAudioState>{

  late final ConnectivityService _connectivityService;
  late final EditionRepo _editionRepo;
  late final VerseAudioRepo _audioRepo;
  late final AppPreferences _appPreferences;
  late final IVerseDownloadAudioNotification _notification;

  DownloadAudioBloc({
    required ConnectivityService connectivityService,
    required EditionRepo editionRepo,
    required VerseAudioRepo audioRepo,
    required AppPreferences appPreferences,
    required IVerseDownloadAudioNotification notification
  }) : super(DownloadAudioState.init()){

    _connectivityService = connectivityService;
    _editionRepo = editionRepo;
    _audioRepo = audioRepo;
    _appPreferences = appPreferences;
    _notification = notification;

    on<DownloadAudioEventStartDownloadingWithParam>(_onStartDownloadingWithParam, transformer: restartable());
    on<DownloadAudioEventDownloadBuilder>(_onDownloadBuilder, transformer: restartable());
    on<DownloadAudioEventStartDownloadingWithVerse>(_onStartDownloadingWithVerse, transformer: restartable());
    on<DownloadAudioEventStartDownloadingWithBuilder>(_onStartDownloadingWithBuilder, transformer: restartable());
    on<DownloadAudioEventHandleOption>(_onHandleOption, transformer: restartable());

    on<DownloadAudioEventClearDialogEvent>(_onClearDialogEvent, transformer: restartable());
    on<DownloadAudioEventClearMessage>(_onClearMessage, transformer: restartable());
    on<DownloadAudioEventClearLastDownloadedParam>(_onClearLastDownloadedParam, transformer: restartable());

    on<DownloadAudioEventListener>(_onListener);
    on<DownloadAudioEventCancelServiceListener>(_onCancelServiceListener);
    on<DownloadAudioEventResume>(_onResume, transformer: restartable());
    on<DownloadAudioEventPause>(_onPause, transformer: restartable());
    on<DownloadAudioEventCancel>(_onCancel, transformer: restartable());
    on<DownloadAudioEventRetry>(_onRetry, transformer: restartable());

    add(DownloadAudioEventListener());
    add(DownloadAudioEventCancelServiceListener());
  }


  void _onStartDownloadingWithParam(DownloadAudioEventStartDownloadingWithParam event,Emitter<DownloadAudioState>emit)async{

    if(!await _connectivityService.hasConnected){
      return _sendMessage("internet bağlantınızı kontrol edin", emit);
    }
    BackgroundVerseAudioManager.onEvent(BackgroundEventStartDownloadAudio(audioDownloadParam: event.downloadParam));
  }

  void _onStartDownloadingWithVerse(DownloadAudioEventStartDownloadingWithVerse event,Emitter<DownloadAudioState>emit)async{
    final paramBuilder = const AudioParamBuilder().copyWith(
      setStartVerseId: true,
      startVerseId: event.verse.id,
      setVerse: true,
      verse: event.verse,
      selectAudioOption: event.selectAudioOption
    );
    emit(state.copyWith(audioParamBuilder: paramBuilder));

    add(DownloadAudioEventDownloadBuilder());
  }

  void _onStartDownloadingWithBuilder(DownloadAudioEventStartDownloadingWithBuilder event,Emitter<DownloadAudioState>emit)async{
    emit(state.copyWith(audioParamBuilder: event.paramBuilder));
    add(DownloadAudioEventDownloadBuilder());
  }

  void _onHandleOption(DownloadAudioEventHandleOption event,Emitter<DownloadAudioState>emit)async{
    final paramBuilder = state.audioParamBuilder.copyWith(
        setOption: true,
        op: event.op
    );
    emit(state.copyWith(audioParamBuilder: paramBuilder));

    add(DownloadAudioEventDownloadBuilder());
  }


  void _onDownloadBuilder(DownloadAudioEventDownloadBuilder event,Emitter<DownloadAudioState>emit)async{

    if(!await _connectivityService.hasConnected){
      return _sendMessage("internet bağlantınızı kontrol edin", emit);
    }

    var paramBuilder = state.audioParamBuilder;

    if(paramBuilder.checkNotification){
      paramBuilder = paramBuilder.copyWith(checkNotification: false);
      emit(state.copyWith(audioParamBuilder: paramBuilder));

      final hasNotificationPermission = await _notification.checkPermission();
      if(!hasNotificationPermission){
        final askNotification = _appPreferences.getItem(KPref.askDownloadAudioNotificationPermission);
        if(askNotification){
          _appPreferences.setItem(KPref.askDownloadAudioNotificationPermission, false);
          return emit(state.copyWith(
              setDialogEvent: true,
              dialogEvent: DownloadAudioDialogEventRequestPermission()
          ));
        }else{
          _sendStateMessage("bildirimler kapalıdır. Açmak için uygulamalar ayarından açabilirsiniz", emit);
        }
      }

    }

    if(!paramBuilder.hasOption){
      return emit(state.copyWith(
          setDialogEvent: true,
          dialogEvent: DownloadAudioDialogEventShowOption(selectAudioOption: paramBuilder.selectAudioOption)
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

    final audioQuality = _appPreferences.getEnumItem(KPref.audioQualityEnum);
    final audioParam = paramBuilder.toDownloadAudioParam(audioQualityEnum: audioQuality);
    if(audioParam == null) return _sendStateMessage("bir şeyler yanlış gitti", emit);

    final isItemsExists = await _audioRepo.hasVerseAudios(audioParam.toListenAudioParam());
    if(isItemsExists) return _sendStateMessage("zaten indirilmiş", emit);

    BackgroundVerseAudioManager.onEvent(BackgroundEventStartDownloadAudio(audioDownloadParam: audioParam));
    _sendStateMessage("indirme listesine eklendi",emit);
  }

  void _onListener(DownloadAudioEventListener event,Emitter<DownloadAudioState>emit)async{
    final streamData = BackgroundVerseAudioManager.getDownloadAudioData();

    await emit.forEach<DownloadAudioManagerState?>(streamData, onData: (serviceState){

      return state.copyWith(
          setServiceState: true,
          serviceState: serviceState,
          setLastDownloadedParam: serviceState?.downloadEnum.isAnySuccess ?? false,
          lastDownloadedParam: serviceState?.lastDownloaded
      );
    });
  }

  void _onCancelServiceListener(DownloadAudioEventCancelServiceListener event,Emitter<DownloadAudioState> emit)async{
    final streamActiveServiceData = BackgroundVerseAudioManager.getActiveServices();

    await emit.forEach(streamActiveServiceData, onData: (activeServices){
      if(!activeServices.contains(AudioServiceEnum.downloadAudio)){
        return state.copyWith(
            setServiceState: true
        );
      }
      return state;
    });
  }


  void _onResume(DownloadAudioEventResume event,Emitter<DownloadAudioState>emit)async{
    BackgroundVerseAudioManager.onDownloadAudioEvent(AudioDownloadEventResume());
  }

  void _onPause(DownloadAudioEventPause event,Emitter<DownloadAudioState>emit)async{
    BackgroundVerseAudioManager.onDownloadAudioEvent(AudioDownloadEventPause());
  }

  void _onCancel(DownloadAudioEventCancel event,Emitter<DownloadAudioState>emit)async{
    BackgroundVerseAudioManager.onDownloadAudioEvent(AudioDownloadEventCancel());
  }

  void _onRetry(DownloadAudioEventRetry event,Emitter<DownloadAudioState>emit)async{
    BackgroundVerseAudioManager.onDownloadAudioEvent(AudioDownloadEventRetry());
  }

  void _onClearMessage(DownloadAudioEventClearMessage event,Emitter<DownloadAudioState>emit){
    emit(state.copyWith(setMessage: true));
  }

  void _onClearDialogEvent(DownloadAudioEventClearDialogEvent event,Emitter<DownloadAudioState>emit)async{
    emit(state.copyWith(setDialogEvent: true));
  }

  void _onClearLastDownloadedParam(DownloadAudioEventClearLastDownloadedParam event,Emitter<DownloadAudioState>emit)async{
    emit(state.copyWith(setLastDownloadedParam: true));
  }

  void _sendMessage(String message,Emitter<DownloadAudioState>emit){
    emit(state.copyWith(message: message,setMessage: true));
  }


  void _sendStateMessage(String message,Emitter<DownloadAudioState> emit){
    emit(state.copyWith(message: message,setMessage: true));
  }


}