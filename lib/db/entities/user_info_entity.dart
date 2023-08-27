


import 'dart:typed_data';

import 'package:floor/floor.dart';

@Entity(tableName: "userInfo")
class UserInfoEntityOld{

  @PrimaryKey(autoGenerate: true)
  final int?id;

  final String userId;

  final Uint8List? img;

  UserInfoEntityOld({required this.userId,required this.img,this.id});

}