
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/entities/verse_audio.dart';

@dao
abstract class VerseAudioDaoOld{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertVerseAudio(VerseAudio verseAudio);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertVerseAudios(List<VerseAudio> verseAudios);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateVerseAudios(List<VerseAudio>verseAudios);

  @delete
  Future<void>deleteVerseAudios(List<VerseAudio>verseAudios);

  @Query("""select * from verseAudio where identifier = :identifier and
   mealId in (:mealIds) order by mealId""")
  Future<List<VerseAudio>> getVerseAudios(String identifier,List<int>mealIds);

  @Query("""delete from verseAudio where identifier = :identifier""")
  Future<void> deleteVerseAudiosWithQuery(String identifier);

  @Query("""delete from verseAudio where identifier = :identifier and mealId=:mealId""")
  Future<void> deleteVerseAudioWithQuery(String identifier,int mealId);

  @Query("""select VA.* from verseAudio VA, verse V where V.id = VA.mealId and 
    V.cuzNo=:cuzNo and VA.identifier=:identifier order by VA.mealId""")
  Future<List<VerseAudio>>getVerseAudiosWithCuzNo(int cuzNo,String identifier);

  @Query("""select VA.* from verseAudio VA, verse V where V.id = VA.mealId and 
    V.surahId=:surahId and VA.identifier=:identifier order by VA.mealId""")
  Future<List<VerseAudio>>getVerseAudiosWithSurahId(int surahId,String identifier);


  @Query("""select exists(select 1 from surahAudioView where surahId=:surahId and identifier=:identifier and isDownloaded=1) data""")
  Future<IntData?>isVerseAudiosExistsWithSurah(int surahId,String identifier);

  @Query("""select exists(select 1 from cuzAudioView where cuzNo=:cuzNo and identifier=:identifier and isDownloaded=1) data""")
  Future<IntData?>isVerseAudiosExistsWithCuzNo(int cuzNo,String identifier);

  @Query("""select exists(select 7 from Verse V, VerseAudio VA where V.id = VA.mealId and 
    VA.identifier = :identifier and V.pageNo=:pageNo group by V.pageNo 
    having count(id)=(select count(*)from Verse where pageNo=:pageNo) ) data""")
  Future<IntData?>isVerseAudiosExistsWithPage(int pageNo,String identifier);

  @Query("""select exists(select 1 from VerseAudio
   where  identifier = :identifier and mealId=:mealId) data""")
  Future<IntData?>isVerseAudiosExistsWithMeal(int mealId,String identifier);




  @Query("""select VA.* from VerseAudio VA,Verse V where V.id = VA.mealId and VA.identifier=:identifier and
    VA.hasEdited=0 and V.cuzNo=:cuzNo""")
  Future<List<VerseAudio>>getUnEditedVerseAudiosWithCuzNo(int cuzNo,String identifier);

  @Query("""select VA.* from VerseAudio VA,Verse V where V.id = VA.mealId and VA.identifier=:identifier and
    VA.hasEdited=0 and V.surahId=:surahId""")
  Future<List<VerseAudio>>getUnEditedVerseAudiosWithSurahId(int surahId,String identifier);

}