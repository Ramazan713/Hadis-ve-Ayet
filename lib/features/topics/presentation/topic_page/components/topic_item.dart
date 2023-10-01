import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/presentation/components/card_list_tile/card_list_tile.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

class TopicItem extends StatelessWidget {
  final TopicViewModel topicViewModel;
  final void Function() onTap;
  final void Function()? onMenuClick;
  final SourceTypeEnum sourceType;
  final bool hasSavePoint;
  final int? rowNumber;

  const TopicItem({Key? key,
    required this.sourceType,
    this.onMenuClick,
    required this.topicViewModel,
    required this.hasSavePoint,
    required this.onTap,
    required this.rowNumber
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListTile(
      margins: const EdgeInsets.symmetric(vertical: 3),
      contentPadding: const EdgeInsets.only(right: 8,left: 16),
      defaultColor: Theme.of(context).colorScheme.secondaryContainer,
      title: Text(
        topicViewModel.name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: getLeading(context),
      subtitle: Text(
        "${topicViewModel.itemsCount} ${sourceType.shortName}",
      ),
      onTap: onTap,
      onLongPress: onMenuClick,
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
        IconButton(
          onPressed: onMenuClick,
          icon: const Icon(Icons.more_vert),
        )
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
