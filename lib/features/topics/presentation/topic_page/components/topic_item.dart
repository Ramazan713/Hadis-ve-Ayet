import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13)
        ),
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          topicViewModel.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: getLeading(context),
        subtitle: Text(
          "${topicViewModel.itemsCount} ${sourceType.shortName}",
        ),
        onTap: onTap,
        onLongPress: onLongPress,
        trailing: getTrailing(context),
      ),
    );
  }

  Widget? getTrailing(BuildContext context){
    if(!hasSavePoint) return null;
    return Icon(
      Icons.beenhere,
      color: Theme.of(context).colorScheme.error
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
