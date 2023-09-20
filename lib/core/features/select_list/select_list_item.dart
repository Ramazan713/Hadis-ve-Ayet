import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/selectable_list_view_model.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_checkbox_list_tile.dart';

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

    return CardCheckboxListTile(
      margins: const EdgeInsets.symmetric(vertical: 4,horizontal: 1),
      isSelected: item.isSelected,
      isSelectedCard: isParentList,
      borderWidth: 0.7,
      elevation: 1,
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
      ),
    );
  }
}
