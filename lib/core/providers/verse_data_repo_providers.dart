

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/data/repo/downloaded_audio_view_repo_impl.dart';
import 'package:hadith/core/features/manage_downloaded_audio/domain/repo/downloaded_audio_view_repo.dart';
import 'package:hadith/core/features/verse_audio/data/repo/verse_audio_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/data/repo/verse_downloaded_voice_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/data/repo/verse_meal_voice_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_audio_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_downloaded_voice_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_meal_voice_repo.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/core/features/verses/data/repo/cuz_repo_impl.dart';
import 'package:hadith/core/features/verses/domain/repo/cuz_repo.dart';
import 'package:hadith/core/features/verses/data/repo/select_verse_page_repo_impl.dart';
import 'package:hadith/core/features/verses/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/core/features/verses/data/repo/surah_repo_impl.dart';
import 'package:hadith/core/features/verses/domain/repo/surah_repo.dart';


List<RepositoryProvider> pVerseDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<CuzRepo>(create: (context) => CuzRepoImpl(cuzDao: appDatabase.cuzDao)),
    RepositoryProvider<SurahRepo>(create: (context) => SurahRepoImpl(surahDao: appDatabase.surahDao,
        queryExtUseCase: context.read())),

    RepositoryProvider<VerseAudioRepo>(create: (context) => VerseAudioRepoImpl(
      fileService: context.read(),
      verseAudioDao: appDatabase.verseAudioDao,
      audioFileEditor: context.read()
    )),

    RepositoryProvider<VerseMealVoiceRepo>(create: (context) => VerseMealVoiceRepoImpl(
      verseAudioDao: appDatabase.verseAudioDao,
      cuzDao: appDatabase.cuzDao,
      getVerses: context.read(),
      verseDao: appDatabase.verseDao,
      editionDao: appDatabase.editionDao
    )),

    RepositoryProvider<VerseDownloadedVoiceRepo>(create: (context) => VerseDownloadedVoiceRepoImpl(
        getVerses: context.read(),
        verseDao: appDatabase.verseDao,
        verseArabicDao: appDatabase.verseArabicDao
    )),

    RepositoryProvider<DownloadedAudioViewRepo>(create: (context)=>DownloadedAudioViewRepoImpl(
      audioViewDao: appDatabase.audioViewDao,
      verseAudioDao: appDatabase.verseAudioDao,
      fileService: context.read()
    )),

    RepositoryProvider<SelectVersePageRepo>(create: (context) =>
        SelectVersePageRepoImpl(selectVersePageDao: appDatabase.selectVersePageDao))

  ];
}