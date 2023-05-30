

import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:flutter/material.dart';

enum HadithShareMenuItem implements IMenuItem{
  shareImage(
    title: "Resim Olarak Paylaş",
    iconInfo: IconInfo(iconData: Icons.image)
  ),
  shareText(
      title: "Yazı Olarak Paylaş",
      iconInfo: IconInfo(iconData: Icons.text_format)
  ),
  copyText(
      title: "Yazıyı Kopyala",
      iconInfo: IconInfo(iconData: Icons.copy)
  );

  const HadithShareMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}