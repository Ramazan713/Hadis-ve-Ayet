

import 'dart:typed_data';

import 'package:hadith/core/features/auth/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/utils/resource.dart';

abstract class AuthService{

  bool get hasSignIn;

  AuthUser? get currentUser;

  Stream<AuthUser?> get streamUser;

  Future<Resource<AuthUser>> signInWithGoogle();

  Future<Uint8List?> downloadUserPhotoWithUser(AuthUser user);

  Future<Uint8List?> downloadUserPhoto();

  Future<void> signOut();
}