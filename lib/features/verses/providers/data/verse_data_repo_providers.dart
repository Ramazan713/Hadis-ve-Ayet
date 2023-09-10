

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/data/local/verse_audio_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/data/local/verse_downloaded_voice_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/data/local/verse_meal_voice_repo_impl.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_audio_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_downloaded_voice_repo.dart';
import 'package:hadith/core/features/verse_audio/domain/repo/verse_meal_voice_repo.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/verses/cuz/data/repo/cuz_repo_impl.dart';
import 'package:hadith/features/verses/cuz/domain/repo/cuz_repo.dart';
import 'package:hadith/core/data/repo/downloaded_audio_view_repo_impl.dart';
import 'package:hadith/core/domain/repo/downloaded_audio_view_repo.dart';
import 'package:hadith/features/verses/surah/data/repo/surah_repo_impl.dart';
import 'package:hadith/features/verses/surah/domain/repo/surah_repo.dart';


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
    ))

  ];
}