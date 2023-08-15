import 'package:flutter/material.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';

class CounterItem extends StatelessWidget {
  final Counter counter;
  final Function() onMenuClick;
  final Function() onClick;
  const CounterItem({Key? key,required this.counter,required this.onMenuClick,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        tileColor: Theme.of(context).cardColor,
        title: Text(counter.name,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: onMenuClick,
          icon: Icon(
            Icons.more_vert,
            size: 30,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        onTap: onClick,
        contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 13),
        dense: true,
      ),
    );
  }
}
