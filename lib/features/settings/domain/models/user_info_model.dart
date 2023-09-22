

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user_info_model.freezed.dart';

@freezed
class UserInfoModel with _$UserInfoModel{
  const factory UserInfoModel({
    required String userId,
    int? id,
    Uint8List? img
  }) = _UserInfoModel;
}