
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hadith/core/features/auth/domain/models/auth_user/auth_user.dart';

extension UserExt on User{
  AuthUser toAuthUser(){
    return AuthUser(
      uid: uid,
      email: email,
      photoUrl: photoURL,
      displayName: displayName
    );
  }
}