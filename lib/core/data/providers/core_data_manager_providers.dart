

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/repo/share/share_manager_impl.dart';
import 'package:hadith/core/domain/repo/share/share_manager.dart';
import 'package:hadith/db/database.dart';

List<RepositoryProvider> pCoreDataManagerRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<ShareManager>(create: (context) => ShareManagerImpl(hadithRepo: context.read(),
        verseRepo: context.read())),
  ];
}