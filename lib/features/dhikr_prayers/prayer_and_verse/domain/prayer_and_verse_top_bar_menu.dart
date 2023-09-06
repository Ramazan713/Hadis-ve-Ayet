


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';

enum PrayerAndVerseTopBarMenuItems implements IMenuItem{
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
  );

  const PrayerAndVerseTopBarMenuItems({
    required this.iconInfo,
    required this.title
  });

  @override
  final String title;

  @override
  final IconInfo iconInfo;

  static List<PrayerAndVerseTopBarMenuItems> getItems(PrayerAndVerse? prayer){
    final items = [PrayerAndVerseTopBarMenuItems.selectFontSize];

    if(prayer == null || prayer.parentPrayerId == null) {
      items.insert(0,PrayerAndVerseTopBarMenuItems.addToCustomPrayer);
    }else{
      items.insert(0,PrayerAndVerseTopBarMenuItems.goToCustomPrayer);
    }
    return items;
  }
}
