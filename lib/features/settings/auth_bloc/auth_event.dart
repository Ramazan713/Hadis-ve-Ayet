
abstract class IAuthEvent {}


class AuthEventInit extends IAuthEvent{}

class AuthEventSignIn extends IAuthEvent{}

class AuthEventSignOut extends IAuthEvent{}

class AuthEventDeleteAllLocalData extends IAuthEvent{}

class AuthEventDownloadLastBackup extends IAuthEvent{}

class AuthEventDoNotShowDialog extends IAuthEvent{}

class AuthEventUploadAutoBackup extends IAuthEvent{}

class AuthEventUploadBackup extends IAuthEvent{}

class AuthEventRefreshFiles extends IAuthEvent{}

class AuthEventDownloadFile extends IAuthEvent{
  final String fileName;
  final bool deleteAllLocalData;
  AuthEventDownloadFile({required this.fileName,required this.deleteAllLocalData});
}