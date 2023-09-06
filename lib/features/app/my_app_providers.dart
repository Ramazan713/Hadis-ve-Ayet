
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/auth/bloc/auth_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/backup_meta/bloc/backup_meta_bloc.dart';
import 'package:hadith/core/providers/core_data_repo_providers.dart';
import 'package:hadith/core/providers/core_data_service_providers.dart';
import 'package:hadith/core/providers/core_domain_first_provider.dart';
import 'package:hadith/core/providers/core_domain_repo_provider.dart';
import 'package:hadith/core/providers/core_domain_usecase_provider.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_bloc.dart';
import 'package:hadith/core/features/get_title/bloc/get_title_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/save_point/edit_save_point/bloc/edit_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/show_save_point/bloc/show_save_point_bloc.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_bloc.dart';
import 'package:hadith/core/features/select_list/bloc/select_list_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/db/repos/verse_audio_editor_repo.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/features/app/bloc/bottom_nav_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_ready_counter/bloc/add_ready_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/counter_detail_setting/bloc/counter_setting_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_list/bloc/prayer_and_verse_list_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/bloc/custom_prayer_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_manage/bloc/custom_prayer_manage_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/bloc/prayer_in_quran_bloc.dart';
import 'package:hadith/features/dhikr_prayers/providers/dhikr_prayers_data_repo_providers.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/providers/esmaul_husna_data_repo_providers.dart';
import 'package:hadith/features/esmaul_husna/show_esmaul_husna_list/presentation/bloc/show_esmaul_husna_bloc.dart';
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
import 'package:hadith/features/islamic_info/providers/islamic_info_data_repo_providers.dart';
import 'package:hadith/features/islamic_info/shared/presentation/bloc/islamic_info_shared_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_archive_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_hadith_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_verse_bloc.dart';
import 'package:hadith/features/lists/presentation/archive_list/bloc/archive_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/bloc/visibility_bloc/visibility_bloc.dart';
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
import 'package:hadith/features/search/data/providers/search_data_repo_provider.dart';
import 'package:hadith/features/search/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_bloc.dart';
import 'package:hadith/features/backup/backup_manager.dart';
import 'package:hadith/features/settings/bloc/setting_bloc.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings_/providers/settings_data_repo_provider.dart';
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
import 'package:hadith/features/verses/providers/data/verse_data_manager_providers.dart';
import 'package:hadith/features/verses/providers/data/verse_data_paging_providers.dart';
import 'package:hadith/features/verses/providers/data/verse_data_repo_providers.dart';
import 'package:hadith/features/verses/providers/data/verse_data_service_providers.dart';
import 'package:hadith/features/verses/providers/data/verse_domain_use_case_providers.dart';
import 'package:hadith/features/verses/shared/data/notification/verse_download_audio_notification_impl.dart';
import 'package:hadith/features/verses/shared/data/notification/verse_listen_audio_notification.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_bloc.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_bloc.dart';
import 'package:hadith/features/verses/surah/presentation/bloc/surah_bloc.dart';
import 'package:hadith/services/auth_service.dart';
import 'package:hadith/services/storage_service.dart';
import 'package:hadith/themes/bloc/theme_bloc.dart';
import 'package:hadith/utils/localstorage.dart';
import '../../core/providers/core_data_manager_providers.dart';
import '../../db/repos/audio_edition_repo.dart';
import '../../db/repos/verse_arabic_repo.dart';
import '../../db/repos/verse_audio_state_repo.dart';
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
import '../settings/audio_setting/bloc/audio_setting_bloc.dart';
import '../verse/common_services/file_audio_editor.dart';
import '../save_point/bloc/save_point_edit_bloc.dart';
import '../verse/verse_download_audio/services/quran_download_service.dart';
import '../verse/verse_listen_audio/services/i_verse_audio_service.dart';

class MyAppProviders extends StatelessWidget {

  final Widget child;
  final AppDatabase appDatabase;

