
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hadith/features/settings/loading_enum.dart';

class AuthStateOld extends Equatable{

  final LoadingEnum loadingEnum;
  final String?message;
  final User? user;
  final bool showDialogForDownloadBackup;
  final bool refreshApp;
  final bool askReUploadAutoBackup;
  final bool hasUploadAutoBackup;

  const AuthStateOld({required this.loadingEnum,this.message,this.user,required this.showDialogForDownloadBackup,
    required this.refreshApp,required this.askReUploadAutoBackup,required this.hasUploadAutoBackup
  });

  AuthStateOld copyWith({LoadingEnum?loadingEnum,String?message,bool setMessage = false,
    User?user,bool setUser=false,bool? showDialogForDownloadBackup,bool? refreshApp,
    bool?askReUploadAutoBackup,bool?hasUploadAutoBackup
  }){
    return AuthStateOld(
        loadingEnum: loadingEnum??this.loadingEnum,
        message: setMessage?message:this.message,
        user: setUser?user:this.user,
        showDialogForDownloadBackup: showDialogForDownloadBackup??this.showDialogForDownloadBackup,
        refreshApp: refreshApp??this.refreshApp,
        askReUploadAutoBackup: askReUploadAutoBackup??this.askReUploadAutoBackup,
        hasUploadAutoBackup: hasUploadAutoBackup??this.hasUploadAutoBackup
    );
  }

  static AuthStateOld init(){
    return const AuthStateOld(
        loadingEnum:LoadingEnum.idle,
        showDialogForDownloadBackup:false,
        refreshApp:false,
        askReUploadAutoBackup:false,
        hasUploadAutoBackup:false
    );
  }

  @override
  List<Object?> get props => [loadingEnum,message,user,showDialogForDownloadBackup,refreshApp,askReUploadAutoBackup,
    hasUploadAutoBackup
  ];
}