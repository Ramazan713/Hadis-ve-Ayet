


import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';

abstract class IDetailEsmaulHusnaEvent{}

class DetailEsmaulHusnaEventListenAppPref extends IDetailEsmaulHusnaEvent{}

class DetailEsmaulHusnaEventListenInit extends IDetailEsmaulHusnaEvent{}

class DetailEsmaulHusnaEventClearMessage extends IDetailEsmaulHusnaEvent{}

class DetailEsmaulHusnaEventLoadData extends IDetailEsmaulHusnaEvent{
  final int initPos;
  DetailEsmaulHusnaEventLoadData({required this.initPos});
}

class DetailEsmaulHusnaEventSetCurrentItem extends IDetailEsmaulHusnaEvent{
  final int page;
  DetailEsmaulHusnaEventSetCurrentItem({required this.page});
}


class DetailEsmaulHusnaEventSaveAsDhikr extends IDetailEsmaulHusnaEvent{
  final EsmaulHusna item;
  DetailEsmaulHusnaEventSaveAsDhikr({required this.item});
}
