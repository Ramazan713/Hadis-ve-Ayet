
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum ShowCounterAddActionMenuEnum implements IMenuItem{
  addFromManuel(
      title: "Manuel Ekle",
      iconInfo: IconInfo(iconData: Icons.add_box)
  ),
  addFromList(
      title: "Listeden Ekle",
      iconInfo: IconInfo(iconData: Icons.view_list)
  );

  const ShowCounterAddActionMenuEnum({required this.title, required this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo iconInfo;
}