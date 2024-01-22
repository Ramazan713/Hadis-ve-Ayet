

import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';

abstract class ISelectEditionEvent{}

class EditionEventSelectedEditionListener extends ISelectEditionEvent{}

class EditionEventDataListener extends ISelectEditionEvent{}

class EditionEventLoadData extends ISelectEditionEvent{}

class EditionEventResetChanges extends ISelectEditionEvent{}

class EditionEventSave extends ISelectEditionEvent{}

class EditionEventClearMessage extends ISelectEditionEvent{}

class EditionEventSetQuality extends ISelectEditionEvent{
  final AudioQualityEnum audioQuality;
  EditionEventSetQuality({required this.audioQuality});
}

class EditionEventSetEdition extends ISelectEditionEvent{
  final AudioEdition edition;
  EditionEventSetEdition({required this.edition});
}

