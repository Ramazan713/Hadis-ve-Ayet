

import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum SurahTopBarMenuItem implements IMenuItem{
  selectSavePoint(
    title: "Kayıt Noktası",
    iconInfo: IconInfo(iconData: Icons.save)
  ),
  selectEdition(
    title: "Kıraat Seç",
    iconInfo: IconInfo(iconData: Icons.record_voice_over)
  );

  const SurahTopBarMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}