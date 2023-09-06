import 'package:flutter/material.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';

class PrayerAndVerseItem extends StatelessWidget {
  final PrayerAndVerse prayer;
  final Function() onClick;

  const PrayerAndVerseItem({
    Key? key,
    required this.prayer,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: ListTile(
        title: Text(prayer.name),
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        onTap: onClick,
      ),
    );
  }
}
