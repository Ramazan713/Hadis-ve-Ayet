import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/core/utils/search_utils.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';
import 'package:hadith/features/extra_features/quran_prayer/domain/model/quran_prayer.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';

class PrayerInQuranItem extends StatelessWidget {
  final PrayerInQuran prayer;
  final int order;
  final ArabicVerseUI2X verseUIEnum;
  final FontModel fontModel;
  final SearchParam searchParam;

  const PrayerInQuranItem({
    Key? key,
    required this.prayer,
    required this.order,
    required this.verseUIEnum,
    required this.fontModel,
    required this.searchParam
  }) : super(key: key);

  List<Widget> getContent(BuildContext context) {
    final items = <Widget>[];

    if (verseUIEnum.arabicVisible) {
      items.add(
        ArabicContentItem(
          content: prayer.arabicContent,
          fontSize: fontModel.arabicFontSize,
          fontFamily: fontModel.arabicFontFamilyEnum,
        )
      );
      items.add(const SizedBox(
        height: 8,
      ));
    }
    if (verseUIEnum.mealVisible) {
      final style = Theme.of(context).textTheme.bodyLarge
        ?.copyWith(fontSize: fontModel.contentFontSize);

      final searchedResults = SearchUtils.getSelectedText(
          context,
          content: prayer.meaningContent,
          searchParam: searchParam,
          textStyle: style
      );
      items.add(
        RichText(
          text: TextSpan(
            text: "",
            children: searchedResults,
          ),
        ),
      );
      items.add(const SizedBox(
        height: 8,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              order.toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: fontModel.contentFontSize
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            ...getContent(context),
            Text(
              prayer.source,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: fontModel.contentFontSize
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
