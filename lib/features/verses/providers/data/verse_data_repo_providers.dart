

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/verses/cuz/data/repo/cuz_repo_impl.dart';
import 'package:hadith/features/verses/cuz/domain/repo/cuz_repo.dart';
import 'package:hadith/core/data/repo/verse/verse_arabic_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/verse_repo_impl.dart';
import 'package:hadith/core/domain/repo/verse/verse_arabic_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/features/verses/surah/data/repo/surah_repo_impl.dart';
import 'package:hadith/features/verses/surah/domain/repo/surah_repo.dart';


List<RepositoryProvider> pVerseDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<CuzRepo>(create: (context) => CuzRepoImpl(cuzDao: appDatabase.cuzDao)),
    RepositoryProvider<SurahRepo>(create: (context) => SurahRepoImpl(surahDao: appDatabase.surahDao,
        queryExtUseCase: context.read())),
  ];
}