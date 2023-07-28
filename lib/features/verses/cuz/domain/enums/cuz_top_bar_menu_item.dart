

import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum CuzTopBarMenuItem implements IMenuItem{
  selectEdition(
    title: "Kıraat Seç",
    iconInfo: IconInfo(iconData: Icons.record_voice_over)
  );

  const CuzTopBarMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}