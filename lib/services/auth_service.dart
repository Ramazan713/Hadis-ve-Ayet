import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hadith/models/resource.dart';
import 'package:http/http.dart' as http;



class AuthService {
  final _googleSignIn = GoogleSignIn();
  final _firebaseAuth = FirebaseAuth.instance;

  Future<Resource<String>> signInWithGoogle() async {
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
        if (rs.user != null) {
          return Resource.success("Başarıyla Giriş Yapıldı");
        }
      } else {
        return Resource.error("Bir şeyler yanlış gitti");
      }
    } catch (e) {
      return Resource.error("Bilinmeyen bir hata");
    }
    return Resource.error("Bilinmeyen bir hata");
  }

  Future<Uint8List?> downloadUserPhoto(User user)async{
    if(user.photoURL!=null){
      final uri = Uri.parse(user.photoURL!);
      final result=await http.get(uri);
      return result.bodyBytes;
    }
    return null;
  }


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  bool hasSignIn() {
    return _firebaseAuth.currentUser != null;
  }

  Stream<User?> streamUser() {
    return _firebaseAuth.authStateChanges();
  }

  User? currentUser(){
    return _firebaseAuth.currentUser;
  }
}
