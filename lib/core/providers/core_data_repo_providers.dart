

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/remote/services/edition_download_service.dart';
import 'package:hadith/core/data/repo/edition_repo_impl.dart';
import 'package:hadith/core/data/repo/hadith_repo_impl.dart';
import 'package:hadith/core/data/repo/item_list_info_repo_impl.dart';
import 'package:hadith/core/data/repo/item_position_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_hadith_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_hadith_view_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_verse_repo_impl.dart';
import 'package:hadith/core/data/repo/list/list_verse_view_repo_impl.dart';
import 'package:hadith/core/data/repo/search_repo_impl.dart';
import 'package:hadith/core/data/repo/topic_repo_impl.dart';
import 'package:hadith/core/data/repo/user_info_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/get_verses.dart';
import 'package:hadith/core/data/repo/verse/verse_arabic_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/verse_repo_impl.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/core/domain/repo/hadith_repo.dart';
import 'package:hadith/core/domain/repo/item_list_info_repo.dart';
import 'package:hadith/core/domain/repo/item_position_repo.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_view_repo.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';
import 'package:hadith/core/domain/repo/topic_repo.dart';
import 'package:hadith/core/domain/repo/user_info_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_arabic_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/core/features/backup/data/repo/backup_meta_repo_impl.dart';
import 'package:hadith/core/features/backup/data/repo/local_backup_repo_impl.dart';
import 'package:hadith/core/features/backup/domain/repo/backup_meta_repo.dart';
import 'package:hadith/core/features/backup/domain/repo/local_backup_repo.dart';
import 'package:hadith/core/features/get_title/data/repo/title_repo_impl.dart';
import 'package:hadith/core/features/get_title/domain/repo/title_repo.dart';
import 'package:hadith/core/features/premium/data/repo/premium_repo_impl.dart';
import 'package:hadith/core/features/premium/domain/repo/premium_repo.dart';
import 'package:hadith/core/features/save_point/data/repo/save_point_repo_impl.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';
import 'package:hadith/core/features/share/data/repo/share_pdf_repo_impl.dart';
import 'package:hadith/core/features/share/domain/repo/share_pdf_repo.dart';
import 'package:hadith/core/features/topic_save_point/data/repo/topic_save_point_repo_impl.dart';
import 'package:hadith/core/features/topic_save_point/domain/repo/topic_save_point_repo.dart';

List<RepositoryProvider> pCoreDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<GetVerses>(create: (context) => GetVerses(surahDao: appDatabase.surahDao)),
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

    RepositoryProvider<EditionRepo>(create: (context) => EditionRepoImply(
        editionDao: appDatabase.editionDao,
        downloadService: EditionDownloadService(),
        connectivityService: context.read()
    )),
    RepositoryProvider<BackupMetaRepo>(create: (context) => BackupMetaRepoImpl(
      backupMetaDao: appDatabase.backupMetaDao
    )),
    RepositoryProvider<LocalBackupRepo>(create: (context) => LocalBackupRepoImpl(
        backupDao: appDatabase.backupDao,
        appPreferences: context.read()
    )),
    RepositoryProvider<PremiumRepo>(create: (context) => PremiumRepoImpl(
      premiumProductDetailUseCase: context.read()
    )),
    RepositoryProvider<ItemPositionRepo>(create: (context) => ItemPositionRepoImpl(
        itemPositionDao: appDatabase.itemPositionDao
    )),
    RepositoryProvider<UserInfoRepo>(create: (context)=> UserInfoRepoImpl(
        userInfoDao: appDatabase.userInfoDao
    )),
  ];
}