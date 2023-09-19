import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/sections/content.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/sections/header.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/sections/list_icons.dart';

class VerseItem extends StatelessWidget {
  final Function() onLongPress;
  final Function()? onPress;
  final VerseListModel verseListModel;
  final FontModel fontModel;
  final SearchParam? searchParam;
  final bool isSelected;
  final bool showListVerseIcons;
  final ArabicVerseUI2X arabicVerseUIEnum;

  const VerseItem({
    Key? key,
    required this.fontModel,
    required this.arabicVerseUIEnum,
    required this.onLongPress,
    required this.verseListModel,
    required this.showListVerseIcons,
    this.isSelected=false,
    this.searchParam,
    this.onPress,
  }) : super(key: key);

  Verse get verse  => verseListModel.verse;
  double get smallFontValue => fontModel.contentFontSize - 5.5;
  
  final double _borderRadius = 13;

  @override
  Widget build(BuildContext context) {

    final schema = Theme.of(context).colorScheme;
    final cardColor = isSelected ? schema.secondaryContainer : schema.surface;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius)),
      child: InkWell(
        borderRadius: BorderRadius.circular(_borderRadius),
        onLongPress: onLongPress,
        onTap: onPress,
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                getHeader(context),
                getContent(context),
                getListIcons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}