  const MyAppProviders({
    Key? key,
    required this.appDatabase,
    required this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        ...pCoreDomainFirstProviders(appDatabase),
        ...pCoreDataServiceProviders(appDatabase),
        ...pCoreDataRepoProviders(appDatabase),
        ...pCoreDomainRepoProviders(appDatabase),
        ...pCoreDomainUseCaseProviders(appDatabase),
        ...pHadithDataRepoProviders(appDatabase),
        ...pTopicDataRepoProviders(appDatabase),
        ...pVerseDataServiceProviders(appDatabase),
        ...pVerseDataRepoProviders(appDatabase),
        ...pVerseDataPagingProviders(appDatabase),
        ...pVerseDataManagerProviders(context,appDatabase),
        ...pVerseDomainUseCaseProviders(context),
        ...pDhikrAndPrayersDataRepoProviders(appDatabase),
        ...pEsmaulHusnaDataRepoProviders(appDatabase),
        ...pSearchDataRepoProviders(appDatabase),
        ...pIslamicInfoDataRepoProviders(appDatabase),
        ...pSettingsDataRepoProviders(appDatabase),
        RepositoryProvider<QuranPrayerRepoOld>(create: (context)=>QuranPrayerRepoImpl(quranPrayerDao: appDatabase.quranPrayerDao)),
        RepositoryProvider<IslamicInfoRepoOld>(create: (context)=>IslamicInfoRepoImpl(infoDao: appDatabase.islamicInfoDaoOld)),
        RepositoryProvider<PrayerRepo>(create: (context)=>PrayerRepoImpl(prayerDao: appDatabase.prayerDaoOld)),
        RepositoryProvider<EsmaulHusnaRepo>(create: (context)=>EsmaulHusnaRepoImpl(esmaulHusnaDao: appDatabase.esmaulHusnaDaoOld)),
        RepositoryProvider<CounterRepoOld>(create: (context)=>CounterRepoImpl(counterDao: appDatabase.counterDaoOld)),
        RepositoryProvider(create: (context)=>InsertCounterUseCase(counterRepo: context.read<CounterRepoOld>())),
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
                UserInfoRepoOld(userInfoDao: appDatabase.userInfoDaoOld)),
        RepositoryProvider(
            create: (context) =>
                VerseAudioStateRepo(audioStateDao: appDatabase.verseAudioStateDao)),
        RepositoryProvider(
            create: (context) => LocalBackupRepoOld(backupDao: appDatabase.backupDaoOld)),
        RepositoryProvider(
            create: (context) =>
                BackupMetaRepoOld(backupMetaDao: appDatabase.backupMetaDaoOld)),
        RepositoryProvider(create: (context)=> VerseArabicRepo(verseArabicDao: appDatabase.verseArabicDaoOld)),
        RepositoryProvider(
            create: (context) =>
                TopicSavePointRepo(savePointDao: appDatabase.topicSavePointDaoOld)),
        RepositoryProvider(create: (context)=>VerseAudioEditorRepo(audioDao: appDatabase.verseAudioDaoOld,fileAudioEditor: FileAudioEditor())),
        RepositoryProvider(create: (context) => VerseAudioRepo(verseAudioDao: appDatabase.verseAudioDaoOld)),
        RepositoryProvider(
            create: (context) =>
                QuranDownloadService(audioRepo: context.read<VerseAudioRepo>())),
        RepositoryProvider(create: (context) => AudioEditionRepoOld(editionDao: appDatabase.editionDaoOld,downloadService: context.read<QuranDownloadService>())),
        RepositoryProvider(create: (context)=>StorageServiceOld()),
        RepositoryProvider(create: (context)=>AuthServiceOld()),
        RepositoryProvider(create: (context)=>BackupManager(authService: context.read<AuthServiceOld>(),
          storageService: context.read<StorageServiceOld>(),backupMetaRepo: context.read<BackupMetaRepoOld>(),
          localBackupRepo: context.read<LocalBackupRepoOld>(),userInfoRepo: context.read<UserInfoRepoOld>())),
        // RepositoryProvider(create: (context) => ManageAudioRepo(verseAudioDao: appDatabase.verseAudioDaoOld,cuzDao: appDatabase.cuzDaoOld,
        //   surahDao: appDatabase.surahDaoOld,fileService: FileService(),manageAudioDao: appDatabase.manageAudioDao)),
        RepositoryProvider<IVerseAudioService>(create: (context) => VerseAudioJustService(
            verseAudioRepo: context.read<VerseAudioRepo>(),verseAudioStateRepo: context.read<VerseAudioStateRepo>(),sharedPreferences: LocalStorage.sharedPreferences)),
        ...pCoreDataManagerRepoProviders(appDatabase),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> BackupBloc(
            authService: context.read(),
            connectivityService: context.read(),
            backupManager: context.read()
          )),
          BlocProvider(create: (context)=> AuthBloc(
              authService: context.read(),
              connectivityService: context.read(),
              backupManager: context.read(),
            appPreferences: context.read()
          )),
          BlocProvider(create: (context)=> BackupMetaBloc(
              authService: context.read(),
              connectivityService: context.read(),
              backupManager: context.read(),
              appPreferences: context.read(),
            backupMetaRepo: context.read()
          )),
          BlocProvider(create: (context)=> PrayerAndVerseListBloc(
            prayerRepo: context.read()
          )),
          BlocProvider(create: (context)=> ShowCustomPrayersBloc(
              prayerRepo: context.read(),
            appPreferences:  context.read()
          )),
          BlocProvider(create: (context)=> CustomPrayerManageBloc(
              prayerRepo: context.read(),
          )),
          BlocProvider(create: (context)=> CustomPrayerDetailBloc(
            prayerRepo: context.read(),
              appPreferences:  context.read(),
            fontModelUseCase: context.read()
          )),
          BlocProvider(create: (context)=> IslamicInfoSharedBloc(
              islamicInfoRepo: context.read(),
              fontModelUseCase: context.read(),
              appPreferences: context.read()
          )),
          BlocProvider(create: (context)=> SettingsBloc(
              userInfoRepo: context.read(),
              fontModelUseCase: context.read(),
              appPreferences: context.read(),
              authService: context.read()
          )),
          BlocProvider(create: (context)=> GetTitleBloc(
              titleRepo: context.read()
          )),
          BlocProvider(create: (context)=> AddReadyCounterBloc(
              counterRepo: context.read(),
              prayerRepo: context.read(),
              appPreferences:  context.read()
          )),
          BlocProvider(create: (context)=> DetailCounterBloc(
              fontModelUseCase: context.read(),
              appPreferences: context.read(),
              counterRepo: context.read()
          )),
          BlocProvider(create: (context)=> CounterSettingBloc(
              appPreferences: context.read(),
          )),
          BlocProvider(create: (context)=> CounterShowBloc(
              counterRepo: context.read(),
              appPreferences: context.read(),
              prayerDao: appDatabase.prayerDao
          )),
          BlocProvider(create: (context)=> ManageCounterBloc(
              counterRepo: context.read()
          )),
          BlocProvider(create: (context)=> ShowEsmaulHusnaBloc(
              appPreferences: context.read(),
              fontModelUseCase: context.read(),
              esmaulHusnaRepo: context.read()
          )),
          BlocProvider(create: (context)=> DetailEsmaulHusnaBloc(
              appPreferences: context.read(),
              fontModelUseCase: context.read(),
              esmaulHusnaRepo: context.read()
          )),
          BlocProvider(create: (context)=> PrayerAndVerseDetailBloc(
            prayerRepo: context.read(),
            appPreferences: context.read(),
            fontModelUseCase: context.read(),
            prayerCustomRepo: context.read(),
          )),
          BlocProvider(create: (context)=> PrayerInQuranBloc(
            prayerRepo: context.read(),
            appPreferences: context.read(),
            fontModelUseCase: context.read(),
          )),
          BlocProvider(create: (context)=> PaginationBloc()),
          BlocProvider(create: (context)=> AudioSettingBloc(
              editionRepo: context.read(),
              appPreferences: context.read(),
          )),
          BlocProvider(create: (context)=> ManageAudioBloc(
            audioViewRepo: context.read()
          )),
          BlocProvider(create: (context) => SelectEditionBloc(
            appPreferences: context.read(),
            editionRepo: context.read(),
          )),
          BlocProvider(create: (context)=> BasicAudioBloc(
              verseAudioService: context.read(),
              downloadManager: context.read(),
              appPreferences: context.read(),
              verseAudioRepo: context.read()
          )),
          BlocProvider(create: (context)=> LoadSavePointBloc(savePointRepo: context.read())),
          BlocProvider(create: (context) => SearchBloc(searchRepo: context.read(), historyRepo: context.read(),
            appPreferences: context.read())),
          BlocProvider(create: (context)=> VerseSharedBloc(appPreferences: context.read(),
              selectListUseCases: context.read(), titleRepo: context.read(),
              fontModelUseCase: context.read(),
          )),
          BlocProvider(create: (context)=> SelectFontSizeBloc(appPreferences: context.read())),
          BlocProvider(create: (context)=> SurahBloc(
              surahRepo: context.read(),
              getItemsUseCases: context.read()
          )),
          BlocProvider(create: (context)=> CuzBloc(
              cuzRepo: context.read(),
              getItemsUseCases: context.read()
          )),
          BlocProvider(create: (context)=> TopicSavePointBloc(topicSavePointUseCases: context.read())),
          BlocProvider(create: (context)=> ArchiveListBloc(listUseCases: context.read())),
          BlocProvider(create: (context)=> SelectListBloc(
              selectListUseCases: context.read(),
              listUseCases: context.read(),
              appPreferences: context.read(),
          )),
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
          BlocProvider(create: (context)=>AddCounterBlocOld(counterRepo: context.read(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>DetailIslamicInfoBloc(infoRepo: context.read())),
          BlocProvider(create: (context)=>CounterDetailBloc(counterRepo: context.read(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>DetailEsmaulHusnaBlocOld(esmaulHusnaRepo: context.read(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>ShowEsmaulHusnaBlocOld(esmaulHusnaRepo: context.read<EsmaulHusnaRepo>())),
          BlocProvider(create: (context)=>CounterSettingBlocOld()),
          BlocProvider(create: (context)=>ManageCounterBlocOld(counterRepo: context.read<CounterRepoOld>(),insertCounterUseCase: context.read())),
          BlocProvider(create: (context)=>CounterShowBlocOld(counterRepo: context.read<CounterRepoOld>())),
          BlocProvider(create: (context)=>AudioSettingBlocOld(editionRepo: context.read<AudioEditionRepoOld>())),
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
          BlocProvider(create: (context){
            return ListenVerseAudioBloc(
                audioRepo: context.read(), editionRepo: context.read(),
                appPreferences: context.read(),
                notification: VerseListenAudioNotificationImpl(),
                savePointUseCases: context.read()
            );
          }),
          BlocProvider(create: (context){
            return DownloadAudioBloc(
                connectivityService: context.read(),
                appPreferences: context.read(),
                audioRepo: context.read(),
                editionRepo: context.read(),
                notification: VerseDownloadAudioNotificationImpl()
            );
          }),
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
          BlocProvider(create: (context)=>BasicAudioBlocOld(audioService: context.read<IVerseAudioService>(),
              downloadService: context.read<QuranDownloadService>(), audioRepo: context.read<VerseAudioRepo>())),
          BlocProvider(create: (context)=>DownloadAudioBlocOld()),
          BlocProvider(create: (context)=>AuthBlocOld(authService: context.read<AuthServiceOld>(),backupManager: context.read<BackupManager>())),
          BlocProvider(create: (context)=>SettingBloc(userInfoRepo: context.read<UserInfoRepoOld>())),
          BlocProvider(create: (context)=>EditionBloc(editionRepo: context.read<AudioEditionRepoOld>())),
          BlocProvider(create: (context)=>BackupMetaBlocOld(backupMetaRepo: context.read<BackupMetaRepoOld>(),authService: context.read<AuthServiceOld>(),
            backupManager: context.read<BackupManager>())),
          // BlocProvider(create: (context)=>TopicSavePointBloc(savePointRepo: context.read<TopicSavePointRepo>())),
          BlocProvider(create: (context)=>ManageAudioBlocOld(manageAudioRepo: context.read<ManageAudioRepo>())),
          BlocProvider(create: (context)=>VerseAudioBloc(audioRepo: context.read<VerseAudioRepo>(),
              editionRepo: context.read<AudioEditionRepoOld>(), audioEditorRepo: context.read<VerseAudioEditorRepo>()))
        ],
        child: child,
      ),
    );
  }
}
