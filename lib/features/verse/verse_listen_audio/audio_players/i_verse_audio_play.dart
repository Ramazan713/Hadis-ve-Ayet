

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/streams.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../db/entities/helper/verse_audio_entity.dart';

abstract class IVerseAudioPlay{

  abstract final ValueStream<Duration?> positionStream;
  abstract final ValueStream<Duration?> durationStream;

  Future<void> play(File file);
  Future<void> resume();
  Future<void> pause();
  Future<void> stop();
  Future<void> release();

  Future<void> changeSpeed(double speed);
  Future<void> changePosition(Duration position);
  Future<void> setLoop(bool isLoop);

}