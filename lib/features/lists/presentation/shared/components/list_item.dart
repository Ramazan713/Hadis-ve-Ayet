

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';

class SharedListItem extends StatelessWidget {

  final ListViewModel listViewModel;
  final void Function() onMenuClick;
  final Icon icon;
  final void Function() onClick;
  final String subTitleTag;

  const SharedListItem({
    Key? key,
    required this.subTitleTag,
    required this.listViewModel,
    required this.icon,
    required this.onClick,
    required this.onMenuClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)
        ),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
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
          icon: const Icon(
            Icons.more_vert,
            size: 30,
          ),
        ),
        onTap: onClick,
      ),
    );
  }
}
