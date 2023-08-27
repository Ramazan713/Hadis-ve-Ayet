

import 'package:hadith/core/data/local/entities/user_info_entity.dart';
import 'package:hadith/features/settings_/domain/models/user_info_model.dart';

extension UserInfoEntityExt on UserInfoEntity{

  UserInfoModel toUserInfo(){
    return UserInfoModel(
      id: id,
      userId: userId,
      img: img
    );
  }
}

extension UserInfoExt on UserInfoModel{

  UserInfoEntity toUserInfoEntity(){
    return UserInfoEntity(
        id: id,
        userId: userId,
        img: img
    );
  }
}