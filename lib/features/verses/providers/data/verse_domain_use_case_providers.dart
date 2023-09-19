

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verses/shared/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_cuz.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_page.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_surah.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_verse_number.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_verse_use_cases.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/verse_topic_get_downloaded_models_use_case.dart';

List<RepositoryProvider> pVerseDomainUseCaseProviders(BuildContext context){
  return [
    RepositoryProvider<VerseTopicGetDownloadedModelsUseCase>(create: (context){
      return VerseTopicGetDownloadedModelsUseCase(
        downloadedAudioViewRepo: context.read(),
        editionRepo: context.read(),
      );
    }),

    RepositoryProvider<SelectVerseUseCases>(create: (context){
      final selectVerseRepo = context.read<SelectVersePageRepo>();
      return SelectVerseUseCases(
        selectCuz: SelectCuz(selectVersePageRepo: selectVerseRepo),
        selectPage: SelectPage(selectVersePageRepo: selectVerseRepo),
        selectSurah: SelectSurah(selectVersePageRepo: selectVerseRepo),
        selectVerseNumber: SelectVerseNumber(selectVersePageRepo: selectVerseRepo)
      );
    })
  ];
}