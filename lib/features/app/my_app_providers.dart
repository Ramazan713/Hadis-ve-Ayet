
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/providers/core_data_repo_providers.dart';
import 'package:hadith/core/domain/providers/core_domain_first_provider.dart';
import 'package:hadith/core/domain/providers/core_domain_repo_provider.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/save_point/edit_save_point/bloc/edit_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/show_save_point/bloc/show_save_point_bloc.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_bloc.dart';
import 'package:hadith/core/features/select_list/bloc/select_list_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/db/repos/verse_audio_editor_repo.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/features/app/bloc/bottom_nav_bloc.dart';
import 'package:hadith/features/app/my_app.dart';
import 'package:hadith/features/extra_features/counter/data/repo/counter_repo_impl.dart';
import 'package:hadith/features/extra_features/counter/domain/repo/counter_repo.dart';
import 'package:hadith/features/extra_features/counter/domain/use_case/insert_counter_use_case.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail_setting/bloc/counter_setting_bloc.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/show_list_esmaul_husna/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/bloc/detail_islamic_info_bloc.dart';
import 'package:hadith/features/extra_features/prayer_surah/data/repo/prayer_repo_impl.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/repo/prayer_repo.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/detail_prayer/bloc/detail_prayer_bloc.dart';
import 'package:hadith/features/extra_features/prayer_surah/presentation/show_prayer_surah/bloc/show_prayer_bloc.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_all_paging_repo.dart';
import 'package:hadith/features/list/bloc/blocs/list_archive_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_hadith_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_verse_bloc.dart';
import 'package:hadith/features/lists/presentation/archive_list/bloc/archive_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/bloc/visibility_bloc/visibility_bloc.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/db/repos/backup_meta_repo.dart';
import 'package:hadith/db/repos/backup_repo.dart';
import 'package:hadith/db/repos/save_point_repo.dart';
import 'package:hadith/db/repos/topic_savepoint_repo.dart';
import 'package:hadith/db/repos/user_info_repo.dart';
import 'package:hadith/features/add_to_list/bloc/list_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/db/repos/cuz_repo.dart';
import 'package:hadith/db/repos/hadith_repo.dart';
import 'package:hadith/db/repos/list_repo.dart';
import 'package:hadith/db/repos/section_repo.dart';
import 'package:hadith/db/repos/surah_repo.dart';
import 'package:hadith/db/repos/topic_repo.dart';
import 'package:hadith/db/repos/verse_repo.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_bloc.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_bloc.dart';
import 'package:hadith/features/save_point/save_point_edit_book_bloc/save_point_edit_book_bloc.dart';
import 'package:hadith/features/search_/data/providers/search_data_repo_provider.dart';
import 'package:hadith/features/search_/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_bloc.dart';
import 'package:hadith/features/backup/backup_manager.dart';
import 'package:hadith/features/settings/bloc/setting_bloc.dart';
import 'package:hadith/features/topics/data/providers/topic_data_repo_provider.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/verse/edition_bloc/edition_bloc.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_bloc.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_repo.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_bloc.dart';
import 'package:hadith/features/verses/providers/data/verse_data_paging_providers.dart';
import 'package:hadith/features/verses/providers/data/verse_data_repo_providers.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_bloc.dart';
import 'package:hadith/features/verses/surah/presentation/bloc/surah_bloc.dart';
import 'package:hadith/services/auth_service.dart';
import 'package:hadith/services/storage_service.dart';
import 'package:hadith/themes/bloc/theme_bloc.dart';
import 'package:hadith/themes/bloc/theme_state.dart';
import 'package:hadith/themes/dark_theme.dart';
import 'package:hadith/themes/light_theme.dart';
import 'package:hadith/utils/localstorage.dart';
import '../../core/data/providers/core_data_manager_providers.dart';
import '../../db/repos/audio_edition_repo.dart';
import '../../db/repos/verse_arabic_repo.dart';
import '../../db/repos/verse_audio_state_repo.dart';
import 'bottom_navbar.dart';
import '../extra_features/counter/presentation/add_counter/bloc/add_counter_bloc.dart';
import '../extra_features/counter/presentation/manage_counter/bloc/manage_counter_bloc.dart';
import '../extra_features/counter/presentation/show_counters/bloc/counter_show_bloc.dart';
import '../extra_features/esmaul_husna/data/repo/esmaul_husna_repo_impl.dart';
import '../extra_features/esmaul_husna/domain/repo/esmaul_husna_repo.dart';
import '../extra_features/esmaul_husna/presentation/detail_esmaul_husna/bloc/detail_esmaul_husna_bloc.dart';
import '../extra_features/islamic_info/data/repo/islamic_info_repo_impl.dart';
import '../extra_features/islamic_info/domain/repo/islamic_info_repo.dart';
import '../extra_features/quran_prayer/data/repo/quran_prayer_repo_impl.dart';
import '../extra_features/quran_prayer/domain/repo/quran_prayer_repo.dart';
import '../extra_features/quran_prayer/presentation/show_quran_prayer_page/bloc/show_quran_prayer_bloc.dart';
import '../hadiths/data/providers/hadith_data_repo_providers.dart';
import '../hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';
import '../premium/bloc/premium_event.dart';
import '../settings/audio_setting/bloc/audio_setting_bloc.dart';
import '../verse/common_services/file_audio_editor.dart';
import '../verse/common_services/file_service.dart';
// import '../verse/cuz/bloc/cuz_bloc.dart';
// import '../verse/surah/bloc/surah_bloc.dart';
import '../save_point/bloc/save_point_edit_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../verse/verse_download_audio/services/quran_download_service.dart';
import '../verse/verse_listen_audio/services/i_verse_audio_service.dart';

