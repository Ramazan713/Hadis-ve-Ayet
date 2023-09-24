

import 'package:floor/floor.dart';

final migration5To6 = Migration(5, 6, (database)async{

  database.transaction((txn)async{

    //Drop Views
    txn.execute("""drop view CuzAudioView""");
    txn.execute("""drop view HadithInfoListView""");
    txn.execute("""drop view ListHadithView""");
    txn.execute("""drop view ListVerseView""");
    txn.execute("""drop view SectionTopicsView""");
    txn.execute("""drop view SurahAudioView""");
    txn.execute("""drop view TopicHadithsView""");
    txn.execute("""drop view TopicVersesView""");
    txn.execute("""drop view VerseInfoListView""");

    //Rename Tables
    txn.execute("""ALTER TABLE AudioEdition RENAME TO AudioEditions""");
    txn.execute("""ALTER TABLE BackupMeta RENAME TO BackupMetas""");
    txn.execute("""ALTER TABLE Book RENAME TO Books""");
    txn.execute("""ALTER TABLE Cuz RENAME TO Cuzs""");
    txn.execute("""ALTER TABLE EsmaulHusna RENAME TO EsmaulHusnas""");
    txn.execute("""ALTER TABLE HadithTopic RENAME TO HadithTopics""");
    txn.execute("""ALTER TABLE Hadith RENAME TO Hadiths""");
    txn.execute("""ALTER TABLE History RENAME TO Histories""");
    txn.execute("""ALTER TABLE IslamicInfoItem RENAME TO IslamicInfoItems""");
    txn.execute("""ALTER TABLE IslamicInfoTitle RENAME TO IslamicInfoTitles""");
    txn.execute("""ALTER TABLE ListHadith RENAME TO ListHadiths""");
    txn.execute("""ALTER TABLE ListVerse RENAME TO ListVerses""");
    txn.execute("""ALTER TABLE List RENAME TO Lists""");
    txn.execute("""ALTER TABLE SavePointType RENAME TO SavePointTypes""");
    txn.execute("""ALTER TABLE Section RENAME TO Sections""");
    txn.execute("""ALTER TABLE SourceType RENAME TO SourceTypes""");
    txn.execute("""ALTER TABLE Surah RENAME TO Surahs""");
    txn.execute("""ALTER TABLE TopicSavePoint RENAME TO TopicSavePoints""");
    txn.execute("""ALTER TABLE Topic RENAME TO Topics""");
    txn.execute("""ALTER TABLE UserInfo RENAME TO UserInfos""");
    txn.execute("""ALTER TABLE VerseArabic RENAME TO VerseArabics""");
    txn.execute("""ALTER TABLE VerseAudio RENAME TO VerseAudios""");
    txn.execute("""ALTER TABLE VerseTopic RENAME TO VerseTopics""");
    txn.execute("""ALTER TABLE Verse RENAME TO Verses""");

    //Recreate Views
    txn.execute("""
      CREATE VIEW CuzAudioView as select E.name editionName, E.identifier,  V.cuzNo, 
      case when count(A.mealId) = (select count(VX.id) from verses VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded,
      C.name cuzName
      from  verses V, verseAudios A, audioEditions E, cuzs C
      where  A.identifier = E.identifier and A.mealId=V.id and C.cuzNo = V.cuzNo
      group by E.identifier, C.name, V.cuzNo
    """);
    txn.execute("""
       CREATE VIEW HadithInfoListView as select H.id hadithId,
      (select exists(select * from listHadiths LH, lists L
        where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LH.hadithId = H.id)) inAnyList,
      (select exists(select * from listHadiths LH, lists L
        where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LH.hadithId = H.id)) inAnyArchiveList,
      (select exists(select * from listHadiths LH, lists L
        where LH.listId = L.id and L.isRemovable = 0 and LH.hadithId = H.id)) inFavorite 
      from hadiths H
    """);
    txn.execute("""
      CREATE VIEW ListHadithView as select L.id, L.name, L.isRemovable, count(LH.hadithId)itemCounts, L.isArchive, L.sourceId,
      ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos 
      from lists L left join listHadiths LH on L.id=LH.listId where L.sourceId=1 group by L.id
    """);
    txn.execute("""
      CREATE VIEW ListVerseView as select L.id, L.name, L.isRemovable, L.isArchive, L.sourceId, count(LV.verseId)itemCounts,
      ifnull(max(LV.pos),0)contentMaxPos,L.pos listPos 
      from lists L left join listVerses LV on L.id=LV.listId where L.sourceId=2 group by L.id
    """);
    txn.execute("""
      CREATE VIEW SectionTopicsView as select S.id, S.name, S.searchName, S.bookId, count(T.id)topicCount from sections S, topics T 
      where S.id = T.sectionId group by S.id
    """);
    txn.execute("""
      CREATE VIEW SurahAudioView as select E.name editionName , E.identifier, V.surahId, S.name surahName,
      case when count(A.mealId) = (select count(VX.id) from verses VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded
      from  verses V, verseAudios A, audioEditions E, surahs S
      where V.id = A.mealId and A.identifier = E.identifier and S.id = V.surahId
      group by E.identifier,V.surahId, S.name
    """);
    txn.execute("""
      CREATE VIEW TopicHadithsView as select T.id,T.name, T.searchName, T.sectionId, count(HT.hadithId)hadithCount from 
      topics T, hadithTopics HT where T.id = HT.topicId group by T.id
    """);
    txn.execute("""
      CREATE VIEW TopicVersesView as select T.id,T.name, T.searchName, T.sectionId, count(VT.verseId)verseCount 
      from topics T, verseTopics VT where T.id=VT.topicId group by T.id
    """);
    txn.execute("""
      CREATE VIEW VerseInfoListView as  select V.id verseId,
      (select exists(select * from listVerses LV, lists L
        where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LV.verseId = V.id)) inAnyList,
      (select exists(select * from listVerses LV, lists L
        where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LV.verseId = V.id)) inAnyArchiveList,  
      (select exists(select * from listVerses LV, lists L
        where LV.listId = L.id and L.isRemovable = 0 and LV.verseId = V.id)) inFavorite 
      from verses V
    """);
  });

});