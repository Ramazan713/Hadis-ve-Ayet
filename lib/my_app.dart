import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/db/repos/verse_audio_editor_repo.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/features/app/bloc/bottom_nav_bloc.dart';
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
import 'package:hadith/features/hadiths/data/hadith_all_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/bloc/hadith_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_archive_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_hadith_bloc.dart';
import 'package:hadith/features/list/bloc/blocs/list_verse_bloc.dart';
import 'package:hadith/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/bloc/visibility_bloc/visibility_bloc.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/db/repos/backup_meta_repo.dart';
import 'package:hadith/db/repos/backup_repo.dart';
import 'package:hadith/db/repos/history_repo.dart';
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
import 'package:hadith/features/history/bloc/history_bloc.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_bloc.dart';
import 'package:hadith/features/save_point/save_point_edit_book_bloc/save_point_edit_book_bloc.dart';
import 'package:hadith/features/search/bloc/search_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_bloc.dart';
import 'package:hadith/features/backup/backup_manager.dart';
import 'package:hadith/features/settings/bloc/setting_bloc.dart';
import 'package:hadith/features/topic/bloc/section_bloc.dart';
import 'package:hadith/features/topic/bloc/topic_bloc.dart';
import 'package:hadith/features/topic_savepoint/bloc/topic_savepoint_bloc.dart';
import 'package:hadith/features/verse/edition_bloc/edition_bloc.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_bloc.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_repo.dart';
import 'package:hadith/features/verse/verse_download_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/services/auth_service.dart';
import 'package:hadith/services/storage_service.dart';
import 'package:hadith/themes/bloc/theme_bloc.dart';
import 'package:hadith/themes/bloc/theme_state.dart';
import 'package:hadith/themes/dark_theme.dart';
import 'package:hadith/themes/light_theme.dart';
import 'package:hadith/utils/localstorage.dart';
import 'db/repos/audio_edition_repo.dart';
import 'db/repos/verse_arabic_repo.dart';
import 'db/repos/verse_audio_state_repo.dart';
import 'features/app/bottom_navbar.dart';
import 'features/extra_features/counter/presentation/add_counter/bloc/add_counter_bloc.dart';
import 'features/extra_features/counter/presentation/manage_counter/bloc/manage_counter_bloc.dart';
import 'features/extra_features/counter/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'features/extra_features/esmaul_husna/data/repo/esmaul_husna_repo_impl.dart';
import 'features/extra_features/esmaul_husna/domain/repo/esmaul_husna_repo.dart';
import 'features/extra_features/esmaul_husna/presentation/detail_esmaul_husna/bloc/detail_esmaul_husna_bloc.dart';
import 'features/extra_features/islamic_info/data/repo/islamic_info_repo_impl.dart';
import 'features/extra_features/islamic_info/domain/repo/islamic_info_repo.dart';
import 'features/extra_features/quran_prayer/data/repo/quran_prayer_repo_impl.dart';
import 'features/extra_features/quran_prayer/domain/repo/quran_prayer_repo.dart';
import 'features/extra_features/quran_prayer/presentation/show_quran_prayer_page/bloc/show_quran_prayer_bloc.dart';
import 'features/premium/bloc/premium_event.dart';
import 'features/settings/audio_setting/bloc/audio_setting_bloc.dart';
import 'features/verse/common_services/file_audio_editor.dart';
import 'features/verse/common_services/file_service.dart';
import 'features/verse/cuz/bloc/cuz_bloc.dart';
import 'features/verse/surah/bloc/surah_bloc.dart';
import 'features/save_point/bloc/save_point_edit_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'features/verse/verse_download_audio/services/quran_download_service.dart';
import 'features/verse/verse_listen_audio/services/i_verse_audio_service.dart';

class MyApp extends StatelessWidget {

  const MyApp({Key? key, required this.appDatabase})
      : super(key: key);

  final AppDatabase appDatabase;

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<QuranPrayerRepo>(create: (context)=>QuranPrayerRepoImpl(quranPrayerDao: appDatabase.quranPrayerDao)),
        RepositoryProvider<IslamicInfoRepo>(create: (context)=>IslamicInfoRepoImpl(infoDao: appDatabase.islamicInfoDao)),
        RepositoryProvider<PrayerRepo>(create: (context)=>PrayerRepoImpl(prayerDao: appDatabase.prayerDao)),
        RepositoryProvider<EsmaulHusnaRepo>(create: (context)=>EsmaulHusnaRepoImpl(esmaulHusnaDao: appDatabase.esmaulHusnaDao)),
        RepositoryProvider<CounterRepo>(create: (context)=>CounterRepoImpl(counterDao: appDatabase.counterDao)),
        RepositoryProvider(create: (context)=>InsertCounterUseCase(counterRepo: context.read<CounterRepo>())),
        RepositoryProvider<ListRepo>(
            create: (context) => ListRepo(listDao: appDatabase.listDao)),
        RepositoryProvider<HadithRepo>(
            create: (context) => HadithRepo(hadithDao: appDatabase.hadithDao)),
        RepositoryProvider<CuzRepo>(
            create: (context) => CuzRepo(cuzDao: appDatabase.cuzDao)),
        RepositoryProvider<SectionRepo>(
            create: (context) => SectionRepo(sectionDao: appDatabase.sectionDao)),
        RepositoryProvider<SurahRepo>(
            create: (context) => SurahRepo(surahDao: appDatabase.surahDao)),
        RepositoryProvider<TopicRepo>(
            create: (context) => TopicRepo(topicDao: appDatabase.topicDao)),
        RepositoryProvider<VerseRepo>(
            create: (context) => VerseRepo(verseDao: appDatabase.verseDao)),
        RepositoryProvider<SavePointRepo>(
            create: (context) =>
                SavePointRepo(savePointDao:appDatabase.savePointDao)),
        RepositoryProvider<HistoryRepo>(
            create: (context) => HistoryRepo(historyDao: appDatabase.historyDao)),
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
        RepositoryProvider(create: (context)=> VerseArabicRepo(verseArabicDao: appDatabase.verseArabicDao)),
        RepositoryProvider(
            create: (context) =>
                TopicSavePointRepo(savePointDao: appDatabase.topicSavePointDao)),
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
        RepositoryProvider(create: (context) => ManageAudioRepo(verseAudioDao: appDatabase.verseAudioDao,cuzDao: appDatabase.cuzDao,
          surahDao: appDatabase.surahDao,fileService: FileService(),manageAudioDao: appDatabase.manageAudioDao)),
        RepositoryProvider<IVerseAudioService>(create: (context) => VerseAudioJustService(
            verseAudioRepo: context.read<VerseAudioRepo>(),verseAudioStateRepo: context.read<VerseAudioStateRepo>(),sharedPreferences: LocalStorage.sharedPreferences)),

