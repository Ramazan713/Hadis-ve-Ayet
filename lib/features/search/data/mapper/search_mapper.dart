

import 'package:hadith/core/data/local/entities/history_entity.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/features/search/domain/model/history.dart';

extension HistoryEntityExt on HistoryEntity{

  History toHistory(){
    return History(
      id: id,
      name: name,
      modifiedDate: modifiedDate,
      savePointType: SavePointType.from(originType)
    );
  }
}

extension HistoryExt on History{

  HistoryEntity toHistoryEntity(){
    return HistoryEntity(
        id: id,
        name: name,
        modifiedDate: modifiedDate,
        originType: savePointType.typeId
    );
  }
}

