
import 'dart:typed_data';

import 'package:hadith/core/utils/resource.dart';

abstract class LocalBackupRepo{

  Future<Resource<void>> writeData({
    required Uint8List data,
    required bool deleteData,
  });

  Future<Uint8List> getData();

  Future<void> deleteAllData();
}