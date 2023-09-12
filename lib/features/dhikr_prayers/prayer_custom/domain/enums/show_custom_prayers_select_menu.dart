


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

enum ShowCustomPrayersSelectMenuEnum implements IMenuItem{
  addToDhikr(
      title: "Zikir olarak ekle",
      iconInfo: IconInfo(iconData: Icons.add)
  ),
  goToDhikr(
      title: "Zikre devam et",
      iconInfo: IconInfo(iconData: Icons.open_in_new)
  ),
  updateToDhikr(
      title: "Zikri güncelle",
      iconInfo: IconInfo(iconData: Icons.update)
  ),
  edit(
      title: "Düzenle",
      iconInfo: IconInfo(iconData: Icons.edit)
  ),
  remove(
      title: "Sil",
      iconInfo: IconInfo(iconData: Icons.delete_forever)
  );

  const ShowCustomPrayersSelectMenuEnum({required this.title, required this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo iconInfo;

  static List<ShowCustomPrayersSelectMenuEnum> getItems(PrayerCustom prayer){
    final items = ShowCustomPrayersSelectMenuEnum.values.toList();
    if(prayer.counterId == null) {
      items.remove(ShowCustomPrayersSelectMenuEnum.goToDhikr);
    } else {
      items.remove(ShowCustomPrayersSelectMenuEnum.addToDhikr);
    }
    if(!prayer.updateCounter){
      items.remove(ShowCustomPrayersSelectMenuEnum.updateToDhikr);
    }

    return items;
  }

}