

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:flutter/material.dart';

enum ListShareMenuItem implements IMenuItem{
  sharePdf(
      title: "PDF Olarak Paylaş",
      iconInfo: IconInfo(iconData: FontAwesomeIcons.filePdf)
  ),
  shareText(
      title: "Yazı Olarak Paylaş",
      iconInfo: IconInfo(iconData: Icons.text_format)
  );

  const ListShareMenuItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}