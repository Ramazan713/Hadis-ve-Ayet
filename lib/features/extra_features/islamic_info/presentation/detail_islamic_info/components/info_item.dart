import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info_item.dart';
import 'package:hadith/widgets/title_section_item.dart';
import 'package:hadith/widgets/title_text_item.dart';


class InfoItem extends StatelessWidget {
  final IslamicInfoItem infoItem;
  final Axis itemAxis;
  const InfoItem({Key? key, required this.infoItem,required this.itemAxis}) : super(key: key);

  Widget getChild(BuildContext context){
    if(itemAxis == Axis.vertical){
      return TitleSectionItem(
        title: infoItem.name??"",
        elevation: 0,
        borderSide: BorderSide.none,
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Text(infoItem.description??"",style: Theme.of(context).textTheme.bodyLarge,),
      );
    }else{
      return TitleTextItem(
        title: infoItem.name??"",
        content: infoItem.description??"",
        margin: EdgeInsets.zero,
        borderSide: BorderSide.none,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 5),
        contentTextStyle: Theme.of(context).textTheme.bodyLarge,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 0,
      child: getChild(context),
    );
  }
}
