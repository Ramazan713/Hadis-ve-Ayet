
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/features/verses/shared/domain/model/verse_audio.dart';
import 'package:hadith/features/verses/shared/domain/model/listen_audio/verse_meal_voice_model.dart';

abstract class VerseAudioRepo{

  Future<void> updateVerseAudios(List<VerseAudio>verseAudios);

  Future<void> createVerseAudioAndFile({
    required int mealId,
    required String identifier,
    required List<int> bytes,
    bool hasEdited = false
  });


  Future<bool> validateVerseAudios({
    required List<VerseMealVoiceModel> verseAudios
  });

  Future<void> deleteVerseAudiosAndFiles({
    required List<VerseAudio> verseAudios
  });


  Future<bool> hasVerseAudios(ListenAudioParam listenAudioParam);

  Future<void> editUnEditedAudios(ListenAudioParam param);
}