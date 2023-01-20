import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/repos/audio_edition_repo.dart';
import 'package:hadith/db/repos/verse_audio_editor_repo.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_state.dart';
import 'package:hadith/features/verse/verse_listen_audio/services/quran_audio_foreground_service.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';
import 'package:hadith/models/resource.dart';
import 'package:hadith/services/foreground_service/foreground_service_helper.dart';
import 'package:hadith/utils/i_notification.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerseAudioBloc extends Bloc<IVerseAudioEvent,VerseAudioState>{

  late final VerseAudioRepo _audioRepo;
  late final AudioEditionRepo _editionRepo;
  late final VerseAudioEditorRepo _audioEditorRepo;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  VerseAudioBloc({required VerseAudioRepo audioRepo,required AudioEditionRepo editionRepo,
    required VerseAudioEditorRepo audioEditorRepo}) : super(VerseAudioState.init()){

    _audioRepo = audioRepo;
    _editionRepo = editionRepo;
    _audioEditorRepo = audioEditorRepo;

    on<AudioEventRequestListening>(_onRequestListening,transformer: restartable());
    on<AudioEventResume>(_onResume,transformer: restartable());
    on<AudioEventPause>(_onPause,transformer: restartable());
    on<AudioEventInit>(_onInit);
    on<AudioEventInit2>(_onInit2);
    on<AudioEventRequestOption>(_onRequestOption,transformer: restartable());
    on<AudioEventChangeSpeed>(_onSetSpeed,transformer: restartable());
    on<AudioEventChangePosition>(_onSetPosition,transformer: restartable());
    on<AudioEventSetLoop>(_onSetLoop,transformer: restartable());
    on<AudioEventChangeVisibilityAudioWidget>(_onVisibilityAudioPlayerWidget,transformer: restartable());
    on<AudioEventStop>(_onStop,transformer: restartable());

    add(AudioEventInit());
    add(AudioEventInit2());
  }

  void _onInit(AudioEventInit event,Emitter<VerseAudioState> emit)async{
    final dataStream = QuranAudioForegroundService.getStateStream();
    await emit.forEach<VerseAudioModel?>(dataStream, onData: (data){
      if(data?.error!=null){
        _sendStateMessage(data!.error!, emit);
      }
      return state.copyWith(currentAudio: data,setAudio: true);
    });
  }

  void _onInit2(AudioEventInit2 event,Emitter<VerseAudioState> emit)async{
    await emit.forEach(ForegroundServiceHelper.serviceCloseStream(), onData: (data){
      return state.copyWith(setAudio: true,currentAudio: state.currentAudio?.copyWith(audioEnum: AudioEnum.dispose)
          ,showAudioPlayerWidget: false);
    });
  }


  void _sendStateMessage(String message,Emitter<VerseAudioState> emit){
    emit(state.copyWith(message: message,setMessage: true));
    emit(state.copyWith(setMessage: true,currentAudio: state.currentAudio?.copyWith(setError: true)));
  }

  void _onRequestOption(AudioEventRequestOption event,Emitter<VerseAudioState> emit)async{

    if(!await INotification.checkPermission()){
      final askNotification = _sharedPreferences.getBool(PrefConstants.askNotificationPermission.key) ??
          PrefConstants.askNotificationPermission.defaultValue;

      if(askNotification){
        emit(state.copyWith(askNotificationPermission: true));
        await _sharedPreferences.setBool(PrefConstants.askNotificationPermission.key, false);
        return emit(state.copyWith(askNotificationPermission: false));
      }
      _sendStateMessage("bildirimler kapalıdır. Açmak için uygulamalar ayarından açabilirsiniz", emit);
    }

    final serviceRunning = await ForegroundServiceHelper.isServiceRunning();
    final isAudioActive = serviceRunning && state.isActive();
    final isAudioServiceAvailable =  isAudioActive || (!serviceRunning);

    if(!isAudioServiceAvailable){
      return _sendStateMessage("service zaten açık",emit);
    }

    emit(state.copyWith(showAudioOption: true,tempModel: event.verseModel,setTempData: true,originTag: event.originTag));
    emit(state.copyWith(showAudioOption: false));

  }

  void _onRequestListening(AudioEventRequestListening event,Emitter<VerseAudioState> emit)async{

    emit(state.copyWith(tempModel: state.tempModel,tempOption: event.voiceOption,setTempData: event.voiceOption!=null));

    if(event.isAfterDownloading){
      await Future.delayed(const Duration(seconds: kDelayForStartingServiceInSeconds));
    }

    final serviceRunning = await ForegroundServiceHelper.isServiceRunning();
    final isAudioActive = serviceRunning && state.isActive();
    final isAudioServiceAvailable =  isAudioActive || (!serviceRunning);

    if(!isAudioServiceAvailable){
      return _sendStateMessage("service zaten açık",emit);
    }

    if(state.tempModel==null && state.tempOption==null){
      return _sendStateMessage("bir şeyler yanlış gitti", emit);
    }
    final verseModel = state.tempModel!;
    final option = state.tempOption!;

    final selectedEdition = await _editionRepo.getSelectedEditionResource();

    if(selectedEdition is ResourceSuccess<AudioEdition?>){
      final identifier = selectedEdition.data?.identifier;
      if(identifier!=null){
        final audioParam = AudioParam.fromVerse(verseModel.item, option);
        final isItemExists = await _audioRepo.isVerseAudioExits(audioParam, identifier);
        if(isItemExists){
          final followAudioText = _sharedPreferences.getBool(PrefConstants.audioFollowWithText.key)
              ??PrefConstants.audioFollowWithText.defaultValue;

          await _audioEditorRepo.editUnEditedAudios(identifier, verseModel.item, option);
          await ForegroundServiceHelper.startService();
          await Future.delayed(const Duration(seconds: kDelayForStartingServiceInSeconds));
          QuranAudioForegroundService.startListeningVoices(audioParam,identifier);
          emit(state.copyWith(showAudioPlayerWidget: true,followAudioText: followAudioText));
        }else{
          if(isAudioActive){
            emit(state.copyWith(askInterruptAndDownload:true));
            return emit(state.copyWith(askInterruptAndDownload:false));
          }else{
            emit(state.copyWith(askDownload: true));
            emit(state.copyWith(askDownload: false));
          }
        }
      }else{
        return _sendStateMessage("bir şeyler yanlış gitti",emit);
      }
    }else if(selectedEdition is ResourceError<AudioEdition?>){
      return _sendStateMessage(selectedEdition.error,emit);
    }else{
      return _sendStateMessage("bir şeyler yanlış gitti",emit);
    }

  }

  void _onVisibilityAudioPlayerWidget(AudioEventChangeVisibilityAudioWidget event,Emitter<VerseAudioState> emit)async{
    if(state.isActive()){
      emit(state.copyWith(showAudioPlayerWidget: !state.showAudioPlayerWidget));
    }
  }

  void _onResume(AudioEventResume event,Emitter<VerseAudioState> emit){
    QuranAudioForegroundService.resume();
  }

  void _onPause(AudioEventPause event,Emitter<VerseAudioState> emit){
    QuranAudioForegroundService.pause();
  }

  void _onSetSpeed(AudioEventChangeSpeed event,Emitter<VerseAudioState> emit){
    QuranAudioForegroundService.setSpeed(event.newSpeed);
  }

  void _onSetPosition(AudioEventChangePosition event,Emitter<VerseAudioState> emit){
    QuranAudioForegroundService.setPosition(event.duration);
  }

  void _onSetLoop(AudioEventSetLoop event,Emitter<VerseAudioState> emit){
    QuranAudioForegroundService.setLoop(event.isLoop);
  }

  void _onStop(AudioEventStop event,Emitter<VerseAudioState>emit){
    QuranAudioForegroundService.stopService();
  }

}