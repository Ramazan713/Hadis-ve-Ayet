


import 'dart:typed_data';

import 'package:hadith/features/settings_/domain/models/user_info_model.dart';

abstract class UserInfoRepo{

  Future<void> insertUserInfo({
    required String userId,
    Uint8List? img
  });

  Stream<UserInfoModel?> getStreamUserInfoWithId(String userId);

  Future<UserInfoModel?> getUserInfoWithId(String userId);

  Future<void> deleteUserInfo(UserInfoModel userInfo);
}