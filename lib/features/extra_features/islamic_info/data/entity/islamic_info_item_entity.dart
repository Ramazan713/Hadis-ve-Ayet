import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/islamic_info/data/entity/islamic_info_title_entity.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info_item.dart';


@Entity(tableName: "IslamicInfoItem",
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

  IslamicInfoItemEntity({this.id,this.name,required this.titleId,
    this.description
  });

  IslamicInfoItem toIslamicInfoItem(){
    return IslamicInfoItem(
      id: id,
      titleId: titleId,
      name: name,
      description: description
    );
  }

}
