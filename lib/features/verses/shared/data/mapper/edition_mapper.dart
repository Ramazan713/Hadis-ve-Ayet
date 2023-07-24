
import 'package:hadith/core/data/local/entities/audio_edition_entity.dart';
import 'package:hadith/features/verses/shared/data/remote/dto/edition_dto.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_edition.dart';

extension EditionEntityExt on AudioEditionEntity{

  AudioEdition toEdition(){
    return AudioEdition(
      name: name,
      isSelected: isSelected,
      identifier: identifier,
      fileName: fileName
    );
  }

}

extension EditionDtoExt on EditionDto{

  AudioEditionEntity toEditionEntity(){
    return AudioEditionEntity(
        name: englishName,
        isSelected: false,
        identifier: identifier,
        fileName: null
    );
  }
}

extension EditionExt on AudioEdition{

  AudioEditionEntity toEditionEntity(){
    return AudioEditionEntity(
        name: name,
        isSelected: isSelected,
        identifier: identifier,
        fileName: fileName
    );
  }

}
