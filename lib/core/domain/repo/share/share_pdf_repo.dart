


import 'dart:typed_data';

import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
abstract class SharePdfRepo{

  Future<Uint8List> getHadithPdfContent(List<Hadith> hadiths, String title);

  Future<Uint8List> getVersePdfContent(List<Verse> verses, String title);

}