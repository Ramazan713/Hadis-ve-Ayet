import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/presentation/components/title_text_item.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_item.dart';
import 'package:hadith/widgets/title_section_item.dart';


class InfoDetailItem extends StatelessWidget {
  final IslamicInfoItem infoItem;
  final bool showHorizontal;
  final double fontSize;

  const InfoDetailItem({
    Key? key,
    required this.infoItem,
    required this.showHorizontal,
    required this.fontSize
  }) : super(key: key);

  Widget getChild(BuildContext context){

    final bodyStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: fontSize
    );

    if(showHorizontal){
      return TitleSectionItem(
        title: infoItem.name??"",
        elevation: 0,
        borderSide: BorderSide.none,
        padding: const EdgeInsets.symmetric(vertical: 7),
        titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: fontSize
        ),
        child: Text(
          infoItem.description??"",
          style: bodyStyle,
        ),
      );
    }else{
      return TitleTextItem(
        title: infoItem.name??"",
        content: infoItem.description??"",
        margin: EdgeInsets.zero,
        borderSide: BorderSide.none,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 5),
        contentTextStyle: bodyStyle,
        titleTextStyle: bodyStyle,
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
