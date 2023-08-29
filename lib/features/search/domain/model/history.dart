

import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';

class History {
  final int? id;
  final String name;
  final SavePointType savePointType;
  final String modifiedDate;

  const History({this.id, required this.name, this.savePointType = SavePointType.search ,required this.modifiedDate});
}