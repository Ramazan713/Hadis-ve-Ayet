
import 'package:floor/floor.dart';

import '../../domain/model/quran_prayer.dart';

@Entity(tableName: "PrayerQuran")
class QuranPrayerEntity{
  @primaryKey
  final int?id;
  final String arabicContent;
  final String meaningContent;
  final String source;

  QuranPrayerEntity({this.id,required this.arabicContent,
    required this.source, required this.meaningContent
  });

  QuranPrayer toQuranPrayer(){
    return QuranPrayer(
      id: id,
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      source: source
    );
  }


}