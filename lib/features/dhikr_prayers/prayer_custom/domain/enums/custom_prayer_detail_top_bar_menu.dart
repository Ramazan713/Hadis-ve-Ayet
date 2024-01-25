


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';

enum CustomPrayerDetailTopBarMenuItems implements IMenuItem{
  navToSurah(
      title: "Bulunduğu Sure'ye Git",
      iconInfo: IconInfo(iconData: Icons.open_in_new)
  ),
  addToDhikr(
      title: "Zikir olarak ekle",
      iconInfo: IconInfo(iconData: Icons.add)
  ),
  goToDhikr(
      title: "Zikre devam et",
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

  const CustomPrayerDetailTopBarMenuItems({
    required this.iconInfo,
    required this.title
  });

  @override
  final String title;

  @override
  final IconInfo iconInfo;

  static List<CustomPrayerDetailTopBarMenuItems> getItems(PrayerUnit<PrayerCustom>? prayer){

    if(prayer == null){
      return [
        CustomPrayerDetailTopBarMenuItems.selectFontSize,
        CustomPrayerDetailTopBarMenuItems.selectEdition
      ];
    }

    final items = CustomPrayerDetailTopBarMenuItems.values.toList();
    if(prayer.item.counterId == null) {
      items.remove(CustomPrayerDetailTopBarMenuItems.goToDhikr);
    } else {
      items.remove(CustomPrayerDetailTopBarMenuItems.addToDhikr);
    }
    if(!prayer.anyVerses){
      items.remove(CustomPrayerDetailTopBarMenuItems.navToSurah);
    }

    return items;
  }
}
