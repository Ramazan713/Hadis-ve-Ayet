
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';

class History {
  final int? id;
  final String name;
  final SavePointType savePointType;
  final String modifiedDate;

  const History({this.id, required this.name, this.savePointType = SavePointType.search ,required this.modifiedDate});
}