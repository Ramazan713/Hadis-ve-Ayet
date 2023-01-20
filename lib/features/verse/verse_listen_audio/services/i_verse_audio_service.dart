import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/db/entities/verse_audio.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/db/repos/verse_audio_state_repo.dart';
import 'package:hadith/features/verse/verse_download_audio/models/audio_param.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/db/entities/helper/verse_audio_entity.dart';
import 'package:hadith/features/verse/verse_listen_audio/audio_players/i_verse_audio_play.dart';
import 'package:hadith/features/verse/verse_listen_audio/models/verse_audio_model.dart';
import 'package:hadith/features/verse/verse_listen_audio/audio_players/verse_justaudios_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IVerseAudioService<T extends IVerseAudioPlay>{

  @protected
  late final T _audioPlay;

  @protected
  late final VerseAudioRepo _verseAudioRepo;

  @protected
  late final VerseAudioStateRepo _verseAudioStateRepo;

  @protected
  final BehaviorSubject<VerseAudioModel> _streamResource = BehaviorSubject();

  late final ValueStream<VerseAudioModel>?broadcastListener;

  StreamSubscription<Duration>?_durationSubs;
  StreamSubscription<Duration>?_positionSubs;

  late final SharedPreferences _sharedPreferences;

  @protected
  VerseAudioModel _state = VerseAudioModel.init();

  IVerseAudioService({required T audioPlay,required VerseAudioRepo verseAudioRepo,
    required VerseAudioStateRepo verseAudioStateRepo,required SharedPreferences sharedPreferences}){

    _sharedPreferences = sharedPreferences;
    _audioPlay = audioPlay;
    _verseAudioRepo = verseAudioRepo;
    _verseAudioStateRepo = verseAudioStateRepo;
    broadcastListener = _streamResource.stream;

    _positionSubs = _audioPlay.positionStream.mapNotNull((e)=>e).listen((event){
      if(event<=_state.duration){
        _addState(_state.copyWith(position: event));
      }
    });

    _durationSubs = _audioPlay.durationStream.mapNotNull((e)=>e).listen((event) {
      _addState(_state.copyWith(duration: event));
    });
  }

  Future<void> _initPlayer()async{
    final speed=_sharedPreferences.getDouble(PrefConstants.audioPlayerSpeed.key)??PrefConstants.audioPlayerSpeed.defaultValue;
    await changeSpeed(speed);
  }


  @protected
  void _addState(VerseAudioModel newState){
    _state = newState;
    _streamResource.add(_state);
  }

  Future<void>playAudios(AudioParam audioParam,String identifier)async{
    var verseAudioModels = await _verseAudioStateRepo.getStateAudioVerses(audioParam,identifier);

    final isValid = await _verseAudioRepo.validateVerseAudiosAndRemove(verseAudioModels);

    if(!isValid){
      return _addState(_state.copyWith(audioEnum: AudioEnum.dispose,audio: null,setModel: true,error: "audio file not found",setError: true));
    }

    final currentIndex = verseAudioModels.indexWhere((element) => element.mealId == audioParam.mealId);
    if(currentIndex!=-1){
      verseAudioModels = verseAudioModels.sublist(currentIndex,verseAudioModels.length);
    }
    await _initPlayer();
    await _play(verseAudioModels,currentIndex!=-1?currentIndex:0);
  }

  Future<List<File>> _getFiles(List<VerseAudioEntity> items)async{
    try{
      final appDic = await VerseAudio.appDocDirPath();

      final files = items.map((e) => VerseAudio.getAudioFileWithDir(appDic,e.fileName??"")).toList();
      return files;
    }catch(e){
      _addState(_state.copyWith(audioEnum: AudioEnum.dispose,audio: null,
          setModel: true,error: "beklenmeyen hata",setError: true));
    }
    return [];
  }

  Future<void>_play(List<VerseAudioEntity> items,int initialIndex);

  Future<void> resume()async{
    _addState(_state.copyWith(audioEnum: AudioEnum.running));
    await _audioPlay.resume();
  }
  Future<void> pause()async{
    _addState(_state.copyWith(audioEnum: AudioEnum.pause));
    await _audioPlay.pause();
  }

  Future<void> stop()async{
    _addState(_state.copyWith(audioEnum: AudioEnum.idle));
    await _audioPlay.stop();
  }

  Future<void> changeSpeed(double speed)async{
    final fixedSpeed = double.parse(speed.toStringAsFixed(1));
    await _sharedPreferences.setDouble(PrefConstants.audioPlayerSpeed.key, fixedSpeed);
    _addState(_state.copyWith(speed: fixedSpeed));
    await _audioPlay.changeSpeed(fixedSpeed);
  }
  Future<void> changePosition(Duration position)async{
    _addState(_state.copyWith(position: position));
    await _audioPlay.changePosition(position);
  }

  Future<void> setLoop(bool isLoop)async{
    _addState(_state.copyWith(isLoop: isLoop));
    await _audioPlay.setLoop(isLoop);
  }

  Future<void> setFinish()async{
    _addState(_state.copyWith(audioEnum: AudioEnum.finish));
  }

  Future<void>dispose()async{
    await _positionSubs?.cancel();
    await _durationSubs?.cancel();
    await _audioPlay.release();
    await _streamResource.close();
  }
}

class VerseAudioJustService extends IVerseAudioService<VerseJustAudioPlayer>{

  StreamSubscription<int?>?_subsCurrentIndex;
  StreamSubscription<ProcessingState>?_subsPlayerState;


  VerseAudioJustService({required VerseAudioRepo verseAudioRepo,
    required SharedPreferences sharedPreferences,
    required VerseAudioStateRepo verseAudioStateRepo}) :
        super(audioPlay: VerseJustAudioPlayer(),
          verseAudioRepo: verseAudioRepo, verseAudioStateRepo: verseAudioStateRepo,sharedPreferences:sharedPreferences);

  @override
  Future<void> _play(List<VerseAudioEntity> items,int initialIndex) async{
    final files = await _getFiles(items);
    if(files.isNotEmpty){
      await _subsCurrentIndex?.cancel();
      await _subsPlayerState?.cancel();
      _addState(_state.copyWith(initIndex: initialIndex));
      _subsCurrentIndex = _audioPlay.currentIndexStream.listen((event) {
        if(event!=null){
          _addState(_state.copyWith(setModel: true,audio: items[event],audioEnum: AudioEnum.running,currentIndex: event));
        }
      });

      _subsPlayerState = _audioPlay.playerState.where((event) => event == ProcessingState.completed).listen((event) {
        _addState(_state.copyWith(audioEnum: AudioEnum.finish));
      });

      await _audioPlay.setPlayList(files);
      await _audioPlay.resume();

    }
  }

  @override
  Future<void> dispose() async{
    await _subsCurrentIndex?.cancel();
    await _subsPlayerState?.cancel();
    await super.dispose();
  }

}


