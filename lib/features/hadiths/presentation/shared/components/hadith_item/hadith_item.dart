import 'package:flutter/material.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/get_card_adaptive_padding.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import './sections/header.dart';
import './sections/content.dart';
import './sections/hadith_buttons.dart';


class HadithItem extends StatefulWidget {

  final HadithListModel hadithList;
  final Function()? onFavoriteClick;
  final Function()? onListClick;
  final Function()? onShareClick;
  final Function()? onLongClick;
  final double fontSize;
  final SearchParam? searchParam;
  final EdgeInsets? margin;
  final WindowSizeClass? windowSizeClass;

  const HadithItem({
    super.key,
    required this.hadithList,
    required this.searchParam,
    required this.fontSize,
    this.windowSizeClass,
    this.onFavoriteClick,
    this.onShareClick,
    this.onLongClick,
    this.onListClick,
    this.margin
  });

  @override
  State<HadithItem> createState() => HadithItemState();
}

class HadithItemState extends State<HadithItem> {

  HadithListModel get hadithList => widget.hadithList;
  Hadith get hadith => hadithList.hadith;

  bool get isContentLarge => hadith.contentSize > K.hadithMaxContentLengthSize;


  final ValueNotifier<bool> expandHadith = ValueNotifier(false);

  TextStyle? getSmallTextStyle(BuildContext context){
    return Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: widget.fontSize, fontWeight: FontWeight.w400, inherit: true);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      margin: widget.margin ?? EdgeInsets.zero,
      child: InkWell(
        onLongPress: widget.onLongClick,
        borderRadius: borderRadius,
        child: Padding(
          padding: getCardAdaptivePadding(context, windowSizeClass: widget.windowSizeClass),
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

  @override
  void dispose() {
    expandHadith.dispose();
    super.dispose();
  }
}









