

import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';

abstract class IDetailEsmaulHusnaEvent{}

class DetailEsmaulHusnaEventInit extends IDetailEsmaulHusnaEvent{}

class DetailEsmaulHusnaEventSetInit extends IDetailEsmaulHusnaEvent{
  final EsmaulHusna item;
  final bool jumpToPage;
  DetailEsmaulHusnaEventSetInit({required this.item,required this.jumpToPage});
}

class DetailEsmaulHusnaEventSaveAsDhikr extends IDetailEsmaulHusnaEvent{
  final EsmaulHusna item;
  DetailEsmaulHusnaEventSaveAsDhikr({required this.item});
}

class DetailEsmaulHusnaEventGotoDhikr extends IDetailEsmaulHusnaEvent{
  final EsmaulHusna item;
  DetailEsmaulHusnaEventGotoDhikr({required this.item});
}

