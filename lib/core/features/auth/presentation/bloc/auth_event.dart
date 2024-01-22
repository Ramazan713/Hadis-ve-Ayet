


abstract class IAuthEvent{}

class AuthEventListenAuthChange extends IAuthEvent{}

class AuthEventSignIn extends IAuthEvent{}

class AuthEventSignOut extends IAuthEvent{}

class AuthEventSignOutWithBackup extends IAuthEvent{}

class AuthEventHideDownloadBackupDia extends IAuthEvent{}

class AuthEventClearCompletedLoading extends IAuthEvent{}

class AuthEventClearDialogEvent extends IAuthEvent{}

class AuthEventClearMessage extends IAuthEvent{}
