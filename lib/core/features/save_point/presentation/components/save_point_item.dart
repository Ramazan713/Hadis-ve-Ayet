import 'package:flutter/material.dart';
import 'package:hadith/core/extensions/date_time_ext.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';

class SavePointItem extends StatelessWidget {
  final SavePoint item;
  final void Function()? editTitleListener;
  final void Function()? removeItemListener;
  final void Function()? onClick;
  final bool isSelected;

  const SavePointItem({
    Key? key,
    required this.item,
    this.onClick,
    required this.isSelected,
    this.editTitleListener,
    this.removeItemListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final schema = Theme.of(context).colorScheme;
    final color = isSelected ? schema.primaryContainer : schema.surfaceVariant;

    return GestureDetector(
      onTap: onClick,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 1,vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 3,
                child: getLeading(context),
              ),
              Expanded(
                flex: 15,
                child: getCenter(context),
              ),
              Expanded(
                flex: 2,
                child: getTrailing(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getLeading(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.save,
            size: 30,
          ),
          Text(
            item.autoType.label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      )
    );
  }
  
  Widget getCenter(BuildContext context){
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: editTitleListener, 
                  icon: const Icon(Icons.edit)
              ),
              Flexible(
                  child: Text(
                    "${item.title} ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
              )
            ],
          ),
        ),
        getBottomInfo(context)
      ],
    );
  }
  
  Widget getTrailing(BuildContext context){
    return IconButton(
      onPressed: removeItemListener,
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.error,
      )
    );
  }
  
  
  Widget getBottomInfo(BuildContext context){
    final textStyle = Theme.of(context).textTheme.bodySmall;
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 3,
          child: Text(
            item.destination.typeDescription,
            style: textStyle,
          )
        ),
        Flexible(
          flex: 3,
          child: Text(
            "pos: ${item.itemPos} ",
            style: textStyle,
          )
        ),
        Flexible(
          flex: 5, 
          child: Text(
            DateTimeFormats.formatDate1(item.modifiedDate),
            style: textStyle,
          )
        )
      ],
    );
  }
}
