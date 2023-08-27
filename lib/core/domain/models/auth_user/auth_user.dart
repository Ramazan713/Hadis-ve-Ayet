

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'auth_user.freezed.dart';

@freezed
class AuthUser with _$AuthUser{
  const factory AuthUser({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl
  }) = _AuthUser;
}