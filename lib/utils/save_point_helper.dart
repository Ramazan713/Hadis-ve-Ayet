

import 'package:hadith/constants/enums/sourcetype_enum.dart';
import 'package:hadith/constants/extensions.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/save_point/constants/save_point_constant.dart';
import 'package:hadith/features/save_point/save_point_param.dart';

class SavePointHelper{
  static String getAutoSavePointTitle(SavePointParam savePointParam,String modifiedDate,SaveAutoType autoType,){

    final typeDescription = savePointParam.bookScope.sourceTypeOld.shortName;
    final wideSavePointScope = kSavePointScopeOrigins.contains(savePointParam.originTag);
    final name = wideSavePointScope?savePointParam.originTag.shortName:savePointParam.parentName;
    final label = autoType.label;
    return "${label!=""?"$label - ":" "}$name - $typeDescription - ${DateTimeFormats.formatDate1(modifiedDate)}";
  }

  static bool isScopeOrigin(OriginTag originTag){
    return kSavePointScopeOrigins.contains(originTag);
  }

  static bool isScopeSavePoint(SavePoint savepoint,String otherParentKey,OriginTag originTag,){
    final isScopeOrigin = kSavePointScopeOrigins.contains(originTag);
    return isScopeOrigin && savepoint.parentKey != otherParentKey;
  }

  static bool isScopeSavePoint2(SavePoint savepoint,SavePointParam savePointParam){
    return isScopeSavePoint(savepoint, savePointParam.parentKey, savePointParam.originTag);
  }
}