
import 'package:flutter/material.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/verse_item.dart';
import 'package:hadith/themes/model/i_theme_model.dart';
import 'package:hadith/utils/theme_util.dart';

extension VerseItemListIconsExt on VerseItem{

  Widget getListIcons(BuildContext context) {

    if(!showListVerseIcons) return const SizedBox();

    final items = <Widget>[];
    final IThemeModel themeModel = ThemeUtil.getThemeModel(context);
    const opacity = 0.7;
    final iconSize = smallFontValue;

    if (verseListModel.isInAnyList) {
      items.add(Icon(
        Icons.library_add_check,
        size: iconSize,
        color: Theme.of(context).iconTheme.color?.withOpacity(opacity),
      ));
      items.add(const SizedBox(
        width: 5,
      ));
    }

    if (verseListModel.isInFavorite) {
      items.add(Icon(
        Icons.favorite,
        color: Theme.of(context).errorColor.withOpacity(opacity),
        size: iconSize,
      ));
      items.add(const SizedBox(
        width: 5,
      ));
    }

    if (verseListModel.isInAnyArchiveList) {
      items.add(Icon(
        Icons.library_add_check,
        size: iconSize,
        color: themeModel.getBlueShadeColor().withOpacity(opacity),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items,
    );
  }

}