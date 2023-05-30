
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:flutter/material.dart';

enum HadithBottomMenuItem implements IMenuItem{
  savePoint(
    title: "Kayıt Noktası Oluştur",
    iconInfo: IconInfo(iconData: Icons.save)
  );

  const HadithBottomMenuItem({required this.title,this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}
