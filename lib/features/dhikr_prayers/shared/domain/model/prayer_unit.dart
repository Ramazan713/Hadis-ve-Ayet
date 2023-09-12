

import 'package:equatable/equatable.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_verse_cross_ref/prayer_verse_cross_ref.dart';


class PrayerUnit<T> extends Equatable{
  final T item;
  final List<PrayerVerseCrossRef> prayerVerses;

  const PrayerUnit({required this.item, required this.prayerVerses});

  PrayerUnit copyWith({
    T? item,
    List<PrayerVerseCrossRef>? prayerVerses
  }){
    return PrayerUnit(
      item: item ?? this.item,
      prayerVerses: prayerVerses ?? this.prayerVerses
    );
  }

  bool get anyVerses => prayerVerses.isNotEmpty;

  List<int> get getVerseIds => prayerVerses.map((e) => e.verseId).toList();

  @override
  List<Object?> get props => [item,prayerVerses];
}
