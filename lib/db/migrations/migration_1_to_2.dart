

import 'package:floor/floor.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';

final migration1To2=Migration(1, 2, (database)async{
  await database.execute("""CREATE TABLE if not exists "VerseArabic" (
      "mealId"	INTEGER NOT NULL,
      "verse"	TEXT NOT NULL,
      "verseNumber"	TEXT NOT NULL,
      FOREIGN KEY("mealId") REFERENCES "Verse"("id")
    )""");
});
