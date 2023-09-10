
import 'package:hadith/core/data/local/entities/verse_audio_entity.dart';
import 'package:hadith/core/features/verse_audio/domain/model/verse_audio.dart';

extension VerseAudioEntityExt on VerseAudioEntity{

  VerseAudio toVerseAudio({bool? hasEdited}){
    return VerseAudio(
        hasEdited: hasEdited ?? this.hasEdited ,
        mealId: mealId,
        identifier: identifier,
        fileName: fileName
    );
  }

}


extension VerseAudioExt on VerseAudio{

  VerseAudioEntity toVerseAudioEntity(){
    return VerseAudioEntity(
        mealId: mealId,
        hasEdited: hasEdited,
        identifier: identifier,
        fileName: fileName
    );
  }

}