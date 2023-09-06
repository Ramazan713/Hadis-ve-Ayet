
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';

enum PrayerInQuranBottomMenuItem implements IMenuItem{

  addToCustomPrayer(
      title: "Dualarıma Ekle",
      iconInfo: IconInfo(iconData: Icons.add)
  ),
  goToCustomPrayer(
      title: "Dualarıma Git",
      iconInfo: IconInfo(iconData: Icons.open_in_new)
  );

  const PrayerInQuranBottomMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;

  static List<PrayerInQuranBottomMenuItem> getItems(PrayerInQuran prayer){
    if(prayer.parentPrayerId != null){
      return [PrayerInQuranBottomMenuItem.goToCustomPrayer];
    }
    return [PrayerInQuranBottomMenuItem.addToCustomPrayer];
  }
}