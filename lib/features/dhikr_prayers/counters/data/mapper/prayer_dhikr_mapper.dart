

import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';

extension PrayerDhikrEx on PrayerDhikr{
  Counter toCounter({
    int? id,
    CounterType counterType = CounterType.classic,
    int order = 0
  }){
    return Counter(
      name: name,
      meaning: meaningContent,
      arabicContent: arabicContent,
      description: null,
      content: pronunciationContent,
      goal: null,
      lastCounter: 0,
      counterType: counterType,
      id: id,
      order: order
    );
  }
}