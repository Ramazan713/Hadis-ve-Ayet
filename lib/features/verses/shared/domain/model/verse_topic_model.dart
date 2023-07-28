

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/models/downloaded_audio_view_model.dart';

class VerseTopicModel<T> extends Equatable{
  final DownloadedAudioViewModel? audioViewModel;
  final T data;

  const VerseTopicModel({required this.data,required this.audioViewModel});

  @override
  List<Object?> get props => [audioViewModel, data];
}