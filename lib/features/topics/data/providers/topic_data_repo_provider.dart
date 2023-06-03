

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/topics/data/repo/section_view_repo_impl.dart';
import 'package:hadith/features/topics/domain/repo/section_view_repo.dart';
import 'package:hadith/features/topics/domain/repo/topic_view_repo.dart';

import '../repo/topic_view_repo_impl.dart';

List<RepositoryProvider> pTopicDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<SectionViewRepo>(create: (context)=> SectionViewRepoImpl(
        sectionViewDao: appDatabase.sectionViewDao, queryExtUseCase: context.read())),
    RepositoryProvider<TopicViewRepo>(create: (context)=> TopicViewRepoImpl(
        topicHadithViewDao: appDatabase.topicHadithsViewDao,
        topicVersesViewDao: appDatabase.topicVersesViewDao,
        queryExtUseCase: context.read())
    ),
  ];
}