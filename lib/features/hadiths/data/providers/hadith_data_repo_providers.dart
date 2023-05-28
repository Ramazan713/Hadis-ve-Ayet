


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_repo_impl.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_repo.dart';

List<RepositoryProvider> pHadithDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<HadithRepo>(create: (context) => HadithRepoImpl(hadithAllDao: appDatabase.hadithAllDao)),
  ];
}