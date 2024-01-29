

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';

class SharedListItem extends StatelessWidget {

  final ListViewModel listViewModel;
  final Icon leading;
  final void Function() onClick;
  final String subTitleTag;
  final bool useSecondary;
  final Widget? trailing;
  final EdgeInsets? margins;

  const SharedListItem({
    Key? key,
    required this.subTitleTag,
    required this.listViewModel,
    required this.leading,
    required this.onClick,
    this.useSecondary = false,
    this.trailing,
    this.margins
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final schema = Theme.of(context).colorScheme;
    final tileColor = useSecondary ? schema.secondaryContainer : schema.primaryContainer;

    return CardListTile(
      margins: margins,
      defaultColor: tileColor,
      title: Text(
        listViewModel.name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: leading,
      subtitle: Text(
        "${listViewModel.itemCounts} $subTitleTag",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing,
      onTap: onClick,
    );
  }
}
