import 'package:flutter/material.dart';
import 'package:hadith/constants/extensions.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';


class SavePointItem extends StatelessWidget {
  final SavePoint item;
  final void Function()? editTitleListener;
  final void Function()? removeItemListener;
  final void Function()? onClick;
  final bool isSelected;

  const SavePointItem({Key? key,required this.item, this.onClick,
    required this.isSelected,this.editTitleListener,this.removeItemListener,
  }) : super(key: key);


  List<Widget>getBottomChildren(TextStyle? bodyStyle){
    List<Widget>children=[];

    children.add(Flexible(flex: 3,child: Text(item.destination.typeDescription,style: bodyStyle,)));
    children.add(Flexible(flex: 3, child: Text("pos: ${item.itemIndexPos} ",style: bodyStyle,)));
    children.add(Flexible(flex: 5, child: Text(DateTimeFormats.formatDate1(item.modifiedDate),style: bodyStyle,)));
    return children;
  }

  @override
  Widget build(BuildContext context) {

    final TextStyle? bodyStyle=Theme.of(context).textTheme.bodyText2;

    return GestureDetector(
      onTap: onClick,
      child: Card(
        color: isSelected?Theme.of(context).selectedRowColor:Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 3, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.save,
                          size: 30,
                        ),
                        Text( item.autoType.label,style: bodyStyle,textAlign: TextAlign.center,)
                      ],
                    )),
              ),
              Expanded(
                flex: 15,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: editTitleListener, icon: const Icon(Icons.edit)),
                          Flexible(child: Text("${item.title} ",style: bodyStyle,))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children:getBottomChildren(bodyStyle),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: IconButton(
                    onPressed: removeItemListener,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade300,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
