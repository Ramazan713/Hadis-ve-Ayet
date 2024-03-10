

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'basic_audio_request.freezed.dart';

@freezed
class BasicAudioRequest with _$BasicAudioRequest{
  const factory BasicAudioRequest({
    required int surahId,
    required String startVerseId,
    String? endVerseId
  }) = _BasicAudioRequest;
}