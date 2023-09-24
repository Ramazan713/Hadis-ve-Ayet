

import 'package:floor/floor.dart';

@Entity(tableName: "TopicSavePoints")
class TopicSavePointEntity{

  @primaryKey
  final int? id;
  final int pos;
  final int type;
  final String parentKey;

  TopicSavePointEntity({
    this.id,
    required this.pos,
    required this.type,
    required this.parentKey
  });
}