

import 'package:hadith/features/save_point/model/savepoint.dart';
import 'package:hadith/features/paging/paging_argument.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';

import 'constants/book_scope_enum.dart';

class SavePointParam{
  final String parentKey;
  final int itemIndexPos;
  final String parentName;
  final BookScopeEnum bookScope;
  final OriginTag originTag;

  SavePointParam({required this.parentKey, required this.itemIndexPos, required this.parentName,
    required this.bookScope, required this.originTag});


  static SavePointParam fromPagingArgument(PagingArgument argument,int itemIndexPos){
    return SavePointParam(parentKey: argument.savePointArg.parentKey,
        itemIndexPos: itemIndexPos, parentName: argument.title, bookScope: argument.bookScope, originTag: argument.originTag);
  }

  SavePoint toSavePoint(String title,SaveAutoType autoType,String modifiedDate){
    return SavePoint(itemIndexPos: itemIndexPos, title: title,modifiedDate: modifiedDate,
        autoType: autoType, savePointType: originTag, bookScope: bookScope, parentKey: parentKey, parentName: parentName);
  }

  SavePoint toSavePointFromSavePoint(SavePoint savePoint){
    final date=DateTime.now().toIso8601String();
    return SavePoint(itemIndexPos: itemIndexPos, title: savePoint.title,modifiedDate: date,
        autoType: savePoint.autoType, savePointType: originTag, bookScope: bookScope, parentKey: parentKey,
        parentName: parentName, id: savePoint.id
    );
  }

}