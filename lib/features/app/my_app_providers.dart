
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/preferences/app_preferences_impl.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hadith/core/features/backup/presentation/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/presentation/backup_meta/bloc/backup_meta_bloc.dart';
import 'package:hadith/core/features/get_title/presentation/bloc/get_title_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/premium/presentation/bloc/premium_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/bloc/edit_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/select_list/presentation/bloc/select_list_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/verse_audio/data/notification/verse_download_audio_notification_impl.dart';
import 'package:hadith/core/features/verse_audio/data/notification/verse_listen_audio_notification.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/providers/core_data_manager_providers.dart';
import 'package:hadith/core/providers/core_data_repo_providers.dart';
import 'package:hadith/core/providers/core_data_service_providers.dart';
import 'package:hadith/core/providers/core_domain_first_provider.dart';
import 'package:hadith/core/providers/core_domain_repo_provider.dart';
import 'package:hadith/core/providers/core_domain_usecase_provider.dart';
import 'package:hadith/core/features/audio_setting/bloc/audio_setting_bloc.dart';
import 'package:hadith/core/features/save_point/show_save_point/bloc/show_save_point_bloc.dart';
import 'package:hadith/core/features/select_font_size/bloc/select_font_size_bloc.dart';
import 'package:hadith/features/dhikr_prayers/shared/presentation/select_dhikr/bloc/select_dhikr_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/counter_detail_setting/bloc/counter_setting_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/bloc/manage_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_list/bloc/prayer_and_verse_list_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/create_quran_prayer/bloc/create_quran_prayer_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_detail/bloc/custom_prayer_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_manage/bloc/custom_prayer_manage_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/bloc/prayer_in_quran_bloc.dart';
import 'package:hadith/features/dhikr_prayers/providers/dhikr_prayers_data_repo_providers.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/providers/esmaul_husna_data_repo_providers.dart';
import 'package:hadith/features/islamic_info/providers/islamic_info_data_repo_providers.dart';
import 'package:hadith/features/islamic_info/shared/presentation/bloc/islamic_info_shared_bloc.dart';
import 'package:hadith/features/lists/presentation/archive_list/bloc/archive_list_bloc.dart';
import 'package:hadith/features/lists/presentation/savepoint_list_navigator/bloc/savepoint_list_navigator_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/features/search/data/providers/search_data_repo_provider.dart';
import 'package:hadith/features/search/presentation/bloc/search_bloc.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings/providers/settings_data_repo_provider.dart';
import 'package:hadith/features/topics/data/providers/topic_data_repo_provider.dart';
import 'package:hadith/features/topics/presentation/section_page/bloc/section_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/verses/cuz/presentation/bloc/cuz_bloc.dart';
import 'package:hadith/core/providers/verse_data_manager_providers.dart';
import 'package:hadith/features/verses/providers/verse_data_paging_providers.dart';
import 'package:hadith/core/providers/verse_data_repo_providers.dart';
import 'package:hadith/core/providers/verse_data_service_providers.dart';
import 'package:hadith/core/providers/verse_domain_use_case_providers.dart';
import 'package:hadith/core/features/select_edition/bloc/select_edition_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/select_verse_page/bloc/select_verse_page_bloc.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_bloc.dart';
import 'package:hadith/features/verses/surah/presentation/bloc/surah_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../hadiths/data/providers/hadith_data_repo_providers.dart';
import '../hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';

class MyAppProviders extends StatelessWidget {

  final Widget child;
  final AppDatabase appDatabase;
  final SharedPreferences sharedPreferences;

  const MyAppProviders({
    Key? key,
    required this.appDatabase,
    required this.sharedPreferences,
    required this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppPreferences>(create: (context) =>
            AppPreferencesImpl(preferences: sharedPreferences)
        ),
        ...pCoreDomainFirstProviders(appDatabase),
        ...pCoreDataServiceProviders(appDatabase),
        ...pCoreDomainUseCaseForReposProviders(appDatabase),
        ...pCoreDataRepoProviders(appDatabase),
        ...pCoreDomainRepoProviders(appDatabase),
        ...pCoreDomainUseCaseProviders(appDatabase),
        ...pCoreDataManagerRepoProviders(appDatabase),
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> ThemeBloc(appPreferences: context.read()),lazy: false,),
          BlocProvider(create: (context)=> PremiumBloc(premiumRepo: context.read()),lazy: false,),
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
          BlocProvider(create: (context)=> CreateQuranPrayerBloc(
              prayerCustomByQuranRepo: context.read(),
              selectVerseManager: context.read()
          )),
          BlocProvider(create: (context)=> SavePointListNavigatorBloc(
              listRepo: context.read()
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
          BlocProvider(create: (context)=> SelectDhikrCounterBloc(
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
          BlocProvider(create: (context)=> SelectVersePageBloc(
              selectVersePageRepo: context.read(),
              selectVerseManager: context.read()
          )),
          BlocProvider(create: (context)=> ShowEsmaulHusnaBloc(
              appPreferences: context.read(),
              fontModelUseCase: context.read(),
              esmaulHusnaRepo: context.read()
          )),
          BlocProvider(create: (context)=> PrayerAndVerseDetailBloc(
            prayerRepo: context.read(),
            appPreferences: context.read(),
            fontModelUseCase: context.read(),
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
              verseAudioRepo: context.read(),
              editionRepo: context.read(),
              connectivityService: context.read()
          )),
          BlocProvider(create: (context)=> LoadSavePointBloc(
            savePointRepo: context.read(),
            itemPositionRepo: context.read(),
            surahRepo: context.read()
          )),
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
          BlocProvider(create: (context)=> HadithSharedBloc(
              selectListUseCases: context.read(),
              titleRepo: context.read(),
              appPreferences: context.read()
          )),
          BlocProvider(create: (context){
            return ListenVerseAudioBloc(
                audioRepo: context.read(), editionRepo: context.read(),
                appPreferences: context.read(),
                notification: VerseListenAudioNotificationImpl(),
                savePointUseCases: context.read()
            );
          },lazy: false,),
          BlocProvider(create: (context){
            return DownloadAudioBloc(
                connectivityService: context.read(),
                appPreferences: context.read(),
                audioRepo: context.read(),
                editionRepo: context.read(),
                notification: VerseDownloadAudioNotificationImpl()
            );
          }),
        ],
        child: child,
      ),
    );
  }
}
