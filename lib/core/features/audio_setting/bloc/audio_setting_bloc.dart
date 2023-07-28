
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/models/resource.dart';

import 'audio_setting_event.dart';
import 'audio_setting_state.dart';

class AudioSettingBloc extends Bloc<IAudioSettingEvent,AudioSettingState>{

  late final AppPreferences _appPreferences;
  late final EditionRepo _editionRepo;

  AudioSettingBloc({
    required EditionRepo editionRepo,
    required AppPreferences appPreferences
  }) : super(AudioSettingState.init()){

    _editionRepo = editionRepo;
    _appPreferences = appPreferences;

    on<AudioSettingEventSelectedEditionListener>(_onSelectedEditionListener);
    on<AudioSettingEventSetSpeed>(_onSetSpeed);
    on<AudioSettingEventSetFollowAudio>(_onSetFollowAudio);
    on<AudioSettingEventLoadData>(_onLoadData);

    add(AudioSettingEventSelectedEditionListener());
  }

  void _onLoadData(AudioSettingEventLoadData event,Emitter<AudioSettingState>emit)async{
    final audioSpeed = _appPreferences.getItem(KPref.audioPlayerSpeed);
    final followAudio = _appPreferences.getItem(KPref.audioFollowWithText);
    AudioEdition? selectedEdition;

    final editionResult = await _editionRepo.getSelectedEdition();
    if(editionResult is ResourceSuccess<AudioEdition?>){
      selectedEdition = editionResult.data;
    }

    emit(state.copyWith(
      audioSpeed: audioSpeed,
      followAudioText: followAudio,
      setSelectedEdition: true,
      selectedEdition: selectedEdition
    ));
  }


  void _onSelectedEditionListener(AudioSettingEventSelectedEditionListener event,Emitter<AudioSettingState>emit) async{
    final streamData = _editionRepo.getSelectedStreamEdition();

    await emit.forEach<AudioEdition?>(streamData, onData: (edition)=>
        state.copyWith(
            selectedEdition: edition,
            setSelectedEdition: true
        ));
  }

  void _onSetSpeed(AudioSettingEventSetSpeed event,Emitter<AudioSettingState>emit)async{
    final fixedSpeed = double.parse(event.speed.toStringAsFixed(1));

    await _appPreferences.setItem(KPref.audioPlayerSpeed, fixedSpeed);
    emit(state.copyWith(audioSpeed: fixedSpeed));
  }

  void _onSetFollowAudio(AudioSettingEventSetFollowAudio event,Emitter<AudioSettingState>emit)async{
    await _appPreferences.setItem(KPref.audioFollowWithText, event.audioFollowText);
    emit(state.copyWith(followAudioText: event.audioFollowText));
  }
}