


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_list_paging_repo.dart';
import 'package:hadith/core/data/repo/hadith_repo_impl.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_search_paging_repo.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_topic_paging_repo.dart';
import 'package:hadith/core/domain/repo/hadith_repo.dart';

import '../repo/hadith_all_paging_repo.dart';

List<RepositoryProvider> pHadithDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<HadithAllPagingRepo>(create: (context)=> HadithAllPagingRepo(
        hadithRepo: context.read(),
        itemListInfoRepo: context.read(),
        topicRepo: context.read(),
        appPreferences: context.read()
    )),

    RepositoryProvider<HadithListPagingRepo>(create: (context)=> HadithListPagingRepo(
        hadithRepo: context.read(),
        itemListInfoRepo: context.read(),
        topicRepo: context.read(),
        appPreferences: context.read()
    )),

    RepositoryProvider<HadithTopicPagingRepo>(create: (context)=> HadithTopicPagingRepo(
        hadithRepo: context.read(),
        itemListInfoRepo: context.read(),
        topicRepo: context.read(),
        appPreferences: context.read()
    )),

    RepositoryProvider<HadithSearchPagingRepo>(create: (context)=> HadithSearchPagingRepo(
        hadithRepo: context.read(),
        itemListInfoRepo: context.read(),
        topicRepo: context.read(),
        searchRepo: context.read(),
        appPreferences: context.read()
    )),
  ];
}