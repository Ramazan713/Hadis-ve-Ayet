import 'package:flutter/material.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';


class AddCounterItem extends StatelessWidget {
  final PrayerDhikr item;
  final Function() onClick;

  const AddCounterItem({
    Key? key,
    required this.item,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        tileColor: Theme.of(context).cardColor,
        title: Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: Icon(Icons.add,color: Theme.of(context).iconTheme.color,),
        onTap: onClick,
      ),
    );
  }
}