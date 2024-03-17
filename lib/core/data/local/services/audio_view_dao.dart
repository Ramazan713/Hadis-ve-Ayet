
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/views/cuz_audio_view.dart';
import 'package:hadith/core/data/local/views/page_audio_view.dart';
import 'package:hadith/core/data/local/views/surah_audio_view.dart';

@dao
abstract class AudioViewDao{

  @Query("""
    select * from surahAudioView where isDownloaded=1 order by surahId
  """)
  Stream<List<SurahAudioView>> getStreamSurahAudioViews();

  @Query("""
    select * from surahAudioView where isDownloaded=1 and identifier=:identifier order by surahId
  """)
  Stream<List<SurahAudioView>> getStreamSurahAudioViewsWithIdentifier(String identifier);


  @Query("""
    select * from cuzAudioView where isDownloaded=1 order by cuzNo
  """)
  Stream<List<CuzAudioView>> getStreamCuzAudioViews();

  @Query("""
    select * from cuzAudioView where isDownloaded=1 and identifier=:identifier order by cuzNo
  """)
  Stream<List<CuzAudioView>> getStreamCuzAudioViewsWithIdentifier(String identifier);


  @Query("""
    select * from pageAudioView where isDownloaded=1 order by pageNo
  """)
  Stream<List<PageAudioView>> getStreamPageAudioViews();

  @Query("""
    select * from pageAudioView where isDownloaded=1 and identifier=:identifier order by pageNo
  """)
  Stream<List<PageAudioView>> getStreamPageAudioViewsWithIdentifier(String identifier);
}