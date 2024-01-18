
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum CustomPrayerAddActionMenuEnum implements IMenuItem{
  addFromQuran(
    title: "Kurandan Ekle",
    iconInfo: IconInfo(iconData: FontAwesomeIcons.bookQuran)
  ),
  addFromList(
      title: "Listeden Ekle",
      iconInfo: IconInfo(iconData: Icons.view_list)
  ),
  addFromManuel(
      title: "Manuel Ekle",
      iconInfo: IconInfo(iconData: Icons.add_box)
  ),;

  const CustomPrayerAddActionMenuEnum({required this.title, required this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo iconInfo;
}