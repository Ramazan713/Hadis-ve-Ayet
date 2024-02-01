

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/features/esmaul_husna/data/repo/esmaul_husna_repo_impl.dart';
import 'package:hadith/features/esmaul_husna/domain/repo/esmaul_husna_repo.dart';

List<RepositoryProvider> pEsmaulHusnaDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<EsmaulHusnaRepo>(create: (context) => EsmaulHusnaRepoImpl(
      esmaulHusnaDao: appDatabase.esmaulHusnaDao,
      counterDao: appDatabase.counterDao
    )),
  ];
}