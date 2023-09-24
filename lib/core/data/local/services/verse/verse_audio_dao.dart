

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_audio_entity.dart';

@dao
abstract class VerseAudioDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVerseAudio(VerseAudioEntity verseAudio);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVerseAudios(List<VerseAudioEntity> verseAudios);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateVerseAudios(List<VerseAudioEntity>verseAudios);

  @delete
  Future<void> deleteVerseAudios(List<VerseAudioEntity> verseAudios);

  @Query("""
    delete from verseAudios where identifier = :identifier and mealId=:mealId
  """)
  Future<void> deleteVerseAudioWithQuery(String identifier,int mealId);


  @Query("""
    select exists(select 1 from surahAudioView where surahId=:surahId and identifier=:identifier and isDownloaded=1)
  """)
  Future<bool?> hasVerseAudiosWithSurahId(int surahId,String identifier);

  @Query("""
    select exists(select 1 from verses V, verseAudios VA 
    where V.id = VA.mealId and VA.identifier = :identifier and V.surahId=:surahId and VA.mealId >= :startVerseId
    group by V.surahId 
    having count(id)=(select count(*)from verses where surahId=:surahId and id >= :startVerseId))
  """)
  Future<bool?> hasVerseAudiosWithSurahIdAndStartVerseId(int surahId,String identifier,int startVerseId);


  @Query("""
    select exists(select 1 from cuzAudioView where cuzNo=:cuzNo and identifier=:identifier and isDownloaded=1)
  """)
  Future<bool?> hasVerseAudiosWithCuzNo(int cuzNo,String identifier);

  @Query("""
    select exists(select 1 from verses V, verseAudios VA 
    where V.id = VA.mealId and VA.identifier = :identifier and V.cuzNo=:cuzNo and VA.mealId >= :startVerseId  
    group by V.cuzNo 
    having count(id)=(select count(*)from verses where cuzNo=:cuzNo and id >= :startVerseId))
  """)
  Future<bool?> hasVerseAudiosWithCuzNoAndStartVerseId(int cuzNo,String identifier,int startVerseId);


  @Query("""
    select exists(select 1 from verses V, verseAudios VA 
    where V.id = VA.mealId and VA.identifier = :identifier and V.pageNo=:pageNo 
    group by V.pageNo 
    having count(id)=(select count(*)from verses where pageNo=:pageNo))
  """)
  Future<bool?> hasVerseAudiosWithPageNo(int pageNo,String identifier);

  @Query("""
    select exists(select 1 from verses V, verseAudios VA 
    where V.id = VA.mealId and VA.identifier = :identifier and V.pageNo=:pageNo and VA.mealId >= :startVerseId
    group by V.pageNo 
    having count(id) = (select count(*)from verses where pageNo=:pageNo and id >= :startVerseId))
  """)
  Future<bool?> hasVerseAudiosWithPageNoAndStartVerseId(int pageNo,String identifier,int startVerseId);


  @Query("""
   select exists(select 1 from verseAudios 
   where  identifier = :identifier and mealId=:mealId)""")
  Future<bool?> hasVerseAudiosWithMealId(int mealId,String identifier);


  @Query("""
   select exists(select 1 from verseAudios
    where identifier = :identifier and mealId in (:mealIds)
    group by identifier 
    having count(*) = (select count(*)from verses where id in (:mealIds)))
   """)
  Future<bool?> hasVerseAudiosWithMealIdList(List<int> mealIds,String identifier);



  @Query("""
    select VA.* from verseAudios VA, verses V 
    where V.id = VA.mealId and VA.identifier=:identifier and VA.hasEdited=0 and V.cuzNo=:cuzNo
  """)
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithCuzNo(int cuzNo,String identifier);

  @Query("""
    select VA.* from verseAudios VA, verses V 
    where V.id = VA.mealId and VA.identifier=:identifier and VA.hasEdited=0 and V.surahId=:surahId
  """)
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithSurahId(int surahId,String identifier);

  @Query("""
    select VA.* from verseAudios VA, verses V 
    where V.id = VA.mealId and VA.identifier=:identifier and VA.hasEdited=0 and V.pageNo=:pageNo
  """)
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithPageNo(int pageNo,String identifier);

  @Query("""
    select VA.* from verseAudios VA, verses V 
    where V.id = VA.mealId and VA.identifier=:identifier and VA.hasEdited=0 and V.id=:mealId
  """)
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithMealId(int mealId,String identifier);

  @Query("""
    select VA.* from verseAudios VA, verses V 
    where V.id = VA.mealId and VA.identifier=:identifier and VA.hasEdited=0 and V.id in (:mealIds)
  """)
  Future<List<VerseAudioEntity>> getUnEditedVerseAudiosWithMealIdList(List<int> mealIds,String identifier);



  @Query("""
    select VA.* from verseAudios VA, verses V 
    where VA.mealId = V.id and V.cuzNo=:cuzNo and VA.identifier=:identifier and V.id >= :startVerseId
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getVerseAudioWithCuzNo(int cuzNo,String identifier, int startVerseId);

  @Query("""
    select VA.* from verseAudios VA, verses V 
    where VA.mealId = V.id and V.cuzNo=:cuzNo and VA.identifier=:identifier
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getAllVerseAudioWithCuzNo(int cuzNo,String identifier);



  @Query("""
    select VA.* from verseAudios VA, verses V 
    where VA.mealId = V.id and V.surahId=:surahId and VA.identifier=:identifier and V.id >= :startVerseId
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getVerseAudioWithSurahId(int surahId, String identifier, int startVerseId);

  @Query("""
    select VA.* from verseAudios VA, verses V 
    where VA.mealId = V.id and V.surahId=:surahId and VA.identifier=:identifier
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getAllVerseAudioWithSurahId(int surahId, String identifier);



  @Query("""
    select VA.* from verseAudios VA, verses V 
    where VA.mealId = V.id  and VA.identifier=:identifier and V.pageNo=:pageNo and V.id >= :startVerseId
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getVerseAudioWithPageNo(int pageNo, String identifier, int startVerseId);

  @Query("""
    select VA.* from verseAudios VA, verses V 
    where VA.mealId = V.id and V.pageNo=:pageNo and VA.identifier=:identifier
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getAllVerseAudioWithPageNo(int pageNo,String identifier);


  @Query("""
    select VA.* from verseAudios VA, verses V
    where VA.mealId = V.id and VA.mealId=:mealId and VA.identifier=:identifier
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getAllVerseAudioWithMealId(int mealId, String identifier);


  @Query("""
    select VA.* from verseAudios VA, verses V
    where VA.mealId = V.id and VA.mealId in (:mealIds) and VA.identifier=:identifier
    order by mealId
  """)
  Future<List<VerseAudioEntity>> getAllVerseAudioWithMealIdList(List<int> mealIds, String identifier);


}