
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
import 'package:hadith/core/features/verse_audio/domain/model/verse_audio_state_manager.dart';
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


  @protected
  ListenAudioStateManager stateManager = ListenAudioStateManager();
  ValueStream<ListenAudioServiceState> get broadcastListener  => stateManager.stateStream;

  StreamSubscription<Duration>? _durationSubs;
  StreamSubscription<Duration>? _positionSubs;


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

    _positionSubs = audioPlayer.positionStream.mapNotNull((e)=>e).listen((event){
      if(event <= stateManager.state.duration){
        stateManager.setNewState(position: event);
      }
    });

    _durationSubs = audioPlayer.durationStream.throttleTime(const Duration(milliseconds: 500),trailing: true).mapNotNull((e)=>e).listen((event) {
      stateManager.setNewState(duration: event);
    });
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
      return stateManager.setNewState(audio: null, setAudio: true, error: "audio file not found",setError: true);
    }
    await _initPlayer();
    await play(verseAudioModels);
  }


  @protected
  Future<void> play(List<VerseMealVoiceModel> items);


  Future<void> start()async{
    await audioPlayer.resume();
  }

  Future<void> resume()async{
    stateManager.setNewState(audioEnum: ListenAudioEnum.running);
    await audioPlayer.resume();
  }

  Future<void> pause()async{
    stateManager.setNewState(audioEnum: ListenAudioEnum.pause);
    await audioPlayer.pause();
  }

  Future<void> stop()async{
    stateManager.setNewState(audioEnum: ListenAudioEnum.idle);
    await audioPlayer.stop();
  }

  Future<void> changeSpeed(double speed)async{
    final fixedSpeed = double.parse(speed.toStringAsFixed(1));
    await _appPreferences.setItem(KPref.audioPlayerSpeed, fixedSpeed);
    stateManager.setNewState(speed: fixedSpeed);
    await audioPlayer.changeSpeed(fixedSpeed);
  }
  Future<void> changePosition(Duration position)async{
    stateManager.setNewState(position: position);
    await audioPlayer.changePosition(position);
  }

  Future<void> setLoop(bool isLoop)async{
    stateManager.setNewState(isLoop: isLoop);
    await audioPlayer.setLoop(isLoop);
  }

  Future<void> setFinish()async{
    stateManager.setNewState(audioEnum: ListenAudioEnum.finish);
  }

  Future<void>dispose()async{
    await _positionSubs?.cancel();
    await _durationSubs?.cancel();
    await audioPlayer.release();
    await stateManager.dispose();
  }

  @protected
  Future<List<File>> getFiles(List<VerseMealVoiceModel> items)async{
    return _fileService.getFilesFromFileNames(items.map((e) => e.fileName??"").toList());
  }
}