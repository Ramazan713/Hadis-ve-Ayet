
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hadith/core/features/auth/data/mapper/auth_user_mapper.dart';
import 'package:hadith/core/features/auth/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/features/auth/domain/services/auth_service.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:http/http.dart' as http;

class AuthServiceImpl extends AuthService{

  final _googleSignIn = GoogleSignIn();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  bool get hasSignIn => _firebaseAuth.currentUser != null;

  @override
  Stream<AuthUser?> get streamUser => _firebaseAuth.authStateChanges()
      .map((user) => user?.toAuthUser());

  @override
  AuthUser? get currentUser => _firebaseAuth.currentUser?.toAuthUser();

  @override
  Future<Resource<AuthUser>> signInWithGoogle() async {
    try {
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.currentUser?.clearAuthCache();
      }
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final googleAuth = await googleSignInAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final rs = await _firebaseAuth.signInWithCredential(credential);
        final user = rs.user;
        if (user != null) {
          return Resource.success(user.toAuthUser());
        }
      } else {
        return Resource.error("Bir şeyler yanlış gitti");
      }
    } catch (e) {
      return Resource.error(e.toString());
    }
    return Resource.error("Bilinmeyen bir hata");
  }

  @override
  Future<Uint8List?> downloadUserPhotoWithUser(AuthUser user)async{
    final url = user.photoUrl;
    if(url != null){
      final uri = Uri.parse(url);
      final result = await http.get(uri);
      return result.bodyBytes;
    }
    return null;
  }

  @override
  Future<Uint8List?> downloadUserPhoto()async{
    final user = currentUser;
    if(user == null) return null;
    return downloadUserPhotoWithUser(user);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }


}
