

import 'package:hadith/core/domain/use_cases/save_point/delete_save_point.dart';
import 'package:hadith/core/domain/use_cases/save_point/get_save_points.dart';
import 'package:hadith/core/domain/use_cases/save_point/insert_save_point.dart';
import 'package:hadith/core/domain/use_cases/save_point/update_save_point.dart';

class SavePointUseCases{
  final InsertSavePoint insertSavePoint;
  final UpdateSavePoint updateSavePoint;
  final DeleteSavePoint deleteSavePoint;
  final GetSavePoints getSavePoints;

  SavePointUseCases({required this.insertSavePoint, required this.updateSavePoint,
    required this.deleteSavePoint, required this.getSavePoints
  });
}