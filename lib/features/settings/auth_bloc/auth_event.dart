
abstract class IAuthEventOld {}


class AuthEventInit extends IAuthEventOld{}

class AuthEventSignIn extends IAuthEventOld{}

class AuthEventSignOut extends IAuthEventOld{}

class AuthEventDeleteAllLocalData extends IAuthEventOld{}

class AuthEventDownloadLastBackup extends IAuthEventOld{}

class AuthEventDoNotShowDialog extends IAuthEventOld{}

class AuthEventUploadAutoBackup extends IAuthEventOld{}

class AuthEventUploadBackup extends IAuthEventOld{}

class AuthEventRefreshFiles extends IAuthEventOld{}

class AuthEventDownloadFile extends IAuthEventOld{
  final String fileName;
  final bool deleteAllLocalData;
  AuthEventDownloadFile({required this.fileName,required this.deleteAllLocalData});
}