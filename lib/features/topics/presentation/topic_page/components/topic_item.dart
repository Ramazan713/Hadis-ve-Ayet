import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_dropdown_menu.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/features/topics/domain/enums/topic_save_point_menu_item.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

class TopicItem extends StatelessWidget {
  final TopicViewModel topicViewModel;
  final void Function() onTap;
  final void Function(TopicSavePointMenuItem) onMenuClick;
  final SourceTypeEnum sourceType;
  final bool hasSavePoint;
  final int? rowNumber;
  final EdgeInsets? margins;
  final bool isSelected;
  final bool isMenuEnabled;

  const TopicItem({Key? key,
    required this.sourceType,
    required this.topicViewModel,
    required this.hasSavePoint,
    required this.onTap,
    required this.rowNumber,
    required this.isSelected,
    required this.onMenuClick,
    this.isMenuEnabled = true,
    this.margins,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListTile(
      margins: margins ?? EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(right: 8,left: 16),
      isSelected: isSelected,
      defaultColor: Theme.of(context).colorScheme.secondaryContainer,
      selectedColor: Theme.of(context).colorScheme.secondaryContainer.withGreen(220),
      borderRadius: isSelected ? BorderRadius.circular(20) : null,
      title: Text(
        topicViewModel.name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: getLeading(context),
      subtitle: Text(
        "${topicViewModel.itemsCount} ${sourceType.shortName}",
      ),
      onTap: onTap,
      trailing: getTrailing(context),
    );
  }

  Widget? getTrailing(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(hasSavePoint)
          Icon(
            Icons.beenhere,
            color: Theme.of(context).colorScheme.error
          ),
        SelectAdaptiveDropdownMenu(
          enabled: isMenuEnabled,
          popWhenItemSelect: true,
          items: TopicSavePointMenuItem.getMenuItems(hasSavePoint),
          onItemClick: (selected, type){
            onMenuClick(selected);
          },
        ),
      ],
    );
  }

  Widget getLeading(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(FontAwesomeIcons.bookOpenReader),
        const SizedBox(
          height: 7,
        ),
        getRowNumberWidget(context)
      ],
    );
  }

  Widget getRowNumberWidget(BuildContext context){
    if(rowNumber == null) return const SizedBox();
    return Text(
        "$rowNumber",
        style: Theme.of(context).textTheme.bodySmall
    );
  }

}
