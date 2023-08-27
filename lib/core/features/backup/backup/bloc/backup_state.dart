

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/domain/models/action_result/action_result.dart';
import 'package:hadith/core/domain/models/auth_user/auth_user.dart';
part 'backup_state.freezed.dart';

@freezed
class BackupState with _$BackupState{
  const factory BackupState({
    required LoadingEnum loadingEnum,
    required bool refreshApp,
    ActionResult? actionResult,
    String? message,
  }) = _BackupState;
  
  static BackupState init(){
    return const BackupState(
      loadingEnum: LoadingEnum.idle,
      refreshApp: false,
    );
  }
}