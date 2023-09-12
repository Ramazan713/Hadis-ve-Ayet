import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/core/utils/search_utils.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/domain/enums/prayer_in_quran_bottom_menu_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran/prayer_in_quran.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';
import 'package:hadith/features/extra_features/quran_prayer/domain/model/quran_prayer.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';

class PrayerInQuranItem extends StatelessWidget {
  final PrayerUnit<PrayerInQuran> prayerUnit;
  final int order;
  final ArabicVerseUI2X verseUIEnum;
  final FontModel fontModel;
  final SearchParam searchParam;
  final void Function(PrayerInQuranBottomMenuItem menuItem)? onMenuSelect;
  final EdgeInsets? paddings;
  final EdgeInsets? margins;
  final bool isSelected;

  const PrayerInQuranItem({
    Key? key,
    required this.prayerUnit,
    required this.order,
    required this.verseUIEnum,
    required this.fontModel,
    required this.searchParam,
    required this.isSelected,
    this.onMenuSelect,
    this.margins,
    this.paddings
  }) : super(key: key);

  PrayerInQuran get prayer => prayerUnit.item;

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    final cardColor = isSelected ? colorSchema.secondaryContainer :colorSchema.surface;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      margin: margins ?? const EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      child: Padding(
        padding: paddings ?? const EdgeInsets.only(left: 7,right: 7,bottom: 7,top: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getHeader(context),
            const SizedBox(height: 4,),
            getContent(context),
            getSource(context)
          ],
        ),
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          order.toString(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: fontModel.contentFontSize
          ),
        ),
        if(onMenuSelect!=null)
          CustomDropdownIconMenu(
            iconData: Icons.more_horiz,
            items: PrayerInQuranBottomMenuItem.getItems(prayerUnit),
            onSelected: (selected){
              onMenuSelect?.call(selected);
            }
          )
      ],
    );
  }

  Widget getContent(BuildContext context) {
    return Column(
      children: getContentItems(context),
    );
  }
  
  Widget getSource(BuildContext context){
    return Text(
      prayer.source,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: fontModel.contentFontSize
      ),
      textAlign: TextAlign.end,
    );
  }

  List<Widget> getContentItems(BuildContext context){
    final style = Theme.of(context).textTheme.bodyLarge
        ?.copyWith(fontSize: fontModel.contentFontSize);

    final searchedResults = SearchUtils.getSelectedText(
        context,
        content: prayer.meaningContent,
        searchParam: searchParam,
        textStyle: style
    );

    return [
      if (verseUIEnum.arabicVisible)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ArabicContentItem(
            content: prayer.arabicContent,
            fontSize: fontModel.arabicFontSize,
            fontFamily: fontModel.arabicFontFamilyEnum,
          ),
        ),

      if(verseUIEnum.mealVisible)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: RichText(
            text: TextSpan(
              text: "",
              children: searchedResults,
            ),
          ),
        ),
    ];
  }

}
