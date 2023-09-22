

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/services/auth_service_impl.dart';
import 'package:hadith/core/data/services/connectivity_service_impl.dart';
import 'package:hadith/core/data/services/file_service_impl.dart';
import 'package:hadith/core/data/services/storage_service_impl.dart';
import 'package:hadith/core/domain/services/auth_service.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';
import 'package:hadith/core/domain/services/file_service.dart';
import 'package:hadith/core/domain/services/storage_service.dart';
import 'package:hadith/core/data/local/database.dart';

List<RepositoryProvider> pCoreDataServiceProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<ConnectivityService>(create: (context) => ConnectivityServiceImpl()),
    RepositoryProvider<FileService>(create: (context) => FileServiceImpl()),
    RepositoryProvider<AuthService>(create: (context) => AuthServiceImpl()),
    RepositoryProvider<StorageService>(create: (context) => StorageServiceImpl())
  ];
}