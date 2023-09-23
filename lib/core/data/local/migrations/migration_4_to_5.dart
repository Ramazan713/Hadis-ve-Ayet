

import 'package:floor/floor.dart';

final migration4To5 = Migration(4, 5, (database)async{

  database.transaction((txn)async{
    //Prayers
    txn.execute("""
      CREATE TABLE "PrayersTemp" (
        "id"	INTEGER,
        "name"	TEXT,
        "arabicContent"	TEXT,
        "meaningContent"	TEXT,
        "pronunciationContent"	INTEGER,
        "source"	TEXT,
        "typeId"	INTEGER NOT NULL DEFAULT 0,
        "orderItem"	INTEGER NOT NULL DEFAULT 0,
        "isRemovable"	INTEGER NOT NULL DEFAULT 1,
        "counterId"	INTEGER,
        "updateCounter"	INTEGER NOT NULL DEFAULT 0,
        "parentPrayerId"	INTEGER,
        PRIMARY KEY("id" AUTOINCREMENT),
        FOREIGN KEY("counterId") REFERENCES "Counters"("id") on delete set null on update cascade,
        FOREIGN KEY("parentPrayerId") REFERENCES "Prayers"("id") on delete set null on update cascade
      )
    """);
    txn.execute("""
      insert into PrayersTemp(
      id, name, arabicContent, meaningContent, pronunciationContent, typeId, orderItem, isRemovable, updateCounter)
      select id, name, arabicContent, meaningContent, pronunciationContent, 2, id, 0, 0 from Prayers
    """);
    txn.execute("""
      insert into PrayersTemp(
      name, arabicContent, meaningContent, pronunciationContent, typeId, orderItem, isRemovable, updateCounter)
      select name, arabicContent, meaning, content, 3, orderItem, 0, 0 from Counters where isRemovable = 0
    """);
    txn.execute("""
      update PrayerQuran set arabicContent = 'وَاِذْ قَالَ اِبْرٰهٖيمُ رَبِّ اجْعَلْ هٰذَا الْبَلَدَ اٰمِناً وَاجْنُبْنٖي وَبَنِيَّ اَنْ نَعْبُدَ الْاَصْنَامَؕ ﴿﴾ رَبِّ اِنَّهُنَّ اَضْلَلْنَ كَثٖيراً مِنَ النَّاسِۚ فَمَنْ تَبِعَنٖي فَاِنَّهُ مِنّٖيۚ وَمَنْ عَصَانٖي فَاِنَّكَ غَفُورٌ رَحٖيمٌ ﴿﴾ رَبَّـنَٓا اِنّٖٓي اَسْكَنْتُ مِنْ ذُرِّيَّتٖي بِوَادٍ غَيْرِ ذٖي زَرْعٍ عِنْدَ بَيْتِكَ الْمُحَرَّمِۙ رَبَّـنَا لِيُقٖيمُوا الصَّلٰوةَ فَاجْعَلْ اَفْـِٔدَةً مِنَ النَّاسِ تَهْوٖٓي اِلَيْهِمْ وَارْزُقْهُمْ مِنَ الثَّمَرَاتِ لَعَلَّهُمْ يَشْكُرُونَ ﴿﴾ رَبَّـنَٓا اِنَّكَ تَعْلَمُ مَا نُخْفٖي وَمَا نُعْلِنُؕ وَمَا يَخْفٰى عَلَى اللّٰهِ مِنْ شَيْءٍ فِي الْاَرْضِ وَلَا فِي السَّمَٓاءِ ﴿﴾ اَلْحَمْدُ لِلّٰهِ الَّذٖي وَهَبَ لٖي عَلَى الْكِبَرِ اِسْمٰعٖيلَ وَاِسْحٰقَؕ اِنَّ رَبّٖي لَسَمٖيعُ الدُّعَٓاءِ ﴿﴾ رَبِّ اجْعَلْنٖي مُقٖيمَ الصَّلٰوةِ وَمِنْ ذُرِّيَّتٖيࣗ رَبَّـنَا وَتَقَبَّلْ دُعَٓاءِ ﴿﴾ رَبَّـنَا اغْفِرْ لٖي وَلِوَالِدَيَّ وَلِلْمُؤْمِنٖينَ يَوْمَ يَقُومُ الْحِسَابُࣖ'
      where source = 'İbrâhîm 35'
    """);
    txn.execute("""
      update PrayerQuran set
      meaningContent = 'Hani İbrahim demişti ki: "Rabbim! Bu şehri güvenli kıl, beni ve oğullarımı putlara tapmaktan uzak tut. Rabbim! Çünkü o putlar insanlardan birçoğunu saptırdılar. Artık kim bana uyarsa o bendendir. Kim de bana karşı gelirse şüphesiz sen çok bağışlayan, çok merhamet edensin. Rabbimiz! Ben çocuklarımdan bazısını, senin kutsal evinin (Kâbe"nin) yanında ekin bitmez bir vadiye yerleştirdim. Rabbimiz! Namazı dosdoğru kılmaları için (böyle yaptım). Sen de insanlardan bir kısmının gönüllerini onlara meylettir, onları ürünlerden rızıklandır, umulur ki şükrederler. Rabbimiz! Şüphesiz sen, gizlediğimizi de, açığa vurduğumuzu da bilirsin. Yerde ve gökte hiçbir şey Allah\''a gizli kalmaz. Hamd, iyice yaşlanmış iken bana İsmail\''i ve İshak\''ı veren Allah\''a mahsustur. Şüphesiz Rabbim duayı işitendir. Rabbim! Beni namaza devam eden bir kimse eyle. Soyumdan da böyle kimseler yarat. Rabbimiz! Duamı kabul eyle. Rabbimiz! Hesap görülecek günde, beni, ana-babamı ve inananları bağışla." '
      where source = 'İbrâhîm 35'
    """);
    txn.execute("""
      update PrayerQuran set source = 'İbrâhîm 35-41' where source = 'İbrâhîm 35'
    """);
    txn.execute("""delete from PrayerQuran where source = 'İbrâhîm 40-41'""");
    txn.execute("""delete from PrayerQuran where source = 'Şuarâ 88-89'""");
    txn.execute("""
      insert into PrayersTemp(
      arabicContent, meaningContent, source, typeId, orderItem, isRemovable, updateCounter)
      select arabicContent, meaningContent, source, 1, id, 0, 0 from PrayerQuran
    """);
    txn.execute("""drop table prayers""");
    txn.execute("""drop table PrayerQuran""");
    txn.execute("""alter table PrayersTemp rename to Prayers""");


    //PrayerVerses
    txn.execute("""
      CREATE TABLE "PrayerVerses" (
        "id"	INTEGER,
        "prayerId"	INTEGER NOT NULL,
        "verseId"	INTEGER NOT NULL,
        "orderItem"	INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY("prayerId") REFERENCES "Prayers"("id") on delete cascade,
        FOREIGN KEY("verseId") REFERENCES "Verse"("id"),
        PRIMARY KEY("id" AUTOINCREMENT)
      )
    """);

    // Counters
    txn.execute("""delete from counters where isRemovable = 0""");
    txn.execute("""
      CREATE TABLE "CountersTemp" (
        "id"	INTEGER,
        "name"	TEXT NOT NULL,
        "content"	TEXT,
        "arabicContent"	TEXT,
        "meaning"	TEXT,
        "orderItem"	INTEGER NOT NULL,
        "goal"	INTEGER,
        "typeId"	INTEGER NOT NULL,
        "lastCounter"	INTEGER NOT NULL DEFAULT 0,
        "description"	TEXT,
        "prayerId"	INTEGER,
        FOREIGN KEY("prayerId") REFERENCES "Prayers"("id") on delete set null on update cascade,
        PRIMARY KEY("id" AUTOINCREMENT))
    """);
    txn.execute("""
      insert into CountersTemp(id,name,content,arabicContent,meaning,orderItem,goal,typeId,lastCounter)
      select id,name,content,arabicContent,meaning,orderItem,goal,type,lastCounter from Counters
    """);
    txn.execute("""drop table Counters""");
    txn.execute("""alter table CountersTemp rename to Counters""");


    //Esmaul Husna
    txn.execute("""
      alter table EsmaulHusna add column counterId INTEGER references counters(id) on delete set null
    """);

    txn.execute("""alter table EsmaulHusna add column searchName TEXT NOT NULL DEFAULT ''""");


    //SavePoint
    txn.execute("""
      CREATE TABLE "SavePointsTemps" (
        "id"	INTEGER,
        "itemIndexPos"	INTEGER NOT NULL,
        "savePointType"	INTEGER NOT NULL,
        "title"	TEXT NOT NULL,
        "autoType"	INTEGER NOT NULL,
        "modifiedDate"	TEXT NOT NULL,
        "parentKey"	TEXT NOT NULL DEFAULT 0,
        "parentName"	TEXT NOT NULL,
        "bookScope"	INTEGER NOT NULL,
        PRIMARY KEY("id" AUTOINCREMENT)
      )
    """);
    txn.execute("""  
      insert into SavePointsTemps(
      id,itemIndexPos,savePointType,title,autoType,modifiedDate,parentKey,parentName,bookScope)
      select id,itemIndexPos,savePointType,title,autoType,modifiedDate,parentKey,parentName,bookScope from SavePoint
    """);
    txn.execute("""drop table SavePoint""");
    txn.execute("""alter table SavePointsTemps rename to SavePoints""");


    // Topics
    txn.execute("""
      alter table Section add column searchName TEXT NOT NULL DEFAULT '';
    """);
    txn.execute("""
      alter table Topic add column searchName TEXT NOT NULL DEFAULT '';
    """);


    //Drop Views
    txn.execute("""drop view CuzAudioView""");
    txn.execute("""drop view ListHadithView""");
    txn.execute("""drop view ListVerseView""");
    txn.execute("""drop view SurahAudioView""");

    //Create Views
    txn.execute("""
      CREATE VIEW cuzAudioView as select E.name editionName, E.identifier,  V.cuzNo, 
      case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded,
      C.name cuzName
      from  verse V, VerseAudio A, AudioEdition E, Cuz C
      where  A.identifier = E.identifier and A.mealId=V.id and C.cuzNo = V.cuzNo
      group by E.identifier,V.cuzNo, cuzName
    """);
    txn.execute("""
      CREATE VIEW HadithInfoListView as select H.id hadithId,
          (select exists(select * from ListHadith LH, list L
            where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LH.hadithId = H.id)) inAnyList,
      (select exists(select * from ListHadith LH, list L
            where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LH.hadithId = H.id)) inAnyArchiveList,
          (select exists(select * from ListHadith LH, list L
            where LH.listId = L.id and L.isRemovable = 0 and LH.hadithId = H.id)) inFavorite 
          from Hadith H
    """);
    txn.execute("""
      CREATE VIEW ListHadithView as select L.id,L.name,L.isRemovable,L.isArchive,L.sourceId,count(LH.hadithId)itemCounts,ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos from List L left join ListHadith LH on  L.id=LH.listId
      where L.sourceId=1 group by L.id
    """);
    txn.execute("""
       CREATE VIEW ListVerseView as select L.id,L.name,L.isRemovable,L.isArchive,L.sourceId,count(LV.verseId)itemCounts,ifnull(max(LV.pos),0)contentMaxPos,L.pos listPos from List L left join ListVerse LV on L.id=LV.listId
      where L.sourceId=2  group by L.id
    """);
    txn.execute("""
      CREATE VIEW SectionTopicsView as select S.id, S.name, S.searchName, S.bookId, count(T.id)topicCount from section S,Topic T 
      where S.id=T.sectionId  group by S.id
    """);
    txn.execute("""
      CREATE VIEW SurahAudioView as select E.name editionName , E.identifier, V.surahId, S.name surahName,
      case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded
      from  verse V, VerseAudio A, AudioEdition E, Surah S
      where V.id=A.mealId and A.identifier = E.identifier and S.id = V.surahId
      group by E.identifier,V.surahId, S.name
    """);
    txn.execute("""
      CREATE VIEW TopicHadithsView as select T.id,T.name, T.searchName, T.sectionId, count(HT.hadithId)hadithCount from topic T,HadithTopic HT where T.id=HT.topicId group by T.id
    """);
    txn.execute("""
      CREATE VIEW TopicVersesView as select T.id,T.name, T.searchName, T.sectionId, count(VT.verseId)verseCount from 
      topic T,VerseTopic VT where T.id=VT.topicId group by T.id
    """);
    txn.execute("""
      CREATE VIEW VerseInfoListView as select V.id verseId,
          (select exists(select * from ListVerse LV, list L
            where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LV.verseId = V.id)) inAnyList,
      (select exists(select * from ListVerse LV, list L
            where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LV.verseId = V.id)) inAnyArchiveList,  
          (select exists(select * from ListVerse LV, list L
            where LV.listId = L.id and L.isRemovable = 0 and LV.verseId = V.id)) inFavorite 
          from verse V
    """);
  });
});