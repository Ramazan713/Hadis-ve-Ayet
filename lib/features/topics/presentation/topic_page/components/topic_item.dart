import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/db/entities/helper/item_count_model.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

class TopicItem extends StatelessWidget {
  final TopicViewModel topicViewModel;
  final void Function() onTap;
  final void Function()? onLongPress;
  final SourceTypeEnum sourceType;
  final bool hasSavePoint;
  final int? rowNumber;

  const TopicItem(
      {Key? key,
        required this.sourceType,
        this.onLongPress,
        required this.topicViewModel,
        required this.hasSavePoint,
        required this.onTap,
        required this.rowNumber
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText2Style = Theme.of(context).textTheme.bodyText2;

    return Card(
        color: Theme.of(context).colorScheme.secondary,
        child: ListTile(
          title: Text(
            topicViewModel.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.bookOpenReader,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(
                height: 7,
              ),
              rowNumber == null
                  ? const SizedBox()
                  : Text(
                "${rowNumber}",
                style: bodyText2Style?.copyWith(
                    fontSize: (bodyText2Style.fontSize ?? 3) - 3),
              )
            ],
          ),
          subtitle: Text(
            "${topicViewModel.itemsCount} ${sourceType.shortName}",
            style: bodyText2Style,
          ),
          onTap: onTap,
          onLongPress: onLongPress,
          trailing: hasSavePoint
              ? Icon(
            Icons.beenhere,
            color: Theme.of(context).errorColor,
          )
              : null,
        ));
  }
}
