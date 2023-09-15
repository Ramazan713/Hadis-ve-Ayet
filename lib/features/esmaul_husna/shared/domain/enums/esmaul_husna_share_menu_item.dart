

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:flutter/material.dart';

enum EsmaulHusnaShareMenuItem implements IMenuItem{

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

  const EsmaulHusnaShareMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}