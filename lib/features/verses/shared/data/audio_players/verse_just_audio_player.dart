import 'dart:io';

import 'package:hadith/features/verses/shared/domain/audio_players/i_verse_audio_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class VerseJustAudioPlayer extends IVerseAudioPlayer{

  final _player = AudioPlayer();
  bool _isSpeedChanged=false;
  double _newSpeed=1.0;

  @override
  ValueStream<Duration?> get durationStream => _player.durationStream.shareValue();

  @override
  ValueStream<Duration?> get positionStream => _player.positionStream.shareValue();

  Stream<int?> get currentIndexStream => _player.currentIndexStream;

  ValueStream<PlayerState> get playerState => _player.playerStateStream.shareValue();


  Future<void> setPlayList(List<File>files)async{

    final audioSources = files.map((e) => AudioSource.file(e.path)).toList();

    final playList = ConcatenatingAudioSource(
        children: audioSources
    );
    await _player.setAudioSource(playList);
    await _player.setShuffleModeEnabled(false);
    await _player.load();
    await _checkAndSetSpeed();
  }

  @override
  Future<void> changePosition(Duration position) async{
    await _player.seek(position);
  }

  @override
  Future<void> pause() async{
    await _player.pause();
  }

  @override
  Future<void> play(File file) async{
    await _play();
  }

  Future<void> _play()async{
    await _player.play();

    await _checkAndSetSpeed();
  }

  Future<void> _checkAndSetSpeed()async{
    if(_isSpeedChanged){
      await _player.setSpeed(_newSpeed);
      _isSpeedChanged=false;
    }
  }

  @override
  Future<void> release() async{
    await _player.dispose();
  }

  @override
  Future<void> resume() async{
    await _play();
  }

  @override
  Future<void> setLoop(bool isLoop) async{
    final mode = isLoop ? LoopMode.all : LoopMode.off;
    await _player.setLoopMode(mode);
  }

  @override
  Future<void> stop() async{
    await _player.stop();
  }

  @override
  Future<void> changeSpeed(double speed) async{
    if(_player.playing){
      await _player.setSpeed(speed);
    }else{
      _isSpeedChanged = true;
      _newSpeed = speed;
    }
  }

}