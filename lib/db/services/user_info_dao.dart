

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/user_info_entity.dart';

@dao
abstract class UserInfoDaoOld{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertUserInfo(UserInfoEntityOld userInfoEntity);

  @Update()
  Future<int>updateUserInfo(UserInfoEntityOld userInfoEntity);

  @delete
  Future<int>deleteUserInfo(UserInfoEntityOld userInfoEntity);

  @Query("""select * from userInfo where userId=:userId""")
  Stream<UserInfoEntityOld?>getStreamUserInfoWithId(String userId);

  @Query("""select * from userInfo where userId=:userId""")
  Future<UserInfoEntityOld?>getUserInfoWithId(String userId);


  @Query("""delete from userInfo""")
  Future<void>deleteAllDataWithQuery();


}