import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/db/entities/backup_meta.dart';
import 'package:hadith/core/utils/resource.dart';

class StorageServiceOld{
  final _storage=FirebaseStorage.instance;

  Reference _getReference(User user){
    return _storage.ref("Backups/${user.uid}/");;
  }

  BackupMetaOld _getBackupMeta(FullMetadata fullMetadata){
    return BackupMetaOld(
        fileName: fullMetadata.name,
        updatedDate: fullMetadata.updated?.toString()??"",
        isAuto: fullMetadata.customMetadata?["isAuto"]=="true"?true:false
    );
  }

  Future<Resource<List<BackupMetaOld>>>getFiles(User user)async{
    return await _errorHandling<List<BackupMetaOld>>(()async{
      final rootRef = _getReference(user);
      final backupMetas = <BackupMetaOld>[];

      final listResult=await rootRef.listAll().timeout(const Duration(seconds: kTimeOutSeconds));
      for(var resultRef in listResult.items){
        final metadata=await resultRef.getMetadata();
        backupMetas.add(_getBackupMeta(metadata));
      }
      return backupMetas;
    });
  }

  Future<Resource<T>> _errorHandling<T>(Future<T> Function() func)async{
    try{
      return Resource.success(await func.call());
    }catch(e){
      return Resource.error("Bir şeyler yanlış gitti");
    }
  }

  Future<Resource<Uint8List?>>getFileData(User user,String name){
    return _errorHandling<Uint8List?>(()async{
      final rootRef = _getReference(user);
      final rawData=await rootRef.child(name).getData().timeout(const Duration(seconds: kTimeOutSeconds));
      return rawData;
    });

  }

  Future<Resource<BackupMetaOld>>uploadData(User user,String name,Uint8List rawData,{bool isAuto=false})async{
    return await _errorHandling<BackupMetaOld>(()async{
      final rootRef = _getReference(user);
      final result=await rootRef.child(name).putData(rawData,SettableMetadata(
          customMetadata: {
            "isAuto":isAuto.toString()
          }
      )).timeout(const Duration(seconds: kTimeOutSeconds));
      if(result.state==TaskState.success&&result.metadata!=null){
        return _getBackupMeta(result.metadata!);
      }
      throw Exception("bazı hatalar oluştu");
    });
  }

  Future<void>deleteFile(User user,String name)async{
    await _errorHandling(() async{
      final rootRef = _getReference(user);
      await rootRef.child(name).delete().timeout(const Duration(seconds: kTimeOutSeconds));
    });
  }

}