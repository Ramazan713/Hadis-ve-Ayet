


import 'package:floor/floor.dart';

final migration2To3=Migration(2, 3, (database)async{
  database.transaction((txn)async{
    await txn.execute("""CREATE TABLE "VerseArabicTemp" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "mealId"	INTEGER NOT NULL,
        "verse"	TEXT NOT NULL,
        "verseNumber"	TEXT NOT NULL,
        FOREIGN KEY("mealId") REFERENCES "Verse"("id")
      )""");
    await txn.execute("""insert into VerseArabicTemp( mealId,verse,verseNumber) select mealId,verse,verseNumber from VerseArabic""");
    await txn.execute("""drop table VerseArabic""");
    await txn.execute("""alter table VerseArabicTemp RENAME to VerseArabic""");

    await txn.execute("""create table if not exists AudioEdition(
        identifier Text NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        isSelected INTEGER DEFAULT 0,
        fileName TEXT
      )""");
    await txn.execute("""CREATE TABLE "VerseAudio" (
        "mealId"	INT NOT NULL,
        "identifier"	Text NOT NULL,
        "fileName"	TEXT,
        "hasEdited"	INTEGER NOT NULL,
        PRIMARY KEY('mealId','identifier'),
        FOREIGN KEY("identifier") REFERENCES "AudioEdition"("identifier"),
        FOREIGN KEY("mealId") REFERENCES "Verse"("id")
      )""");

    await txn.execute("""CREATE VIEW CuzAudioView as select E.name editionName , E.identifier, V.cuzNo,
        case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.cuzNo=V.cuzNo) then 1 else 0 end isDownloaded
        from  verse V, VerseAudio A, AudioEdition E
        where  A.identifier = E.identifier and A.mealId=V.id group by E.identifier,V.cuzNo""");

    await txn.execute("""CREATE VIEW SurahAudioView as select E.name editionName , E.identifier, V.surahId,
        case when count(A.mealId) = (select count(VX.id) from Verse VX where VX.surahId=V.surahId) then 1 else 0 end isDownloaded
        from  verse V, VerseAudio A, AudioEdition E
        where V.id=A.mealId and A.identifier = E.identifier group by E.identifier,V.surahId""");

    await txn.execute("""alter table SavePoint rename column isAuto to autoType""");
    await txn.execute("""alter table SavePoint rename column bookIdBinary to bookScope""");

    final arabicVerses = await txn.rawQuery("""select VA.*,V.verseNumber as verseNumberTrTemp from VerseArabic VA,Verse V where VA.mealId = V.id""");

    await txn.execute("drop table VerseArabic");
    await txn.execute("""CREATE TABLE "VerseArabic" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "mealId"	INTEGER NOT NULL,
        "verse"	TEXT NOT NULL,
        "verseNumber"	TEXT NOT NULL,
        "verseNumberTr"	INTEGER NOT NULL,
        FOREIGN KEY("mealId") REFERENCES "Verse"("id")
      )""");

    final batch = txn.batch();
    int? prevMealId;
    int index = 0;
    for(var verse in arabicVerses){
      final verseNumberTrRaw = verse["verseNumberTrTemp"] as String;
      final mealId = verse["mealId"] as int;
      final verseContent = verse["verse"] as String;
      final verseNumber = verse["verseNumber"] as String;
      late final int verseNumberTr;

      final verseNumbersRawArr = verseNumberTrRaw.split(",");
      final first = int.parse(verseNumbersRawArr[0]);
      if(verseNumbersRawArr.length > 1){
        final second = int.parse(verseNumbersRawArr[1]);
        final verseNumbers = [for (var i = first; i <= second; i++) i];
        if(prevMealId != mealId){
          index = 0;
          prevMealId = mealId;
        }
        verseNumberTr = verseNumbers[index++];
      }else{
        verseNumberTr = first;
      }
      batch.rawInsert("""insert into VerseArabic(mealId,verse,verseNumber,verseNumberTr) Values(?,?,?,?)""",[mealId,verseContent,verseNumber,verseNumberTr]);
    }
    await batch.commit(noResult: true);
  });
});



