


import 'package:floor/floor.dart';
import 'package:hadith/db/entities/cuz.dart';
import 'package:hadith/db/entities/views/cuz_audio_view.dart';
import 'package:hadith/db/entities/views/surah_audio_view.dart';

@dao
abstract class ManageAudioDao{


  @Query("""select * from surahAudioView where isDownloaded=1 and identifier=:identifier order by surahId""")
  Stream<List<SurahAudioView>>getStreamSurahAudioViews(String identifier);

  @Query("""select * from cuzAudioView where isDownloaded=1 and identifier=:identifier order by cuzNo""")
  Stream<List<CuzAudioView>>getStreamCuzAudioViews(String identifier);

}