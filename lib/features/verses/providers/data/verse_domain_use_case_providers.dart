

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/verse_topic_get_downloaded_models_use_case.dart';

List<RepositoryProvider> pVerseDomainUseCaseProviders(BuildContext context){
  return [
    RepositoryProvider<VerseTopicGetDownloadedModelsUseCase>(create: (context){
      return VerseTopicGetDownloadedModelsUseCase(
        downloadedAudioViewRepo: context.read(),
        editionRepo: context.read(),
      );
    }),
  ];
}