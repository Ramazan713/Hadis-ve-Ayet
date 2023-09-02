import 'package:flutter/material.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/components/hadith_item/sections/content.dart';
import 'package:hadith/features/hadiths/presentation/shared/components/hadith_item/sections/hadith_buttons.dart';
import 'package:hadith/features/hadiths/presentation/shared/components/hadith_item/sections/header.dart';


class HadithItem extends StatefulWidget {

  final HadithListModel hadithList;
  final Function()? onFavoriteClick;
  final Function()? onListClick;
  final Function()? onShareClick;
  final Function()? onLongClick;
  final double fontSize;
  final SearchParam? searchParam;

  const HadithItem({Key? key,required this.hadithList, this.onFavoriteClick, this.onShareClick, this.onLongClick,
    this.onListClick,required this.searchParam, required this.fontSize}) : super(key: key);

  @override
  State<HadithItem> createState() => HadithItemState();
}

class HadithItemState extends State<HadithItem> {

  HadithListModel get hadithList => widget.hadithList;
  Hadith get hadith => hadithList.hadith;

  bool get isContentLarge => hadith.contentSize > K.hadithMaxContentLengthSize;


  final ValueNotifier<bool> showContinue = ValueNotifier(false);

  TextStyle? getSmallTextStyle(BuildContext context){
    return Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: widget.fontSize, fontWeight: FontWeight.w400, inherit: true);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    return InkWell(
      onLongPress: widget.onLongClick,
      borderRadius: borderRadius,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Padding(
          padding: const EdgeInsets.only(left: 7, right: 7, top: 13, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getHeader(context),
              const SizedBox(
                height: 7,
              ),
              getContentBody(context),
              const SizedBox(
                height: 5,
              ),
              getButtons(context)
            ],
          ),
        ),
      ),
    );
  }
}









