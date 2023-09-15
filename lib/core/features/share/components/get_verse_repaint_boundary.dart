

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/presentation/components/verses/verse_content_full_item.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/models/verse/verse_list_model.dart';

RepaintBoundary getVerseRepaintBoundary(
  BuildContext context,{
    required GlobalKey<State<StatefulWidget>> globalKey,
    required VerseListModel verseListModel,
    PrefKeyEnum<ArabicVerseUI2X>? pref
}){

  final currentKeyPref = pref ?? KPref.verseAppearanceEnum;
  final Verse verse = verseListModel.verse;

  final AppPreferences appPref = context.read<AppPreferences>();

  final ArabicVerseUI2X verseUiEnum = appPref.getEnumItem(currentKeyPref);
  final fontModel = context.read<FontModelUseCase>().call();

  return RepaintBoundary(
      key: globalKey,
      child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
            child: InkWell(
              borderRadius: BorderRadius.circular(19),
              child: Ink(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 3,),
                      Text(
                        "${verse.surahId}/${verse.surahName}",
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontSize: fontModel.contentFontSize),
                      ),
                      VerseContentFullItem(
                        arabicVerseUIEnum: verseUiEnum,
                        fontModel: fontModel,
                        verseListModel: verseListModel,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      )
  );
}