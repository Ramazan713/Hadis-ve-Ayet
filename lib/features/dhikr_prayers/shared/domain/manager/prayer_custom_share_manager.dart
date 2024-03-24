

import 'dart:typed_data';

import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';

abstract class PrayerCustomShareManager{

  Future<void> addWithText(String text);

  Future<Resource<void>> parseFile(String filePath);

  Uint8List getJsonData(PrayerCustom prayer);
}