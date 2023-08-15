import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/model/islamic_info_title.dart';

@Entity(tableName: "IslamicInfoTitle")
class IslamicInfoTitleEntityOld{

  @primaryKey
  final int?id;
  final String title;
  final String? description;
  final int type;

  IslamicInfoTitleEntityOld({this.id,required this.title,required this.type,
    this.description
  });

  IslamicInfoTitle toIslamicInfoTitle(){
    return IslamicInfoTitle(
      id: id,
      title: title,
      description: description,
      type: IslamicInfoExt.fromTypeId(type)
    );
  }

}
