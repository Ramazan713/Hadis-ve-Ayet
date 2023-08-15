
import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum IslamicInfoTopBarMenuItem implements IMenuItem{

  fontSize(
      title: "Yazı Boyutu",
      iconInfo: IconInfo(iconData: Icons.font_download_rounded)
  );

  const IslamicInfoTopBarMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}