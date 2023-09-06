

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum ShowCounterSelectMenuEnum implements IMenuItem{
  addToCustomPrayer(
    title: "Dualarıma Ekle",
    iconInfo: IconInfo(iconData: Icons.add)
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
}