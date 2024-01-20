


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';

enum PrayerAndVerseTopBarMenuItems implements IMenuItem{
  navToSurah(
      title: "Bulunduğu Sure'ye Git",
      iconInfo: IconInfo(iconData: Icons.open_in_new)
  ),
  addToCustomPrayer(
      title: "Dualarıma Ekle",
      iconInfo: IconInfo(iconData: Icons.add)
  ),
  goToCustomPrayer(
      title: "Dualarıma Git",
      iconInfo: IconInfo(iconData: Icons.open_in_new)
  ),
  selectFontSize(
      title: "Yazı Boyutu",
      iconInfo: IconInfo(iconData: Icons.text_format)
  ),
  selectEdition(
      title: "Kıraat Seç",
      iconInfo: IconInfo(iconData: Icons.record_voice_over)
  );

  const PrayerAndVerseTopBarMenuItems({
    required this.iconInfo,
    required this.title
  });

  @override
  final String title;

  @override
  final IconInfo iconInfo;

  static List<PrayerAndVerseTopBarMenuItems> getItems(PrayerUnit<PrayerAndVerse>? prayerUnit){
    final items = [
      PrayerAndVerseTopBarMenuItems.selectFontSize,
      PrayerAndVerseTopBarMenuItems.selectEdition
    ];

    if(prayerUnit == null || prayerUnit.item.parentPrayerId == null) {
      items.insert(0,PrayerAndVerseTopBarMenuItems.addToCustomPrayer);
    }else{
      items.insert(0,PrayerAndVerseTopBarMenuItems.goToCustomPrayer);
    }
    if(prayerUnit?.anyVerses == true){
      items.insert(0, PrayerAndVerseTopBarMenuItems.navToSurah);
    }
    return items;
  }
}
