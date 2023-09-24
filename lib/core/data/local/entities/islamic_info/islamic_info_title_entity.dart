import 'package:floor/floor.dart';

@Entity(tableName: "IslamicInfoTitles")
class IslamicInfoTitleEntity{

  @primaryKey
  final int?id;
  final String title;
  final String? description;
  final int type;

  IslamicInfoTitleEntity({
    this.id,
    this.description,
    required this.title,
    required this.type,
  });

}
