
import 'dart:typed_data';
import 'package:floor/floor.dart';

@Entity(tableName: "UserInfos")
class UserInfoEntity{

  @PrimaryKey(autoGenerate: true)
  final int?id;

  final String userId;

  final Uint8List? img;

  UserInfoEntity({
    this.id,
    required this.userId,
    required this.img,
  });
}