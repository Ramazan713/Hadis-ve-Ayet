

import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum VerseTopBarMenuItem implements IMenuItem{

  fontSize(
      title: "Yazı Boyutu",
      iconInfo: IconInfo(iconData: Icons.font_download_rounded)
  ),
  savePoint(
      title: "Kayıt Noktası",
      iconInfo: IconInfo(iconData: Icons.save)
  ),
  selectEdition(
    title: "Kıraat Seç",
    iconInfo: IconInfo(iconData: Icons.record_voice_over)
  );

  const VerseTopBarMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}