        RepositoryProvider(create: (context)=> HadithAllPagingRepo(hadithAllDao: appDatabase.hadithAllDao,listRepo: context.read(),topicRepo: context.read())),

      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> PaginationBloc()),
          BlocProvider(create: (context)=> HadithBloc(hadithPagingRepo: context.read(),listRepo: context.read() )),
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
          BlocProvider(
              create: (context) =>
                  TopicBloc(topicRepo: context.read<TopicRepo>())),
          BlocProvider(
              create: (context) =>
                  SectionBloc(topicRepo: context.read<TopicRepo>())),
          BlocProvider(create: (context) => ListBloc()),
          BlocProvider(
              create: (context) => CuzBloc(cuzRepo: context.read<CuzRepo>())),
          BlocProvider(
              create: (context) =>
                  SurahBloc(surahRepo: context.read<SurahRepo>())),
          BlocProvider(
              create: (context) =>
                  SavePointBloc(savePointRepo: context.read<SavePointRepo>())),
          BlocProvider(
              create: (context) => SavePointEditBloc(
                  savePointRepo: context.read<SavePointRepo>())),
          BlocProvider(
              create: (context) =>
                  ListHadithBloc(listRepo: context.read<ListRepo>(),
                      savePointRepo: context.read<SavePointRepo>())),
          BlocProvider(
              create: (context) => SearchBloc(
                  hadithRepo: context.read<HadithRepo>(),
                  verseRepo: context.read<VerseRepo>())),
          BlocProvider(
              create: (context) =>
                  ListVerseBloc(listRepo: context.read<ListRepo>(),
                      savePointRepo: context.read<SavePointRepo>())),
          BlocProvider(
              create: (context) =>
                  HistoryBloc(historyRepo: context.read<HistoryRepo>())),
          BlocProvider(create: (context) => BottomNavBloc()),
          BlocProvider(create: (context)=>ListArchiveBloc(listRepo: context.read<ListRepo>(),savePointRepo: context.read<SavePointRepo>())),
          BlocProvider(create: (context)=>ThemeBloc()),
          BlocProvider(create: (context)=>PremiumBloc(), lazy: false,),
          BlocProvider(create: (context)=>VisibilityBloc()),
          BlocProvider(create: (context)=>SavePointEditBookBloc(savePointRepo: context.read<SavePointRepo>())),
          BlocProvider(create: (context)=>BasicAudioBloc(audioService: context.read<IVerseAudioService>(),
              downloadService: context.read<QuranDownloadService>(), audioRepo: context.read<VerseAudioRepo>())),
          BlocProvider(create: (context)=>DownloadAudioBloc()),
          BlocProvider(create: (context)=>AuthBloc(authService: context.read<AuthService>(),backupManager: context.read<BackupManager>())),
          BlocProvider(create: (context)=>SettingBloc(userInfoRepo: context.read<UserInfoRepo>())),
          BlocProvider(create: (context)=>EditionBloc(editionRepo: context.read<AudioEditionRepo>())),
          BlocProvider(create: (context)=>BackupMetaBloc(backupMetaRepo: context.read<BackupMetaRepo>(),authService: context.read<AuthService>(),
            backupManager: context.read<BackupManager>())),
          BlocProvider(create: (context)=>TopicSavePointBloc(savePointRepo: context.read<TopicSavePointRepo>())),
          BlocProvider(create: (context)=>ManageAudioBloc(manageAudioRepo: context.read<ManageAudioRepo>())),
          BlocProvider(create: (context)=>VerseAudioBloc(audioRepo: context.read<VerseAudioRepo>(),
              editionRepo: context.read<AudioEditionRepo>(), audioEditorRepo: context.read<VerseAudioEditorRepo>()))
        ],
        child: BlocBuilder<ThemeBloc,ThemeState>(
          builder: (context,state){
            context.read<PremiumBloc>().add(PremiumEventCheckPurchase());

            return Phoenix(
              child: MaterialApp(
                title: 'Hadis ve Ayet',
                debugShowCheckedModeBanner: false,
                themeMode: state.themeEnum.mode,
                theme: getLightThemeData(),
                darkTheme: getDarkThemeData(),
                home: const BottomNavBar(),
              ),
            );
          },
        ),
      ),
    );
  }
}