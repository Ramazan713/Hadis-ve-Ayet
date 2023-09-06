


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum PrayerAndVerseTopBarMenuItems implements IMenuItem{
  selectFontSize(
      title: "Yazı Boyutu",
      iconInfo: IconInfo(iconData: Icons.text_format)
  );

  const PrayerAndVerseTopBarMenuItems({
    required this.iconInfo,
    required this.title
  });

  @override
  final String title;

  @override
  final IconInfo iconInfo;
}
