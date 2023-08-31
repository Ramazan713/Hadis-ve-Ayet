import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/selectable_list_view_model.dart';

class SelectListItem extends StatelessWidget {

  final SelectableListViewModel item;
  final bool isParentList;
  final void Function() onClicked;

  const SelectListItem({
    Key? key,
    required this.item,
    required this.isParentList,
    required this.onClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final listModel = item.listViewModel;
    final tileColor = isParentList ? Theme.of(context).colorScheme.secondaryContainer : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 1),
      child: CheckboxListTile(
        value: item.isSelected,
        selected: item.isSelected,
        tileColor: tileColor,
        selectedTileColor: tileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onChanged: (selected){
          onClicked.call();
        },
        title: Text(
          listModel.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          "${listModel.itemCounts} ${listModel.sourceType.shortName}",
          style: Theme.of(context).textTheme.bodyMedium,
        ) ,
      ),
    );
  }
}
