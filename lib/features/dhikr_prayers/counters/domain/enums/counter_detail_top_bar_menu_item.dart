

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum CounterDetailTopBarMenuItems implements IMenuItem{
  reset(
    title: "Sıfırla",
    iconInfo: IconInfo(iconData: Icons.refresh)
  ),
  selectFontSize(
      title: "Yazı Boyutu",
      iconInfo: IconInfo(iconData: Icons.text_format)
  ),
  edit(
      title: "Düzenle",
      iconInfo: IconInfo(iconData: Icons.edit)
  ),
  setting(
      title: "Ayarlar",
      iconInfo: IconInfo(iconData: Icons.settings)
  );

  const CounterDetailTopBarMenuItems({
    required this.iconInfo,
    required this.title
  });

  @override
  final String title;

  @override
  final IconInfo iconInfo;


  static List<CounterDetailTopBarMenuItems> getItems({required bool hasCounter}){
    final items = CounterDetailTopBarMenuItems.values.toList();
    if(!hasCounter){
      items.remove(CounterDetailTopBarMenuItems.edit);
    }
    return items;
  }

}
