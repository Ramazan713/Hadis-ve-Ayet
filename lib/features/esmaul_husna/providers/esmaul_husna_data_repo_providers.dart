

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/repo/prayer_repo_impl.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';
import 'package:hadith/features/esmaul_husna/shared/data/repo/esmaul_husna_repo_impl.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/repo/esmaul_husna_repo.dart';
import 'package:hadith/features/verses/cuz/data/repo/cuz_repo_impl.dart';
import 'package:hadith/features/verses/cuz/domain/repo/cuz_repo.dart';
import 'package:hadith/core/data/repo/verse/verse_arabic_repo_impl.dart';
import 'package:hadith/core/data/repo/verse/verse_repo_impl.dart';
import 'package:hadith/core/domain/repo/verse/verse_arabic_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/core/data/repo/downloaded_audio_view_repo_impl.dart';
import 'package:hadith/core/data/repo/edition_repo_impl.dart';
import 'package:hadith/features/verses/shared/data/local/verse_audio_repo_impl.dart';
import 'package:hadith/features/verses/shared/data/local/verse_downloaded_voice_repo_impl.dart';
import 'package:hadith/features/verses/shared/data/local/verse_meal_voice_repo_impl.dart';
import 'package:hadith/core/data/remote/edition_download_service.dart';
import 'package:hadith/core/domain/repo/downloaded_audio_view_repo.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_audio_repo.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_downloaded_voice_repo.dart';
import 'package:hadith/features/verses/shared/domain/repo/verse_meal_voice_repo.dart';
import 'package:hadith/features/verses/surah/data/repo/surah_repo_impl.dart';
import 'package:hadith/features/verses/surah/domain/repo/surah_repo.dart';


List<RepositoryProvider> pEsmaulHusnaDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<EsmaulHusnaRepo>(create: (context) => EsmaulHusnaRepoImpl(
      esmaulHusnaDao: appDatabase.esmaulHusnaDao
    )),
  ];
}