


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';

enum HomeTopBarMenuItems implements IMenuItem{
  settings(
      title: "Ayarlar",
      iconInfo: IconInfo(iconData: Icons.settings)
  );

  const HomeTopBarMenuItems({
    required this.iconInfo,
    required this.title
  });

  @override
  final String title;

  @override
  final IconInfo iconInfo;
}
