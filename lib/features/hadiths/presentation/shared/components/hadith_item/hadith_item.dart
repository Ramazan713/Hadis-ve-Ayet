import 'package:flutter/material.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/components/hadith_item/extensions/content.dart';
import 'package:hadith/features/hadiths/presentation/shared/components/hadith_item/extensions/hadith_buttons.dart';
import 'package:hadith/features/hadiths/presentation/shared/components/hadith_item/extensions/header.dart';
import 'package:hadith/utils/text_utils.dart';


class HadithItem extends StatelessWidget {

  final HadithListModel hadithList;
  final Function()? onFavoriteClick;
  final Function()? onListClick;
  final Function()? onShareClick;
  final Function()? onLongClick;
  final double fontSize;
  final SearchParam? searchParam;

  HadithItem({Key? key,required this.hadithList, this.onFavoriteClick, this.onShareClick, this.onLongClick,
    this.onListClick,required this.searchParam, required this.fontSize}) : super(key: key);

  Hadith get hadith => hadithList.hadith;
  bool get isContentLarge => hadith.contentSize > kMaxContentSize;

  final ValueNotifier<bool> showContinue = ValueNotifier(false);

  TextStyle? getTextStyle(BuildContext context){
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: fontSize, fontWeight: FontWeight.w400, inherit: true);
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onLongPress: onLongClick,
        child: Ink(
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
      ),
    );
  }

}









