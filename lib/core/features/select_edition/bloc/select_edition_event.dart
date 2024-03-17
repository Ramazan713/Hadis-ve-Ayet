

import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/select_edition/models/select_audio_edition.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_result/select_quran_section_result.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';

abstract class ISelectEditionEvent{}

class EditionEventSelectedEditionListener extends ISelectEditionEvent{}

class EditionEventDataListener extends ISelectEditionEvent{}

class EditionEventLoadData extends ISelectEditionEvent{}

class EditionEventResetChanges extends ISelectEditionEvent{}

class EditionEventSave extends ISelectEditionEvent{}

class EditionEventClearMessage extends ISelectEditionEvent{}

class EditionEventSetAudioRequest extends ISelectEditionEvent{
  final SelectQuranSectionResult result;
  EditionEventSetAudioRequest({required this.result});
}

class EditionEventSetEdition extends ISelectEditionEvent{
  final SelectAudioEdition edition;
  EditionEventSetEdition({required this.edition});
}


class EditionEventAddFavorite extends ISelectEditionEvent{
  final SelectAudioEdition edition;
  EditionEventAddFavorite({required this.edition});
}

class EditionEventDeleteFavorite extends ISelectEditionEvent{
  final SelectAudioEdition edition;
  EditionEventDeleteFavorite({required this.edition});
}

