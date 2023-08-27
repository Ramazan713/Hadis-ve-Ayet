

import 'package:hadith/core/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/utils/resource.dart';

abstract class BackupManager{

  Future<Resource<String>> refreshBackupFiles(AuthUser user);

  Future<void> deleteAllSessionData(AuthUser user);

  Future<Resource<int>> downloadLoginFiles(AuthUser user);

  Future<Resource<String>> uploadBackup({
    required AuthUser user,
    required bool isAuto
  });

  Future<void> deleteAllUserData();

  Future<Resource<String>> downloadLastBackup(AuthUser user);

  Future<Resource<String>> downloadFile({
    required String fileName,
    required AuthUser user,
    required bool deleteAllData
  });
}