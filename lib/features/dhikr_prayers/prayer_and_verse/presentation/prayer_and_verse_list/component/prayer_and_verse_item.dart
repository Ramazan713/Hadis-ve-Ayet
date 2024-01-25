import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';

class PrayerAndVerseItem extends StatelessWidget {
  final PrayerAndVerse prayer;
  final Function() onClick;
  final EdgeInsets? margins;

  const PrayerAndVerseItem({
    Key? key,
    required this.prayer,
    required this.onClick,
    this.margins
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListTile(
      margins: margins,
      title: Text(prayer.name),
      defaultColor: Theme.of(context).colorScheme.secondaryContainer,
      onTap: onClick,
    );
  }
}
