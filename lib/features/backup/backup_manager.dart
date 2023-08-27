

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/constants/enums/backup_meta_control.dart';
import 'package:hadith/db/entities/backup_meta.dart';
import 'package:hadith/db/entities/user_info_entity.dart';
import 'package:hadith/db/repos/backup_meta_repo.dart';
import 'package:hadith/db/repos/backup_repo.dart';
import 'package:hadith/db/repos/user_info_repo.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/services/auth_service.dart';
import 'package:hadith/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class BackupManager{
  late final StorageServiceOld _storageService;
  late final LocalBackupRepoOld _backupRepo;
  late final BackupMetaRepoOld _backupMetaRepo;
  late final UserInfoRepoOld _userInfoRepo;
  late final AuthServiceOld _authService;
  final Uuid _uuid=const Uuid();

  BackupManager({required StorageServiceOld storageService,required LocalBackupRepoOld localBackupRepo,required BackupMetaRepoOld backupMetaRepo,
    required UserInfoRepoOld userInfoRepo, required AuthServiceOld authService
  }){
    _storageService = storageService;
    _backupRepo = localBackupRepo;
    _backupMetaRepo = backupMetaRepo;
    _userInfoRepo = userInfoRepo;
    _authService = authService;
  }


  Future<Resource<String>> refreshFiles(User user)async{
    final filesResource=await _storageService.getFiles(user);
    if(filesResource is ResourceSuccess<List<BackupMetaOld>>){
      await _backupMetaRepo.deleteBackupMetaWithQuery();
      await _backupMetaRepo.insertBackupMetas(filesResource.data);
      return Resource.success("Başarılı");
    }
    return Resource.error("Bir şeyler yanlış gitti");
  }


  Future<void>logOutRemoveFiles(User user)async{
    await _backupMetaRepo.deleteBackupMetaWithQuery();
    await _backupRepo.deleteAllData();
    final userInfo=await _userInfoRepo.getUserInfoWithId(user.uid);
    if(userInfo!=null) {
      await _userInfoRepo.deleteUserInfo(userInfo);
    }
  }

  Future<Resource<int>> downloadLoginFiles(User user)async{
    final resourceFiles=await _storageService.getFiles(user);
    if(resourceFiles is ResourceSuccess<List<BackupMetaOld>>){
      final result=await _backupMetaRepo.insertBackupMetas(resourceFiles.data);

      final photoData=await _authService.downloadUserPhoto(user);
      await _userInfoRepo.insertUserInfo(UserInfoEntityOld(
          userId: user.uid,
          img: photoData
      ));

      final fileLength = resourceFiles.data.length;
      await _checkRedundantBackupMetas(user,fileLength);

      return Resource.success(result.length);
    }
    return Resource.error("Bir şeyler yanlış gitti");
  }

  Future<Resource<String>>uploadBackup(User user,bool isAuto)async{

    final response = await _uploadDataWithMeta(user, isAuto);
    if(response is ResourceSuccess<BackupMetaOld>?) {
      return ResourceSuccess("Başarılı");
    }
    return Resource.error("Bir şeyler yanlış gitti");
  }

  Future<void>deleteAllData()async{
    await _backupRepo.deleteAllData();
  }

  Future<Resource<String>>downloadLastBackup(User user)async{
    final backupMeta=await _backupMetaRepo.getLastBackupMeta();
    if(backupMeta!=null){
      return  await downloadFile(backupMeta.fileName, user, true);
    }
    return Resource.error("bir şeyler yanlış gitti");
  }

  Future<Resource<String>> downloadFile(String fileName,User user,bool deleteAllData)async{

    var fileResponse=await _storageService.getFileData(user,fileName);
    var result = Resource<String>.error("bir şeyler yanlış gitti");

    if(fileResponse is ResourceSuccess<Uint8List?>&&fileResponse.data!=null){
      await _backupRepo.extractDataFromUint8List(fileResponse.data!,listenerBeforeInsertion: ()async{
        if(deleteAllData){
          await _backupRepo.deleteAllData();
        }
      },listenerComplete: (isComplete){
        if(isComplete){
          result = Resource.success("Başarılı");
        }
      });
    }
    return result;
  }


  Future<Resource<BackupMetaOld>?> _uploadDataWithMeta(User user,bool isAuto)async{

    Resource<BackupMetaOld>? result;
    final BackupMetaControl controlBackup;
    final BackupMetaOld? backupMeta;

    if(isAuto){
      controlBackup=await _backupMetaRepo.controlAutoBackups();
      backupMeta = await _backupMetaRepo.getFirstUpdatedAutoBackupMeta();
    }else{
      controlBackup=await _backupMetaRepo.controlNonAutoBackups();
      backupMeta = await _backupMetaRepo.getFirstUpdatedNonAutoBackupMeta();
    }

    switch(controlBackup){
      case BackupMetaControl.delete:
      case BackupMetaControl.fixed:
        final rawData=await _backupRepo.getUint8ListData();
        if(backupMeta!=null){
          result=await _storageService.uploadData(user,backupMeta.fileName,
              rawData,isAuto: backupMeta.isAuto);
          if(result is ResourceSuccess<BackupMetaOld>){
            await _backupMetaRepo.updateBackupMeta(result.data.copyWith(id: backupMeta.id
                ,keepOldId: true));
          }
        }
        break;
      case BackupMetaControl.insert:
        final name=_uuid.v4();
        final rawData=await _backupRepo.getUint8ListData();
        result=await _storageService.uploadData(user,name, rawData,isAuto: isAuto);
        if(result is ResourceSuccess<BackupMetaOld>){
          await _backupMetaRepo.insertBackupMeta(result.data);
        }
        break;
      case BackupMetaControl.none:
        break;
    }
    return result;
  }


  Future<void> _checkRedundantBackupMetas(User user,int fileLength)async{

    final controlBackup=await _backupMetaRepo.controlNonAutoBackups();
    final nonAutoBackupMetas = await _backupMetaRepo.getNonAutoBackupMetaWithOffset(kNonAutoMaxBackups,
        fileLength-kNonAutoMaxBackups);
    await _deleteRedundantBackupMetas(controlBackup, nonAutoBackupMetas, fileLength-kNonAutoMaxBackups, user);

    final controlBackupAuto=await _backupMetaRepo.controlAutoBackups();
    final autoBackupMetas = await _backupMetaRepo.getAutoBackupMetaWithOffset(kAutoMaxBackups,
        fileLength-kAutoMaxBackups);
    await _deleteRedundantBackupMetas(controlBackupAuto, autoBackupMetas, fileLength-kAutoMaxBackups, user);
  }

  Future<void>_deleteRedundantBackupMetas(BackupMetaControl backupMetaControl,
      List<BackupMetaOld> backupMetas,int limit,User user)async{
    if(backupMetaControl==BackupMetaControl.delete){
      if(limit>0){
        for(var backup in backupMetas){
          await _storageService.deleteFile(user,backup.fileName);
        }
        await _backupMetaRepo.deleteBackupMetas(backupMetas);
      }
    }
  }


}