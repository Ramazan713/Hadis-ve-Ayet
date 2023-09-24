import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/islamic_info/islamic_info_title_entity.dart';


@Entity(
  tableName: "IslamicInfoItems",
  foreignKeys: [
    ForeignKey(
      childColumns: ["titleId"],
      parentColumns: ["id"],
      entity: IslamicInfoTitleEntity
    )
  ]
)
class IslamicInfoItemEntity{

  @primaryKey
  final int?id;
  final int titleId;
  final String? name;
  final String? description;

  IslamicInfoItemEntity({
    this.id,
    this.name,
    this.description,
    required this.titleId,
  });

}
