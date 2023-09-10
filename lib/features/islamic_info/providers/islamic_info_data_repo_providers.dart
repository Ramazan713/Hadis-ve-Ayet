

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/islamic_info/shared/data/repo/islamic_info_repo_impl.dart';
import 'package:hadith/features/islamic_info/shared/domain/repo/islamic_info_repo.dart';


List<RepositoryProvider> pIslamicInfoDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<IslamicInfoRepo>(create: (context) => IslamicInfoRepoImpl(
      infoDao: appDatabase.islamicInfoDao
    )),
  ];
}