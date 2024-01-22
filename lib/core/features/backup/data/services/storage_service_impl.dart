import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/features/auth/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/features/backup/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/features/backup/domain/services/storage_service.dart';
import 'package:hadith/core/utils/resource.dart';

class StorageServiceImpl extends StorageService{

  final _storage = FirebaseStorage.instance;

  Reference _getReference(AuthUser user){
    return _storage.ref("Backups/${user.uid}/");
  }

  @override
  Future<Resource<List<BackupMetaModel>>> getFiles({
    required AuthUser user
  })async{
    return await _errorHandling(()async{
      final rootRef = _getReference(user);
      final backupMetas = <BackupMetaModel>[];

      final listResult = await rootRef.listAll().timeout(const Duration(seconds: K.timeOutSeconds));
      for(var resultRef in listResult.items){
        final metadata = await resultRef.getMetadata();
        backupMetas.add(_getBackupMeta(metadata));
      }
      return backupMetas;
    });
  }

  @override
  Future<Resource<Uint8List>> getFileData({
    required AuthUser user,
    required String fileName
  }){
    return _errorHandling(()async{
      final rootRef = _getReference(user);
      final rawData = await rootRef.child(fileName)
          .getData().timeout(const Duration(seconds:  K.timeOutSeconds));

      if(rawData == null){
        throw Exception("Veri bulunamadı");
      }
      return rawData;
    });
  }

  @override
  Future<Resource<BackupMetaModel>> uploadData({
    required AuthUser user,
    required String fileName,
    required Uint8List rawData,
    bool isAuto=false
  }){
    return _errorHandling(()async{
      final rootRef = _getReference(user);
      final result=await rootRef.child(fileName).putData(rawData,SettableMetadata(
          customMetadata: {
            "isAuto": isAuto.toString()
          }
      )).timeout(const Duration(seconds:  K.timeOutSeconds));
      if(result.state==TaskState.success && result.metadata!=null){
        return _getBackupMeta(result.metadata!);
      }
      throw Exception("bazı hatalar oluştu");
    });
  }

  @override
  Future<void> deleteFile({
    required AuthUser user,
    required String fileName
  })async{
    await _errorHandling(() async{
      final rootRef = _getReference(user);
      await rootRef.child(fileName).delete().timeout(const Duration(seconds: K.timeOutSeconds));
    });
  }

  Future<Resource<T>> _errorHandling<T>(Future<T> Function() func)async{
    try{
      return Resource.success(await func.call());
    }catch(e){
      return Resource.error("Bir şeyler yanlış gitti");
    }
  }

  BackupMetaModel _getBackupMeta(FullMetadata fullMetadata){
    return BackupMetaModel(
        fileName: fullMetadata.name,
        updatedDate: fullMetadata.updated?.toString()??"",
        isAuto: fullMetadata.customMetadata?["isAuto"]=="true"?true:false
    );
  }
}