

import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';

abstract class ISelectEditionEvent{}

class EditionEventSelectedEditionListener extends ISelectEditionEvent{}

class EditionEventInitListener extends ISelectEditionEvent{}

class EditionEventLoadInit extends ISelectEditionEvent{}

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

