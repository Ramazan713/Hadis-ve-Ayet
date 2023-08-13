

import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';

abstract class IDetailEsmaulHusnaEventOld{}

class DetailEsmaulHusnaEventInit extends IDetailEsmaulHusnaEventOld{}

class DetailEsmaulHusnaEventSetInit extends IDetailEsmaulHusnaEventOld{
  final EsmaulHusna item;
  final bool jumpToPage;
  DetailEsmaulHusnaEventSetInit({required this.item,required this.jumpToPage});
}

class DetailEsmaulHusnaEventSaveAsDhikr extends IDetailEsmaulHusnaEventOld{
  final EsmaulHusna item;
  DetailEsmaulHusnaEventSaveAsDhikr({required this.item});
}

class DetailEsmaulHusnaEventGotoDhikr extends IDetailEsmaulHusnaEventOld{
  final EsmaulHusna item;
  DetailEsmaulHusnaEventGotoDhikr({required this.item});
}

