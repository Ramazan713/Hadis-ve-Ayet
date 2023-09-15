
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran/prayer_in_quran.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';

enum PrayerInQuranBottomMenuItem implements IMenuItem{
  listen(
    title: "Dinle",
    iconInfo: IconInfo(iconData: Icons.play_arrow)
  ),
  addToCustomPrayer(
      title: "Dualarıma Ekle",
      iconInfo: IconInfo(iconData: Icons.add)
  ),
  goToCustomPrayer(
      title: "Dualarıma Git",
      iconInfo: IconInfo(iconData: Icons.open_in_new)
  ),
  share(
    title: "Paylaş",
    iconInfo: IconInfo(iconData: Icons.share)
  )
  ;

  const PrayerInQuranBottomMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;

  static List<PrayerInQuranBottomMenuItem> getItems(PrayerUnit<PrayerInQuran> prayer){
    final items = PrayerInQuranBottomMenuItem.values.toList();

    if(!prayer.anyVerses){
      items.remove(PrayerInQuranBottomMenuItem.listen);
    }
    if(prayer.item.parentPrayerId != null){
      items.remove(PrayerInQuranBottomMenuItem.addToCustomPrayer);
    }else{
      items.remove(PrayerInQuranBottomMenuItem.goToCustomPrayer);
    }
    return items;
  }
}