
import 'package:flutter/material.dart';
import '../verse_item.dart';

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