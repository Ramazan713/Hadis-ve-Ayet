

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/repo/search_repo_impl.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/features/search/data/repo/history_repo_impl.dart';
import 'package:hadith/features/search/domain/repo/history_repo.dart';


List<RepositoryProvider> pSearchDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<SearchRepo>(create: (context) => SearchRepoImpl(
        searchDao: appDatabase.searchDao, getVerses: context.read())),
    RepositoryProvider<HistoryRepo>(create: (context) => HistoryRepoImpl(historyDao: appDatabase.historyDao))
  ];
}
