

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';

class ListItem extends StatelessWidget {
  final ListViewModel listViewModel;
  final void Function() onMenuClick;
  final Icon icon;
  final void Function() onClick;
  final String subTitleTag;

  const ListItem(
      {Key? key,
        required this.subTitleTag,
        required this.listViewModel,
        required this.icon,
        required this.onClick,
        required this.onMenuClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        title: Text(
          listViewModel.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: icon,
        subtitle: Text(
          "${listViewModel.itemCounts} $subTitleTag",
          style: Theme.of(context).textTheme.bodyMedium,
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
      ),
    );
  }
}
