import 'dart:io';
import 'package:rxdart/streams.dart';


abstract class IVerseAudioPlayer{

  abstract final ValueStream<Duration?> positionStream;
  abstract final ValueStream<Duration?> durationStream;

  Future<void> play(File file);
  Future<void> start();
  Future<void> resume();
  Future<void> pause();
  Future<void> stop();
  Future<void> release();

  Future<void> changeSpeed(double speed);
  Future<void> changePosition(Duration position);
  Future<void> setLoop(bool isLoop);

}