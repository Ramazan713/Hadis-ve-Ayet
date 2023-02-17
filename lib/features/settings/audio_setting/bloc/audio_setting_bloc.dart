

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/repos/audio_edition_repo.dart';
import 'package:hadith/features/settings/audio_setting/bloc/audio_setting_event.dart';
import 'package:hadith/features/settings/audio_setting/bloc/audio_setting_state.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioSettingBloc extends Bloc<IAudioSettingEvent,AudioSettingState>{

  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;
  late final AudioEditionRepo _editionRepo;

  AudioSettingBloc({required AudioEditionRepo editionRepo}) : super(AudioSettingState.init()){

    _editionRepo = editionRepo;

    on<AudioSettingEventInit>(_onInit);
    on<AudioSettingEventSetSpeed>(_onSetSpeed);
    on<AudioSettingEventSetFollowAudio>(_onSetFollowAudio);
    on<AudioSettingEventGetShared>(_onGetShared);

    add(AudioSettingEventInit());
  }


  void _emitSharedValues(Emitter<AudioSettingState>emit){

    final audioFollowText = _sharedPreferences.getBool(PrefConstants.audioFollowWithText.key) ??
        PrefConstants.audioFollowWithText.defaultValue;

    final audioSpeed = _sharedPreferences.getDouble(PrefConstants.audioPlayerSpeed.key) ?? PrefConstants.audioPlayerSpeed.defaultValue;
    emit(state.copyWith(audioSpeed: audioSpeed,followAudioText: audioFollowText));
  }

  void _onInit(AudioSettingEventInit event,Emitter<AudioSettingState>emit)async{
    _emitSharedValues(emit);

    await emit.forEach<AudioEdition?>(_editionRepo.getSelectedStreamEdition(), onData: (edition)=>
        state.copyWith(audioEdition: edition,setEdition: true));
  }

  void _onGetShared(AudioSettingEventGetShared event,Emitter<AudioSettingState>emit)async{
    _emitSharedValues(emit);
  }

  void _onSetSpeed(AudioSettingEventSetSpeed event,Emitter<AudioSettingState>emit)async{
    final fixedSpeed = double.parse(event.speed.toStringAsFixed(1));
    await _sharedPreferences.setDouble(PrefConstants.audioPlayerSpeed.key, fixedSpeed);
    emit(state.copyWith(audioSpeed: fixedSpeed));

  }

  void _onSetFollowAudio(AudioSettingEventSetFollowAudio event,Emitter<AudioSettingState>emit)async{
    await _sharedPreferences.setBool(PrefConstants.audioFollowWithText.key, event.audioFollowText);
    emit(state.copyWith(followAudioText: event.audioFollowText));
  }




}