class MyAppProviders extends StatelessWidget {

  const MyAppProviders({Key? key, required this.appDatabase})
      : super(key: key);

  final AppDatabase appDatabase;

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        ...pCoreDomainFirstProviders(appDatabase),
        ...pCoreDataRepoProviders(appDatabase),
        ...pCoreDomainRepoProviders(appDatabase),
        ...pHadithDataRepoProviders(appDatabase),
        ...pTopicDataRepoProviders(appDatabase),
        ...pVerseDataRepoProviders(appDatabase),
        ...pVerseDataPagingProviders(appDatabase),
        ...pSearchDataRepoProviders(appDatabase),
        RepositoryProvider<QuranPrayerRepo>(create: (context)=>QuranPrayerRepoImpl(quranPrayerDao: appDatabase.quranPrayerDao)),
        RepositoryProvider<IslamicInfoRepo>(create: (context)=>IslamicInfoRepoImpl(infoDao: appDatabase.islamicInfoDao)),
        RepositoryProvider<PrayerRepo>(create: (context)=>PrayerRepoImpl(prayerDao: appDatabase.prayerDao)),
        RepositoryProvider<EsmaulHusnaRepo>(create: (context)=>EsmaulHusnaRepoImpl(esmaulHusnaDao: appDatabase.esmaulHusnaDao)),
        RepositoryProvider<CounterRepo>(create: (context)=>CounterRepoImpl(counterDao: appDatabase.counterDao)),
        RepositoryProvider(create: (context)=>InsertCounterUseCase(counterRepo: context.read<CounterRepo>())),
        RepositoryProvider<ListRepoOld>(
            create: (context) => ListRepoOld(listDao: appDatabase.listDaoOld)),
        RepositoryProvider<HadithRepoOld>(
            create: (context) => HadithRepoOld(hadithDao: appDatabase.hadithDao)),
        RepositoryProvider<CuzRepo>(
            create: (context) => CuzRepo(cuzDao: appDatabase.cuzDaoOld)),
        RepositoryProvider<SectionRepo>(
            create: (context) => SectionRepo(sectionDao: appDatabase.sectionDao)),
        RepositoryProvider<SurahRepoOld>(
            create: (context) => SurahRepoOld(surahDao: appDatabase.surahDaoOld)),
        RepositoryProvider<TopicRepo>(
            create: (context) => TopicRepo(topicDao: appDatabase.topicDaoOld)),
        RepositoryProvider<VerseRepoOld>(
            create: (context) => VerseRepoOld(verseDao: appDatabase.verseDaoOld)),
        RepositoryProvider<SavePointRepoOld>(
            create: (context) =>
                SavePointRepoOld(savePointDao:appDatabase.savePointDaoOld)),
        // RepositoryProvider<HistoryRepo>(
        //     create: (context) => HistoryRepo(historyDao: appDatabase.historyDaoOld)),
        RepositoryProvider(
            create: (context) =>
                UserInfoRepo(userInfoDao: appDatabase.userInfoDao)),
        RepositoryProvider(
            create: (context) =>
                VerseAudioStateRepo(audioStateDao: appDatabase.verseAudioStateDao)),
        RepositoryProvider(
            create: (context) => LocalBackupRepo(backupDao: appDatabase.backupDao)),
        RepositoryProvider(
            create: (context) =>
                BackupMetaRepo(backupMetaDao: appDatabase.backupMetaDao)),
        RepositoryProvider(create: (context)=> VerseArabicRepo(verseArabicDao: appDatabase.verseArabicDaoOld)),
        RepositoryProvider(
            create: (context) =>
                TopicSavePointRepo(savePointDao: appDatabase.topicSavePointDaoOld)),
        RepositoryProvider(create: (context)=>VerseAudioEditorRepo(audioDao: appDatabase.verseAudioDao,fileAudioEditor: FileAudioEditor())),
        RepositoryProvider(create: (context) => VerseAudioRepo(verseAudioDao: appDatabase.verseAudioDao)),
        RepositoryProvider(
            create: (context) =>
                QuranDownloadService(audioRepo: context.read<VerseAudioRepo>())),
        RepositoryProvider(create: (context) => AudioEditionRepo(editionDao: appDatabase.editionDao,downloadService: context.read<QuranDownloadService>())),
        RepositoryProvider(create: (context)=>StorageService()),
        RepositoryProvider(create: (context)=>AuthService()),
        RepositoryProvider(create: (context)=>BackupManager(authService: context.read<AuthService>(),
          storageService: context.read<StorageService>(),backupMetaRepo: context.read<BackupMetaRepo>(),
          localBackupRepo: context.read<LocalBackupRepo>(),userInfoRepo: context.read<UserInfoRepo>())),
        RepositoryProvider(create: (context) => ManageAudioRepo(verseAudioDao: appDatabase.verseAudioDao,cuzDao: appDatabase.cuzDaoOld,
          surahDao: appDatabase.surahDaoOld,fileService: FileService(),manageAudioDao: appDatabase.manageAudioDao)),
        RepositoryProvider<IVerseAudioService>(create: (context) => VerseAudioJustService(
            verseAudioRepo: context.read<VerseAudioRepo>(),verseAudioStateRepo: context.read<VerseAudioStateRepo>(),sharedPreferences: LocalStorage.sharedPreferences)),
        ...pCoreDataManagerRepoProviders(appDatabase),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> PaginationBloc()),
          BlocProvider(create: (context) => SearchBloc(searchRepo: context.read(), historyRepo: context.read(),
            appPreferences: context.read())),
          BlocProvider(create: (context)=> VerseSharedBloc(appPreferences: context.read(),
              selectListUseCases: context.read(), titleRepo: context.read())),
          BlocProvider(create: (context)=> SelectFontSizeBloc(appPreferences: context.read())),
          BlocProvider(create: (context)=> SurahBloc(surahRepo: context.read())),
          BlocProvider(create: (context)=> CuzBloc(cuzRepo: context.read())),
          BlocProvider(create: (context)=> TopicSavePointBloc(topicSavePointUseCases: context.read())),
          BlocProvider(create: (context)=> ArchiveListBloc(listUseCases: context.read())),
          BlocProvider(create: (context)=> SelectListBloc(selectListUseCases: context.read(), listUseCases: context.read())),
          BlocProvider(create: (context)=> SectionBloc(sectionViewRepo: context.read())),
          BlocProvider(create: (context)=> TopicBloc(topicViewRepo: context.read())),
          BlocProvider(create: (context)=> ShareBloc(shareManager: context.read(),sharePdfRepo: context.read())),
          BlocProvider(create: (context)=> EditSavePointBloc(savePointUseCases: context.read(),savePointDao: appDatabase.savePointDao)),
          BlocProvider(create: (context)=> ShowSavePointBloc(savePointUseCases: context.read())),
          BlocProvider(create: (context)=> ShowListBloc(listUseCases: context.read())),
          BlocProvider(create: (context)=> HadithSharedBloc(selectListUseCases: context.read(),
              titleRepo: context.read(), appPreferences: context.read())),
          BlocProvider(create: (context)=>ShowQuranPrayerBloc(prayerRepo: context.read())),
          BlocProvider(create: (context)=>ShowPrayerBloc(prayerRepo: context.read())),
          BlocProvider(create: (context)=>DetailPrayerBloc(insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>AddCounterBloc(counterRepo: context.read(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>DetailIslamicInfoBloc(infoRepo: context.read())),
          BlocProvider(create: (context)=>CounterDetailBloc(counterRepo: context.read(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>DetailEsmaulHusnaBloc(esmaulHusnaRepo: context.read(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>ShowEsmaulHusnaBloc(esmaulHusnaRepo: context.read<EsmaulHusnaRepo>())),
          BlocProvider(create: (context)=>CounterSettingBloc()),
          BlocProvider(create: (context)=>ManageCounterBloc(counterRepo: context.read<CounterRepo>(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>CounterShowBloc(counterRepo: context.read<CounterRepo>())),
          BlocProvider(create: (context)=>AudioSettingBloc(editionRepo: context.read<AudioEditionRepo>())),
          // BlocProvider(
          //     create: (context) =>
          //         TopicBloc(topicRepo: context.read<TopicRepo>())),
          // BlocProvider(
          //     create: (context) =>
          //         SectionBloc(topicRepo: context.read<TopicRepo>())),
          BlocProvider(create: (context) => ListBloc()),
          // BlocProvider(
          // //     create: (context) => CuzBloc(cuzRepo: context.read<CuzRepo>())),
          // BlocProvider(
          //     create: (context) =>
          //         SurahBloc(surahRepo: context.read<SurahRepoOld>())),
          BlocProvider(
              create: (context) =>
                  SavePointBloc(savePointRepo: context.read<SavePointRepoOld>())),
          BlocProvider(
              create: (context) => SavePointEditBloc(
                  savePointRepo: context.read<SavePointRepoOld>())),
          BlocProvider(
              create: (context) =>
                  ListHadithBloc(listRepo: context.read<ListRepoOld>(),
                      savePointRepo: context.read<SavePointRepoOld>())),
          // BlocProvider(
          //     create: (context) => SearchBlocOld(
          //         hadithRepo: context.read<HadithRepoOld>(),
          //         verseRepo: context.read<VerseRepoOld>())),
          BlocProvider(
              create: (context) =>
                  ListVerseBloc(listRepo: context.read<ListRepoOld>(),
                      savePointRepo: context.read<SavePointRepoOld>())),
          // BlocProvider(
          //     create: (context) =>
          //         HistoryBloc(historyRepo: context.read<HistoryRepo>())),
          BlocProvider(create: (context) => BottomNavBloc()),
          BlocProvider(create: (context)=>ListArchiveBloc(listRepo: context.read<ListRepoOld>(),savePointRepo: context.read<SavePointRepoOld>())),
          BlocProvider(create: (context)=>ThemeBloc()),
          BlocProvider(create: (context)=>PremiumBloc(), lazy: false,),
          BlocProvider(create: (context)=>VisibilityBloc()),
          BlocProvider(create: (context)=>SavePointEditBookBloc(savePointRepo: context.read<SavePointRepoOld>())),
          BlocProvider(create: (context)=>BasicAudioBloc(audioService: context.read<IVerseAudioService>(),
              downloadService: context.read<QuranDownloadService>(), audioRepo: context.read<VerseAudioRepo>())),
          BlocProvider(create: (context)=>DownloadAudioBloc()),
          BlocProvider(create: (context)=>AuthBloc(authService: context.read<AuthService>(),backupManager: context.read<BackupManager>())),
          BlocProvider(create: (context)=>SettingBloc(userInfoRepo: context.read<UserInfoRepo>())),
          BlocProvider(create: (context)=>EditionBloc(editionRepo: context.read<AudioEditionRepo>())),
          BlocProvider(create: (context)=>BackupMetaBloc(backupMetaRepo: context.read<BackupMetaRepo>(),authService: context.read<AuthService>(),
            backupManager: context.read<BackupManager>())),
          // BlocProvider(create: (context)=>TopicSavePointBloc(savePointRepo: context.read<TopicSavePointRepo>())),
          BlocProvider(create: (context)=>ManageAudioBloc(manageAudioRepo: context.read<ManageAudioRepo>())),
          BlocProvider(create: (context)=>VerseAudioBloc(audioRepo: context.read<VerseAudioRepo>(),
              editionRepo: context.read<AudioEditionRepo>(), audioEditorRepo: context.read<VerseAudioEditorRepo>()))
        ],
        child: const MyApp(),
      ),
    );
  }
}
