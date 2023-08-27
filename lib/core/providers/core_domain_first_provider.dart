

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';
import 'package:hadith/db/database.dart';

List<RepositoryProvider> pCoreDomainFirstProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<QueryExtUseCase>(create: (context)=> QueryExtUseCase())
  ];
}