


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_list_paging_repo.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_repo_impl.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_topic_paging_repo.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_repo.dart';

import '../repo/hadith_all_paging_repo.dart';

List<RepositoryProvider> pHadithDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<HadithRepo>(create: (context) => HadithRepoImpl(hadithAllDao: appDatabase.hadithAllDao)),

    RepositoryProvider<HadithAllPagingRepo>(create: (context)=> HadithAllPagingRepo(
        hadithRepo: context.read(), itemListInfoRepo: context.read(),topicRepo: context.read())),

    RepositoryProvider<HadithListPagingRepo>(create: (context)=> HadithListPagingRepo(
        hadithRepo: context.read(), itemListInfoRepo: context.read(),topicRepo: context.read())),

    RepositoryProvider<HadithTopicPagingRepo>(create: (context)=> HadithTopicPagingRepo(
        hadithRepo: context.read(), itemListInfoRepo: context.read(),topicRepo: context.read())),
  ];
}