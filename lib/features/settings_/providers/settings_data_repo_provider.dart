

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/settings_/data/repo/user_info_repo_impl.dart';
import 'package:hadith/features/settings_/domain/repo/user_info_repo.dart';


List<RepositoryProvider> pSettingsDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<UserInfoRepo>(create: (context)=> UserInfoRepoImpl(
      userInfoDao: appDatabase.userInfoDao
    )),
  ];
}