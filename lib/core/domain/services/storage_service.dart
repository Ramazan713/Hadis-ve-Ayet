

import 'dart:typed_data';

import 'package:hadith/core/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/utils/resource.dart';

abstract class StorageService{

  Future<Resource<List<BackupMetaModel>>> getFiles({required AuthUser user});

  Future<Resource<Uint8List>> getFileData({required AuthUser user, required String fileName});

  Future<Resource<BackupMetaModel>> uploadData({
    required AuthUser user,
    required String fileName,
    required Uint8List rawData,
    bool isAuto=false
  });

  Future<void> deleteFile({
    required AuthUser user,
    required String fileName
  });
}