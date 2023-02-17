import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';


class AddCounterItem extends StatelessWidget {
  final Counter counter;
  final Function() onClick;
  const AddCounterItem({Key? key, required this.counter, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        tileColor: Theme.of(context).cardColor,
        title: Text(counter.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Icon(Icons.add,color: Theme.of(context).iconTheme.color,),
        onTap: onClick,
      ),
    );
  }
}