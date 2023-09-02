
import 'package:flutter/material.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/verse_item.dart';
import 'package:hadith/themes/model/i_theme_model.dart';
import 'package:hadith/utils/theme_util.dart';

extension VerseItemListIconsExt on VerseItem{

  Widget getListIcons(BuildContext context) {

    if(!showListVerseIcons) return const SizedBox();
    final items = <Widget>[];
    final iconSize = smallFontValue;

    if (verseListModel.isInAnyList) {
      items.add(Icon(
        Icons.library_add_check,
        size: iconSize,
        color: Theme.of(context).colorScheme.primary,
      ));
      items.add(const SizedBox(
        width: 5,
      ));
    }

    if (verseListModel.isInFavorite) {
      items.add(Icon(
        Icons.favorite,
        color: Theme.of(context).colorScheme.error,
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
        color: Theme.of(context).colorScheme.tertiary,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items,
    );
  }

}