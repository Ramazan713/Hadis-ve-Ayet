
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/services/file_service.dart';
import 'package:hadith/core/features/verse_audio/domain/audio_players/i_verse_audio_player.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/listen_audio_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_service_state.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/verse_meal_voice_model.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_audio_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_meal_voice_repo.dart';
import 'package:rxdart/rxdart.dart';

abstract class IVerseAudioServiceManager<T extends IVerseAudioPlayer>{

  @protected
  late final T audioPlayer;

  late final VerseMealVoiceRepo _verseVoiceRepo;
  late final AppPreferences _appPreferences;
  late final VerseAudioRepo _verseAudioRepo;
  late final FileService _fileService;

  final BehaviorSubject<ListenAudioServiceState> _streamResource = BehaviorSubject();

  late final ValueStream<ListenAudioServiceState> broadcastListener;

  StreamSubscription<Duration>? _durationSubs;
  StreamSubscription<Duration>? _positionSubs;


  @protected
  ListenAudioServiceState _state = ListenAudioServiceState.init();

  ListenAudioServiceState get sharedState => _state;


  IVerseAudioServiceManager({
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


  Future<void> playAudiosWithCustom({required String identifier, required List<int> verseIds})async{
    var verseAudioModels = await _verseVoiceRepo.getVerseVoiceModelsWithCustom(identifier: identifier,verseIds: verseIds);
    await _playAudios(verseAudioModels);
  }

  Future<void> playAudios(ListenAudioParam param)async{
    var verseAudioModels = await _verseVoiceRepo.getVerseVoiceModels(param);
    await _playAudios(verseAudioModels);
  }

  Future<void> _playAudios(List<VerseMealVoiceModel> verseAudioModels)async{
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
    await audioPlayer.resume();
    addState(_state.copyWith(audioEnum: ListenAudioEnum.running));
  }
  Future<void> pause()async{
    await audioPlayer.pause();
    addState(_state.copyWith(audioEnum: ListenAudioEnum.pause));
  }

  Future<void> stop()async{
    await audioPlayer.stop();
    addState(_state.copyWith(audioEnum: ListenAudioEnum.idle));
  }

  Future<void> changeSpeed(double speed)async{
    final fixedSpeed = double.parse(speed.toStringAsFixed(1));

    await _appPreferences.setItem(KPref.audioPlayerSpeed, fixedSpeed);
    addState(_state.copyWith(speed: fixedSpeed));
    await audioPlayer.changeSpeed(fixedSpeed);
  }
  Future<void> changePosition(Duration position)async{
    await audioPlayer.changePosition(position);
    addState(_state.copyWith(position: position));
  }

  Future<void> setLoop(bool isLoop)async{
    await audioPlayer.setLoop(isLoop);
    addState(_state.copyWith(isLoop: isLoop));
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