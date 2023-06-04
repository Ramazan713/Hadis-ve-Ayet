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

    return Card(
      color: isParentList==true?Theme.of(context).selectedRowColor:Theme.of(context).cardColor,
      child: ListTile(
        leading: Checkbox(
          value: item.isSelected,
          onChanged: (isChecked) {
            onClicked();
          },
        ),
        title: Text(listModel.name,style: Theme.of(context).textTheme.bodyLarge,),
        onTap: () {
          onClicked();
        },
        subtitle: Text("${listModel.itemCounts} ${listModel.sourceType.shortName}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
