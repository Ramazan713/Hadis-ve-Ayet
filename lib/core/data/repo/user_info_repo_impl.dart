
import 'dart:typed_data';

import 'package:hadith/core/data/local/services/user_info_dao.dart';
import 'package:hadith/features/settings/data/mapper/user_info_mapper.dart';
import 'package:hadith/features/settings/domain/models/user_info_model.dart';
import 'package:hadith/core/domain/repo/user_info_repo.dart';

class UserInfoRepoImpl extends UserInfoRepo{
  late final UserInfoDao _userInfoDao;

  UserInfoRepoImpl({
    required UserInfoDao userInfoDao
  }){
    _userInfoDao = userInfoDao;
  }

  @override
  Future<void> deleteUserInfo(UserInfoModel userInfo) {
    return _userInfoDao.deleteUserInfo(userInfo.toUserInfoEntity());
  }

  @override
  Stream<UserInfoModel?> getStreamUserInfoWithId(String userId) {
    return _userInfoDao.getStreamUserInfoWithId(userId)
        .map((e) => e?.toUserInfo());
  }

  @override
  Future<UserInfoModel?> getUserInfoWithId(String userId) async{
    return (await _userInfoDao.getUserInfoWithId(userId))?.toUserInfo();
  }

  @override
  Future<void> insertUserInfo({
    required String userId,
    Uint8List? img
  }) async{
    final userInfoModel = UserInfoModel(userId: userId,img: img);
    await _userInfoDao.insertUserInfo(userInfoModel.toUserInfoEntity());
  }

}