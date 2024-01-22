

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/core/features/backup/data/manager/backup_manager_impl.dart';
import 'package:hadith/core/features/backup/domain/manager/backup_manager.dart';
import 'package:hadith/core/features/share/data/manager/share_manager_impl.dart';
import 'package:hadith/core/features/share/domain/manager/share_manager.dart';

List<RepositoryProvider> pCoreDataManagerRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<ShareManager>(create: (context) => ShareManagerImpl(
        hadithRepo: context.read(),
        verseRepo: context.read()
    )),
    RepositoryProvider<BackupManager>(create: (context) => BackupManagerImpl(
      authService: context.read(),
      backupMetaRepo: context.read(),
      localBackupRepo: context.read(),
      storageService: context.read(),
      userInfoRepo: context.read()
    )),
  ];
}