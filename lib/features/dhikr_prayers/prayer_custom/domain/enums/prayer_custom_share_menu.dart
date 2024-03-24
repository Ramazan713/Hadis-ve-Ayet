

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum PrayerCustomShareMenu implements IMenuItem{

  shareJson(
      title: "Json Olarak Paylaş",
      iconInfo: IconInfo(iconData: Icons.file_present)
  ),
  shareText(
      title: "Yazı Olarak Paylaş",
      iconInfo: IconInfo(iconData: Icons.text_format)
  ),
  shareImage(
      title: "Resim Olarak Paylaş",
      iconInfo: IconInfo(iconData: Icons.image)
  ),
  copyText(
      title: "Kopyala",
      iconInfo: IconInfo(iconData: Icons.copy)
  );

  const PrayerCustomShareMenu({
    required this.title,
    this.iconInfo
  });

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}