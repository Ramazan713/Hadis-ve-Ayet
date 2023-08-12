

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/model/prayer.dart';

@Entity(tableName: "PrayersOld")
class PrayerEntityOld{

  @primaryKey
  final int? id;
  final String name;
  final String meaningContent;
  final String arabicContent;
  final String? pronunciationContent;

  PrayerEntityOld({this.id,required this.name,required this.meaningContent,
    required this.pronunciationContent,required this.arabicContent});


  Prayer toPrayer(){
    return Prayer(
        id: id,
        name: name,
        meaningContent: meaningContent,
        pronunciationContent: pronunciationContent,
        arabicContent: arabicContent
    );
  }

}