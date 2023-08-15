import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/islamic_info/data/entity/islamic_info_title_entity.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info_item.dart';


@Entity(tableName: "IslamicInfoItem",
  foreignKeys: [
    ForeignKey(
        childColumns: ["titleId"],
        parentColumns: ["id"],
        entity: IslamicInfoTitleEntityOld
    )
  ]
)
class IslamicInfoItemEntityOld{

  @primaryKey
  final int?id;
  final int titleId;
  final String? name;
  final String? description;

  IslamicInfoItemEntityOld({this.id,this.name,required this.titleId,
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
