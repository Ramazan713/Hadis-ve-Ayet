import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/model/prayer.dart';


class ShowPrayerItem extends StatelessWidget {
  final Prayer prayer;
  final Function() onClick;
  const ShowPrayerItem({Key? key,required this.prayer,required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: ListTile(
        title: Text(prayer.name),
        tileColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        onTap: onClick,
      ),
    );
  }
}
