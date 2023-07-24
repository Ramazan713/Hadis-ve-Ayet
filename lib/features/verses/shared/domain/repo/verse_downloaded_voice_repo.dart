

import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/model/download_verse/verse_downloaded_model.dart';

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