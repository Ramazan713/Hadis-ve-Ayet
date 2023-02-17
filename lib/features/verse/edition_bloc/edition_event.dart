
import 'package:equatable/equatable.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';

abstract class IEditionEvent{}

class EditionEventInit extends IEditionEvent{}

class EditionEventInitAudioQuality extends IEditionEvent{}


class EditionEventSetInit extends IEditionEvent{}

class EditionEventReset extends IEditionEvent{}

class EditionEventSave extends IEditionEvent{}

class EditionEventRefreshData extends IEditionEvent{
  final bool forceRemote;
  EditionEventRefreshData({this.forceRemote=false});
}

class EditionEventSetQuality extends IEditionEvent{
  final AudioQualityEnum audioQuality;
  EditionEventSetQuality({required this.audioQuality});
}

class EditionEventSetSelected extends IEditionEvent{
  final String identifier;
  EditionEventSetSelected({required this.identifier});
}

