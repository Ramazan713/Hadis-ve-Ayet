

import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';

class ResultLoadSavePoint{
  final SavePointDestination destination;
  final int itemIndexPos;

  ResultLoadSavePoint({required this.destination, required this.itemIndexPos});
}