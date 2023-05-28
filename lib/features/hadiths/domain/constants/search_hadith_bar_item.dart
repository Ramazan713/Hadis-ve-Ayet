

import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:flutter/material.dart';

enum SearchHadithBarItem implements IMenuItem{

  cleanSearch(
      title: "Vurgu Temizle",
      iconInfo: IconInfo(iconData: Icons.clear_all)
  );

  const SearchHadithBarItem({required this.title, this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;
}