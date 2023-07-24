

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/verses/cuz/data/repo/cuz_repo_impl.dart';
import 'package:hadith/features/verses/cuz/domain/repo/cuz_repo.dart';
import 'package:hadith/core/data/repo/verse/verse_arabic_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/verse_repo_impl.dart';
import 'package:hadith/core/domain/repo/verse/verse_arabic_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/features/verses/shared/data/local/edition_repo_impl.dart';
import 'package:hadith/features/verses/shared/data/local/verse_audio_repo_impl.dart';
import 'package:hadith/features/verses/shared/data/remote/edition_download_service.dart';
import 'package:hadith/features/verses/shared/domain/repo/edition_repo.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_audio_repo.dart';
import 'package:hadith/features/verses/surah/data/repo/surah_repo_impl.dart';
import 'package:hadith/features/verses/surah/domain/repo/surah_repo.dart';


List<RepositoryProvider> pVerseDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<CuzRepo>(create: (context) => CuzRepoImpl(cuzDao: appDatabase.cuzDao)),
    RepositoryProvider<SurahRepo>(create: (context) => SurahRepoImpl(surahDao: appDatabase.surahDao,
        queryExtUseCase: context.read())),

    RepositoryProvider<EditionRepo>(create: (context) => EditionRepoImply(
        editionDao: appDatabase.editionDao,
        downloadService: EditionDownloadService(),
        connectivityService: context.read()
    )),

    RepositoryProvider<VerseAudioRepo>(create: (context) => VerseAudioRepoImpl(
      fileService: context.read(),
      verseAudioDao: appDatabase.verseAudioDao,
      audioFileEditor: context.read()
    )),

  ];
}