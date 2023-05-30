import 'package:flutter/material.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/utils/text_utils.dart';


class HadithItem extends StatelessWidget {

  final HadithListModel hadithList;
  final Function()? onFavoriteClick;
  final Function()? onListClick;
  final Function()? onShareClick;
  final Function()? onLongClick;
  final FontSize fontSizeEnum;
  final SearchParam? searchParam;

  HadithItem({Key? key,required this.hadithList, this.onFavoriteClick, this.onShareClick, this.onLongClick,
    this.onListClick,required this.searchParam, required this.fontSizeEnum}) : super(key: key);

  Hadith get hadith => hadithList.hadith;
  bool get isContentLarge => hadith.contentSize > kMaxContentSize;
  double get fontSize => fontSizeEnum.size;

  final ValueNotifier<bool> _showContinue = ValueNotifier(false);

  TextStyle? getTextStyle(BuildContext context){
    return Theme.of(context).textTheme.bodyText1?.copyWith(
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
                _getHeader(context),
                const SizedBox(
                  height: 7,
                ),
                _getContentWidget(context),
                const SizedBox(
                  height: 13,
                ),
                Text("- ${hadithList.hadith.source}",
                    textAlign: TextAlign.center,
                    style: getTextStyle(context)?.copyWith(fontSize: fontSize - 4)
                ),
                const SizedBox(
                  height: 5,
                ),
                _getButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${hadithList.rowNumber}",
          textAlign: TextAlign.start,
          style: getTextStyle(context)?.copyWith(fontSize: fontSize - 2),
        ),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          child: Text("- ${hadithList.topicNames}",
              textAlign: TextAlign.center,
              style:
              getTextStyle(context)?.copyWith(fontSize: fontSize - 4)),
        ),
        const SizedBox(
          width: 33,
        )
      ],
    );
  }


  Widget _getButtons(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(),
        IconButton(
          onPressed: onShareClick,
          icon: const Icon(Icons.share),
        ),
        IconButton(
          onPressed: onFavoriteClick,
          icon: hadithList.isInFavorite? const Icon(
            Icons.favorite,color: Colors.red,
          ): const Icon(Icons.favorite),
        ),
        IconButton(
          onPressed: onListClick,
          icon: Icon(hadithList.isInAnyList? Icons.library_add_check:Icons.library_add),
        ),
        const SizedBox(),
      ],
    );
  }

}


// Content Widgets
extension HadithItemContentExt on HadithItem{

  TextSpan _getContinueWidget(BuildContext context){
    return TextSpan(children: [
      WidgetSpan(
          child: InkWell(
            child: Text(
              "  ... devamını göster",
              style: getTextStyle(context)?.copyWith(
                  fontWeight: FontWeight.w500, fontSize: fontSize - 2),
            ),
            onTap: () {
              _showContinue.value = true;
            },
          )),
    ]);
  }

  List<TextSpan> _getContentChildren(BuildContext context, bool showContinue){
    final content = !showContinue && isContentLarge
        ? hadith.content.substring(0, kMaxContentSize)
        : hadith.content;

    final widgets = TextUtils.getSelectedText(
        content,
        searchParam?.searchQuery,
        searchCriteriaEnum: searchParam?.searchCriteria,
        context: context,
        textStyle: getTextStyle(context),
        inheritTextStyle: true
    );

    if (!showContinue && isContentLarge) {
      widgets.add(_getContinueWidget(context));
    }
    return widgets;
  }

  Widget _getContentWidget(BuildContext context){

    return ValueListenableBuilder<bool>(
        valueListenable: _showContinue,
        builder: (context,showContinue,child){
          return RichText(
            text: TextSpan(
              children: _getContentChildren(context,showContinue),
            ),
            textAlign: TextAlign.center,
          );
        }
    );
  }

}








