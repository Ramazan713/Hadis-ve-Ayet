import 'package:floor/floor.dart';

@Entity(tableName: "IslamicInfoTitle")
class IslamicInfoTitleEntity{

  @primaryKey
  final int?id;
  final String title;
  final String? description;
  final int type;

  IslamicInfoTitleEntity({
    this.id,
    required this.title,
    required this.type,
    this.description
  });

}
