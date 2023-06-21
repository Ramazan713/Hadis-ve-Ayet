

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/preferences/app_preferences_impl.dart';
import 'package:hadith/core/data/repo/hadith_repo_impl.dart';
import 'package:hadith/core/data/repo/item_list_info_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_hadith_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_verse_repo_impl.dart';
import 'package:hadith/core/data/repo/search_repo_impl.dart';
import 'package:hadith/core/data/repo/share/share_manager_impl.dart';
import 'package:hadith/core/data/repo/share/share_pdf_repo_impl.dart';
import 'package:hadith/core/data/repo/title_repo_impl.dart';
import 'package:hadith/core/data/repo/topic_repo_impl.dart';
import 'package:hadith/core/data/repo/topic_save_point_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/get_verses.dart';
import 'package:hadith/core/data/repo/verse/verse_arabic_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/verse_repo_impl.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/repo/hadith_repo.dart';
import 'package:hadith/core/domain/repo/item_list_info_repo.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/repo/save_point_repo.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';
import 'package:hadith/core/domain/repo/share/share_manager.dart';
import 'package:hadith/core/domain/repo/share/share_pdf_repo.dart';
import 'package:hadith/core/domain/repo/title_repo.dart';
import 'package:hadith/core/domain/repo/topic_repo.dart';
import 'package:hadith/core/domain/repo/topic_save_point_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_arabic_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/utils/localstorage.dart';

import '../../domain/repo/list/list_verse_repo.dart';
import '../../domain/repo/list/list_verse_view_repo.dart';
import '../repo/list/list_hadith_view_repo_impl.dart';
import '../repo/list/list_repo_impl.dart';
import '../repo/list/list_verse_view_repo_impl.dart';
import '../repo/save_point_repo_impl.dart';

List<RepositoryProvider> pCoreDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<GetVerses>(create: (context) => GetVerses(surahDao: appDatabase.surahDao)),
    RepositoryProvider<AppPreferences>(create: (context) => AppPreferencesImpl(preferences: LocalStorage.sharedPreferences)),
    RepositoryProvider<ListRepo>(create: (context) => ListRepoImpl(listDao: appDatabase.listDao)),
    RepositoryProvider<ListHadithRepo>(create: (context) => ListHadithRepoImpl(listHadithDao: appDatabase.listHadithDao),),
    RepositoryProvider<ListVerseRepo>(create: (context) => ListVerseRepoImpl(listVerseDao: appDatabase.listVerseDao),),
    RepositoryProvider<SavePointRepo>(create: (context) => SavePointRepoImpl(savePointDao: appDatabase.savePointDao),),
    RepositoryProvider<ListHadithViewRepo>(create: (context) =>
        ListHadithViewRepoImpl(listHadithViewDao: appDatabase.listHadithViewDao,queryExtUseCase: context.read())),
    RepositoryProvider<ListVerseViewRepo>(create: (context) =>
        ListVerseViewRepoImpl(listVerseViewDao: appDatabase.listVerseViewDao, queryExtUseCase: context.read()),),
    RepositoryProvider<ItemListInfoRepo>(create: (context) => ItemListInfoRepoImpl(hadithInfoListDao: appDatabase.hadithInfoListDao,
        verseInfoListDao: appDatabase.verseInfoListDao),),
    RepositoryProvider<TopicRepo>(create: (context) => TopicRepoImpl(topicDao: appDatabase.topicDao)),
    RepositoryProvider<SharePdfRepo>(create: (context)=> SharePdfRepoImpl()),
    RepositoryProvider<TopicSavePointRepo>(create: (context)=> TopicSavePointRepoImpl(topicSavePointDao: appDatabase.topicSavePointDao)),
    RepositoryProvider<VerseArabicRepo>(create: (context) => VerseArabicRepoImpl(verseArabicDao: appDatabase.verseArabicDao)),
    RepositoryProvider<VerseRepo>(create: (context) => VerseRepoImpl(
        getVerses: context.read(), verseDao: appDatabase.verseDao
    )),
    RepositoryProvider<SearchRepo>(create: (context) => SearchRepoImpl(
      searchDao: appDatabase.searchDao, getVerses: context.read()
    )),
    RepositoryProvider<HadithRepo>(create: (context) => HadithRepoImpl(hadithAllDao: appDatabase.hadithAllDao)),
    RepositoryProvider<TitleRepo>(create: (context) => TitleRepoImpl(titleDao: appDatabase.titleDao)),
  ];
}