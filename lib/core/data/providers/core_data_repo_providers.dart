

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/repo/item_list_info_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_hadith_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_verse_repo_impl.dart';
import 'package:hadith/core/data/repo/topic_repo_impl.dart';
import 'package:hadith/core/domain/repo/item_list_info_repo.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/core/domain/repo/topic_repo.dart';
import 'package:hadith/db/database.dart';

import '../../domain/repo/list/list_verse_repo.dart';
import '../../domain/repo/list/list_verse_view_repo.dart';
import '../repo/list/list_hadith_view_repo_impl.dart';
import '../repo/list/list_repo_impl.dart';
import '../repo/list/list_verse_view_repo_impl.dart';
import '../repo/save_point_repo_impl.dart';

List<RepositoryProvider> pCoreDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<ListRepo>(create: (context) => ListRepoImpl(listDao: appDatabase.listDao)),
    RepositoryProvider<ListHadithRepo>(create: (context) => ListHadithRepoImpl(listHadithDao: appDatabase.listHadithDao),),
    RepositoryProvider<ListVerseRepo>(create: (context) => ListVerseRepoImpl(listVerseDao: appDatabase.listVerseDao),),
    RepositoryProvider<SavePointRepo>(create: (context) => SavePointRepoImpl(savePointDao: appDatabase.savePointDao),),
    RepositoryProvider<ListHadithViewRepo>(create: (context) => ListHadithViewRepoImpl(listHadithViewDao: appDatabase.listHadithViewDao),),
    RepositoryProvider<ListVerseViewRepo>(create: (context) => ListVerseViewRepoImpl(listVerseViewDao: appDatabase.listVerseViewDao),),
    RepositoryProvider<ItemListInfoRepo>(create: (context) => ItemListInfoRepoImpl(hadithInfoListDao: appDatabase.hadithInfoListDao,
        verseInfoListDao: appDatabase.verseInfoListDao),),
    RepositoryProvider<TopicRepo>(create: (context) => TopicRepoImpl(topicDao: appDatabase.topicDao)),
  ];
}