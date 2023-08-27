import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/enums/backup_meta_control_enum.dart';
import 'package:hadith/core/domain/extensions/resource_extension.dart';
import 'package:hadith/core/domain/manager/backup_manager.dart';
import 'package:hadith/core/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/domain/repo/backup/backup_meta_repo.dart';
import 'package:hadith/core/domain/repo/backup/local_backup_repo.dart';
import 'package:hadith/core/domain/services/auth_service.dart';
import 'package:hadith/core/domain/services/storage_service.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/features/settings_/domain/repo/user_info_repo.dart';
import 'package:uuid/uuid.dart';

class BackupManagerImpl extends BackupManager{

  late final StorageService _storageService;
  late final LocalBackupRepo _backupRepo;
  late final BackupMetaRepo _backupMetaRepo;
  late final UserInfoRepo _userInfoRepo;
  late final AuthService _authService;

  final Uuid _uuid = const Uuid();

  BackupManagerImpl({
    required StorageService storageService,
    required LocalBackupRepo localBackupRepo,
    required BackupMetaRepo backupMetaRepo,
    required UserInfoRepo userInfoRepo,
    required AuthService authService
  }){
    _storageService = storageService;
    _backupRepo = localBackupRepo;
    _backupMetaRepo = backupMetaRepo;
    _userInfoRepo = userInfoRepo;
    _authService = authService;
  }


  @override
  Future<Resource<String>> refreshBackupFiles(AuthUser user)async{
    final filesResource = await _storageService.getFiles(user: user);
    return filesResource.handleAsyncForResourceReturnType(
      onSuccess: (data)async{
        await _backupMetaRepo.replaceBackupMetas(data);
        return Resource.success("Başarılı");
      }
    );
  }


  @override
  Future<void> deleteAllSessionData(AuthUser user)async{
    await _backupMetaRepo.deleteAllBackupMetas();
    await _backupRepo.deleteAllData();
    final userInfo=await _userInfoRepo.getUserInfoWithId(user.uid);
    if(userInfo!=null) {
      await _userInfoRepo.deleteUserInfo(userInfo);
    }
  }

  @override
  Future<void> deleteAllUserData()async{
    await _backupRepo.deleteAllData();
  }



  @override
  Future<Resource<String>> uploadBackup({
    required AuthUser user,
    required bool isAuto
  })async{
    final result = await _uploadDataWithMeta(user: user, isAuto: isAuto);
    return result.handleForResourceReturnType(
      onSuccess: (data){
        return ResourceSuccess("Başarılı");
      }
    );
  }

  @override
  Future<Resource<int>> downloadLoginFiles(AuthUser user)async{
    final resourceFiles = await _storageService.getFiles(user: user);

    return resourceFiles.handleAsyncForResourceReturnType(
        onSuccess: (data)async{
          await _backupMetaRepo.insertBackupMetas(data);
          final photoData=await _authService.downloadUserPhoto();
          await _userInfoRepo.insertUserInfo(
              userId: user.uid,
              img: photoData
          );
          await _checkAndRemoveRedundantBackupMetas(user);
          return Resource.success(data.length);
        }
    );
  }

  @override
  Future<Resource<String>> downloadLastBackup(AuthUser user)async{
    final backupMeta=await _backupMetaRepo.getLastBackupMeta();
    if(backupMeta!=null){
      return downloadFile(
        fileName: backupMeta.fileName,
        user: user,
        deleteAllData: true
      );
    }
    return Resource.error("bir şeyler yanlış gitti");
  }

  @override
  Future<Resource<String>> downloadFile({
    required String fileName,
    required AuthUser user,
    required bool deleteAllData
  })async{

    var fileResponse=await _storageService.getFileData(
      user: user,
      fileName: fileName
    );

    return fileResponse.handleAsyncForResourceReturnType(
      onSuccess: (data)async{
        await _backupRepo.writeData(
          data: data,
          deleteData: deleteAllData,
        );
        return ResourceSuccess("Başarılı");
      }
    );
  }


  Future<Resource<void>> _uploadDataWithMeta({
    required AuthUser user,
    required bool isAuto
  })async{

    final controlBackup = await _backupMetaRepo.getControlEnum(
        isAuto: isAuto, keepTopNItem: isAuto ? K.backup.autoMaxBackups : K.backup.nonAutoMaxBackups
    );
    final backupMeta = await _backupMetaRepo.getFirstBackupMeta(isAuto);
    switch(controlBackup){
      case BackupMetaControlEnum.delete:
      case BackupMetaControlEnum.fixed:
        final rawData = await _backupRepo.getData();
        if(backupMeta != null){
          final result = await _storageService.uploadData(
              user: user,
              fileName: backupMeta.fileName,
              rawData: rawData,
              isAuto: backupMeta.isAuto
          );
          return await result.handleAsyncForResourceReturnType(
            onSuccess: (data)async{
              await _backupMetaRepo.updateBackupMeta(
                data.copyWith(id: backupMeta.id)
              );
              return ResourceSuccess(null);
            }
          );
        }
        break;
      case BackupMetaControlEnum.insert:
        final name = _uuid.v4();
        final rawData = await _backupRepo.getData();

        final result = await _storageService.uploadData(
            user: user,
            fileName: name,
            rawData: rawData,
            isAuto: isAuto
        );
        return await result.handleAsyncForResourceReturnType(
          onSuccess: (data) async{
            await _backupMetaRepo.insertBackupMeta(data);
            return ResourceSuccess(null);
          }
        );
      case BackupMetaControlEnum.none:
        break;
    }
    return ResourceError("Bir şeyler yanlış gitti");
  }


  Future<void> _checkAndRemoveRedundantBackupMetas(AuthUser user) async{
    final redundantAutoBackups = await _backupMetaRepo.getRedundantBackupMetas(
        isAuto: true,
        keepTopNItem: K.backup.autoMaxBackups
    );

    final redundantNonAutoBackups = await _backupMetaRepo.getRedundantBackupMetas(
        isAuto: false,
        keepTopNItem: K.backup.nonAutoMaxBackups
    );

    await _deleteBackupMetasFromServerAndLocal(user: user, items: redundantAutoBackups);
    await _deleteBackupMetasFromServerAndLocal(user: user, items: redundantNonAutoBackups);
  }

  Future<void> _deleteBackupMetasFromServerAndLocal({
    required AuthUser user,
    required List<BackupMetaModel> items
  })async{
    if(items.isEmpty) return;

    for (var item in items) {
      await _storageService.deleteFile(
        user: user,
        fileName: item.fileName
      );
    }
    await _backupMetaRepo.deleteBackupMetas(items);
  }

}