

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/features/premium/domain/use_cases/premium_product_detail_info_use_case.dart';

List<RepositoryProvider> pCoreDomainUseCaseProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<FontModelUseCase>(create: (context)=> FontModelUseCase(
      appPreferences: context.read()
    )),
  ];
}

List<RepositoryProvider> pCoreDomainUseCaseForReposProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<PremiumProductDetailInfoUseCase>(create: (context)=> PremiumProductDetailInfoUseCase())
  ];
}