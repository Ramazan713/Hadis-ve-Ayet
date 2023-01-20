
import 'package:equatable/equatable.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_event.dart';

abstract class IBasicAudioEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class BasicAudioEventStartWithIdentifier extends IBasicAudioEvent{
  final String identifier;
  BasicAudioEventStartWithIdentifier({required this.identifier});
  @override
  List<Object?> get props => [identifier];
}

class BasicAudioEventInit extends IBasicAudioEvent{}

class BasicAudioEventPause extends IBasicAudioEvent{}

class BasicAudioEventResume extends IBasicAudioEvent{}

class BasicAudioEventStopListening extends IBasicAudioEvent{}




