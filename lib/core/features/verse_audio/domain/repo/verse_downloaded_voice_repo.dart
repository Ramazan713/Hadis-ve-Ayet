

import 'package:hadith/core/features/verse_audio/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';

abstract class VerseDownloadedVoiceRepo{
  Future<List<VerseDownloadedVoiceModel>> getNotDownloadedAudioVerses(
    {
      required int itemId,
      required QuranAudioOption op,
      required String identifier,
      int? startVerseId
    }
  );

  Future<List<List<VerseDownloadedVoiceModel>>> getNotDownloadedAudioVersesWithGroupByMealId(
      {
        required int itemId,
        required QuranAudioOption op,
        required String identifier,
        int? startVerseId,
        bool addMention = true
      }
  );
}