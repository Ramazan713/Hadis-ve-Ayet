

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';
import 'package:hadith/db/database.dart';

List<RepositoryProvider> pCoreDomainUseCaseProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<FontModelUseCase>(create: (context)=> FontModelUseCase(
      appPreferences: context.read()
    ))
  ];
}