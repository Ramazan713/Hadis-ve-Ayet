
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/services/file_service.dart';
import 'package:hadith/features/verses/shared/domain/audio_players/i_verse_audio_player.dart';

import 'package:hadith/features/verses/shared/domain/enums/listen_audio_enum.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_audio_repo.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_meal_voice_repo.dart';
import 'package:rxdart/rxdart.dart';

abstract class IVerseAudioService<T extends IVerseAudioPlayer>{

  @protected
  late final T audioPlayer;

  late final VerseMealVoiceRepo _verseVoiceRepo;
  late final AppPreferences _appPreferences;
  late final VerseAudioRepo _verseAudioRepo;
  late final FileService _fileService;

  final BehaviorSubject<ListenAudioServiceState> _streamResource = BehaviorSubject();

  late final ValueStream<ListenAudioServiceState>? broadcastListener;

  StreamSubscription<Duration>? _durationSubs;
  StreamSubscription<Duration>? _positionSubs;


  @protected
  ListenAudioServiceState _state = ListenAudioServiceState.init();

  ListenAudioServiceState get sharedState => _state;


  IVerseAudioService({
    required T audioPlay,
    required VerseMealVoiceRepo verseVoiceRepo,
    required VerseAudioRepo verseAudioRepo,
    required AppPreferences appPreferences,
    required FileService fileService
  }){

    audioPlayer = audioPlay;
    _appPreferences = appPreferences;
    _verseVoiceRepo = verseVoiceRepo;
    _verseAudioRepo = verseAudioRepo;
    _fileService = fileService;

    broadcastListener = _streamResource.stream;

    _positionSubs = audioPlayer.positionStream.mapNotNull((e)=>e).listen((event){
      if(event <= _state.duration){
        addState(_state.copyWith(position: event));
      }
    });

    _durationSubs = audioPlayer.durationStream.mapNotNull((e)=>e).listen((event) {
      addState(_state.copyWith(duration: event));
    });
  }

  @protected
  void addState(ListenAudioServiceState newState){
    _state = newState;
    _streamResource.add(_state);
  }

  Future<void> _initPlayer()async{
    final speed = _appPreferences.getItem(KPref.audioPlayerSpeed);
    await changeSpeed(speed);
  }



  Future<void> playAudios(ListenAudioParam param)async{
    var verseAudioModels = await _verseVoiceRepo.getVerseVoiceModels(param);

    final isValid = await _verseAudioRepo.validateVerseAudios(verseAudios: verseAudioModels);

    if(!isValid){
      return addState(_state.copyWith(audio: null, setAudio: true, error: "audio file not found",setError: true));
    }

    await _initPlayer();
    await play(verseAudioModels);
  }

  @protected
  Future<void> play(List<VerseMealVoiceModel> items);

  Future<void> resume()async{
    addState(_state.copyWith(audioEnum: ListenAudioEnum.running));
    await audioPlayer.resume();
  }
  Future<void> pause()async{
    addState(_state.copyWith(audioEnum: ListenAudioEnum.pause));
    await audioPlayer.pause();
  }

  Future<void> stop()async{
    addState(_state.copyWith(audioEnum: ListenAudioEnum.idle));
    await audioPlayer.stop();
  }

  Future<void> changeSpeed(double speed)async{
    final fixedSpeed = double.parse(speed.toStringAsFixed(1));

    await _appPreferences.setItem(KPref.audioPlayerSpeed, fixedSpeed);
    addState(_state.copyWith(speed: fixedSpeed));
    await audioPlayer.changeSpeed(fixedSpeed);
  }
  Future<void> changePosition(Duration position)async{
    addState(_state.copyWith(position: position));
    await audioPlayer.changePosition(position);
  }

  Future<void> setLoop(bool isLoop)async{
    addState(_state.copyWith(isLoop: isLoop));
    await audioPlayer.setLoop(isLoop);
  }

  Future<void> setFinish()async{
    addState(_state.copyWith(audioEnum: ListenAudioEnum.finish));
  }

  Future<void>dispose()async{
    await _positionSubs?.cancel();
    await _durationSubs?.cancel();
    await audioPlayer.release();
    await _streamResource.close();
  }

  @protected
  Future<List<File>> getFiles(List<VerseMealVoiceModel> items)async{
    return _fileService.getFilesFromFileNames(items.map((e) => e.fileName??"").toList());
  }
}