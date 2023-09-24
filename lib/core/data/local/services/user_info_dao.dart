

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/user_info_entity.dart';

@dao
abstract class UserInfoDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUserInfo(UserInfoEntity userInfo);

  @delete
  Future<int>deleteUserInfo(UserInfoEntity userInfo);

  @Query("""select * from userInfos where userId=:userId limit 1""")
  Stream<UserInfoEntity?> getStreamUserInfoWithId(String userId);

  @Query("""select * from userInfos where userId=:userId limit 1""")
  Future<UserInfoEntity?> getUserInfoWithId(String userId);
}