


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';

enum CustomPrayerDetailTopBarMenuItems implements IMenuItem{
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
  edit(
      title: "Düzenle",
      iconInfo: IconInfo(iconData: Icons.edit)
  );

  const CustomPrayerDetailTopBarMenuItems({
    required this.iconInfo,
    required this.title
  });

  @override
  final String title;

  @override
  final IconInfo iconInfo;

  static List<CustomPrayerDetailTopBarMenuItems> getItems(PrayerCustom? prayer){

    if(prayer == null){
      return [
        CustomPrayerDetailTopBarMenuItems.selectFontSize,
        CustomPrayerDetailTopBarMenuItems.edit,
      ];
    }

    final items = CustomPrayerDetailTopBarMenuItems.values.toList();
    if(prayer.counterId == null) {
      items.remove(CustomPrayerDetailTopBarMenuItems.goToDhikr);
    } else {
      items.remove(CustomPrayerDetailTopBarMenuItems.addToDhikr);
    }
    return items;
  }
}
