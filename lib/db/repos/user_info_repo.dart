

import 'package:hadith/db/entities/user_info_entity.dart';
import 'package:hadith/db/services/user_info_dao.dart';

class UserInfoRepoOld{
  final UserInfoDaoOld userInfoDao;

  UserInfoRepoOld({required this.userInfoDao});

  Future<int>insertUserInfo(UserInfoEntityOld userInfoEntity)=>
      userInfoDao.insertUserInfo(userInfoEntity);

  Future<int>updateUserInfo(UserInfoEntityOld userInfoEntity)=>
      userInfoDao.updateUserInfo(userInfoEntity);

  Stream<UserInfoEntityOld?>getStreamUserInfoWithId(String userId)=>
      userInfoDao.getStreamUserInfoWithId(userId);

  Future<UserInfoEntityOld?>getUserInfoWithId(String userId)=>
      userInfoDao.getUserInfoWithId(userId);

  Future<void>deleteAllDataWithQuery()=>
      userInfoDao.deleteAllDataWithQuery();

  Future<int>deleteUserInfo(UserInfoEntityOld userInfoEntity)=>
      userInfoDao.deleteUserInfo(userInfoEntity);

}