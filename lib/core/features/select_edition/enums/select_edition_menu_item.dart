


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum SelectEditionMenuItem implements IMenuItem{
  goToDownloaded(
    title: "Indirilenlere Git",
    iconInfo: IconInfo(iconData: Icons.download_done)
  ),
  addFavorite(
    title: "Favoriye Ekle",
    iconInfo: IconInfo(iconData: Icons.star_border)
  ),
  removeFavorite(
    title: "Favoriden Çıkar",
    iconInfo: IconInfo(iconData: Icons.star)
  );



  const SelectEditionMenuItem({
    required this.title,
    this.iconInfo
  });

  @override
  final String title;

  @override
  final IconInfo? iconInfo;


  static List<SelectEditionMenuItem> getMenuItems(bool isFavorite){
    final List<SelectEditionMenuItem> items = [
      SelectEditionMenuItem.goToDownloaded
    ];
    items.add(isFavorite ? SelectEditionMenuItem.removeFavorite : SelectEditionMenuItem.addFavorite);
    return items;
  }

}