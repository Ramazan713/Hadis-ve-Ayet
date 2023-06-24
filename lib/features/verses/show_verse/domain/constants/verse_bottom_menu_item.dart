

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

enum VerseBottomMenuItem implements IMenuItem{
  play(
    title: "Dinle",
    iconInfo: IconInfo(iconData: Icons.play_arrow,)
  ),
  share(
      title: "Paylaş",
      iconInfo: IconInfo(iconData: Icons.share,)
  ),
  copy(
      title: "İçeriği Kopyala",
      iconInfo: IconInfo(iconData: Icons.copy,)
  ),

  addList(
      title: "Listeye Ekle",
      iconInfo: IconInfo(iconData: Icons.library_add,)
  ),
  deleteList(
      title: "Listeden Çıkar",
      iconInfo: IconInfo(iconData: Icons.library_add_check,)
  ),
  addFavorite(
      title: "Favoriye Ekle",
      iconInfo: IconInfo(iconData: Icons.favorite,)
  ),
  deleteFavorite(
      title: "Favoriden Çıkar",
      iconInfo: IconInfo(iconData: Icons.favorite,color: Colors.red)
  ),
  savePoint(
      title: "Kayıt Noktası Oluştur",
      iconInfo: IconInfo(iconData: Icons.save,)
  );

  const VerseBottomMenuItem({required this.title,this.iconInfo});

  @override
  final String title;

  @override
  final IconInfo? iconInfo;


  static List<VerseBottomMenuItem> getItems({required bool isInAnyList, required bool inInFavorite}){

    final items = VerseBottomMenuItem.values.toList();

    final listItem = isInAnyList ? VerseBottomMenuItem.addList :
      VerseBottomMenuItem.deleteList;

    final favItem = inInFavorite ? VerseBottomMenuItem.addFavorite :
        VerseBottomMenuItem.deleteFavorite;

    items.remove(listItem);
    items.remove(favItem);

    return items;
  }

}