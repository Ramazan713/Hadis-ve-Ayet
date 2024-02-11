import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import './sections/content.dart';
import './sections/header.dart';
import './sections/list_icons.dart';


class VerseItem extends StatelessWidget {
  final Function() onLongPress;
  final Function()? onPress;
  final VerseListModel verseListModel;
  final FontModel fontModel;
  final SearchParam? searchParam;
  final bool isSelected;
  final bool showListVerseIcons;
  final ArabicVerseUI2X arabicVerseUIEnum;
  final EdgeInsets? margin;

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
    this.margin
  }) : super(key: key);

  Verse get verse  => verseListModel.verse;
  double get smallFontValue => fontModel.contentFontSize - 5.5;
  
  final double _borderRadius = 13;

  @override
  Widget build(BuildContext context) {

    final schema = Theme.of(context).colorScheme;
    final cardColor = isSelected ? schema.secondaryContainer : schema.surface;

    return Card(
      margin: margin ?? EdgeInsets.zero,
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




