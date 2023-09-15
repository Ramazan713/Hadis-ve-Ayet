

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';

enum ShowCounterSelectMenuEnum implements IMenuItem{
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
  ),
  edit(
    title: "Düzenle",
    iconInfo: IconInfo(iconData: Icons.edit)
  ),
  remove(
      title: "Sil",
      iconInfo: IconInfo(iconData: Icons.delete_forever)
  );

  const ShowCounterSelectMenuEnum({required this.title, required this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo iconInfo;

  static List<ShowCounterSelectMenuEnum> getItems(Counter counter){
    final items = ShowCounterSelectMenuEnum.values.toList();
    if(counter.prayerId == null){
      items.remove(ShowCounterSelectMenuEnum.goToCustomPrayer);
    }else{
      items.remove(ShowCounterSelectMenuEnum.addToCustomPrayer);
    }
    return items;
  }

}