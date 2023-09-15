import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/features/extra_features/quran_prayer/domain/model/quran_prayer.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';

class ShowQuranPrayerItem extends StatelessWidget {
  final QuranPrayer prayerItem;
  final int order;
  final ArabicVerseUI2X verseUIEnum;
  final double fontSize;
  const ShowQuranPrayerItem(
      {Key? key,
      required this.prayerItem,
      required this.order,
      required this.verseUIEnum,
      required this.fontSize})
      : super(key: key);

  List<Widget> getContent(BuildContext context) {
    final items = <Widget>[];

    if (verseUIEnum.arabicVisible) {
      items.add(
        getArabicContentWidget(prayerItem.arabicContent, fontSize + 2,
            textAlign: TextAlign.end),
      );
      items.add(const SizedBox(
        height: 8,
      ));
    }
    if (verseUIEnum.mealVisible) {
      items.add(
        Text(
          prayerItem.meaningContent,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: fontSize),
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
                fontSize: fontSize - 3
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            ...getContent(context),
            Text(
              prayerItem.source,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: fontSize
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
