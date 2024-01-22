

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/features/auth/domain/models/auth_user/auth_user.dart';

import 'auth_dialog_event.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState{
  const factory AuthState({
    required LoadingEnum loadingEnum,
    String? message,
    AuthDialogEvent? dialogEvent,
    AuthUser? currentUser
  }) = _AuthState;
  
  static AuthState init(){
    return const AuthState(
      loadingEnum: LoadingEnum.idle,
    );
  }
}