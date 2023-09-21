import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/title_text_item.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_collection.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_item.dart';

class InfoCollectionItem extends StatelessWidget {
  final IslamicInfoCollection collection;
  final bool showHorizontal;
  final double contentFontSize;

  const InfoCollectionItem({
    Key? key,
    required this.collection,
    required this.showHorizontal,
    required this.contentFontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getTitle(context),
          ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: collection.infoItems.length,
            itemBuilder: (context, index) {
              final item = collection.infoItems[index];
              return getContentItem(
                  context: context,
                  infoItem: item,
              );
            },
          )
        ],
      ),
    );
  }

  Widget getTitle(BuildContext context){
    final description = collection.infoTitle.description;
    if(description == null){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Text(
          collection.infoTitle.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: contentFontSize + 3,
            fontWeight: FontWeight.w500
          ),
        ),
      );
    }
    final w = MediaQuery.of(context).size.width / 10;
    return Column(
      children: [
        TitleSectionItem(
          title: collection.infoTitle.title,
          titleStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: contentFontSize + 3
          ),
          content: description,
          contentFontSize: contentFontSize,
          paddings: EdgeInsets.zero,
          useCard: false,
        ),
        Divider(
          endIndent: w,
          indent: w,
        )
      ],
    );
  }

  Widget getContentItem({
    required BuildContext context,
    required IslamicInfoItem infoItem,
  }){
    if(showHorizontal){
      return TitleSectionItem(
        title: "${infoItem.name}",
        content: infoItem.description ?? "",
        contentFontSize: contentFontSize,
        paddings: EdgeInsets.zero,
        useCard: false,
      );
    }else{
      return TitleTextItem(
        title: getNumberNameWithPadding(infoItem.name) ?? "",
        content: infoItem.description??"",
        margin: const EdgeInsets.symmetric(horizontal: 1),
        contentFontSize: contentFontSize,
        padding: const EdgeInsets.symmetric(vertical: 4),
      );
    }
  }

  String? getNumberNameWithPadding(String? name){
    if(name?.length == 1){
      return name?.padLeft(3);
    }
    return name;
  }

}
