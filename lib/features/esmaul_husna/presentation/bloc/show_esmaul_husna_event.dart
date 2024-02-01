
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';

abstract class IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventClearMessage extends IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventReStartState extends IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventSetQuery extends IShowEsmaulHusnaEvent{
  final String query;
  ShowEsmaulHusnaEventSetQuery({required this.query});
}

class ShowEsmaulHusnaEventSetSearchBarVisibility extends IShowEsmaulHusnaEvent{
  final bool isVisible;
  ShowEsmaulHusnaEventSetSearchBarVisibility({required this.isVisible});
}


class ShowEsmaulHusnaEventSaveAsDhikr extends IShowEsmaulHusnaEvent{
  final EsmaulHusna item;
  ShowEsmaulHusnaEventSaveAsDhikr({required this.item});
}


class ShowEsmaulHusnaEventListenData extends IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventListenAppPref extends IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventHideDetail extends IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventShowDetail extends IShowEsmaulHusnaEvent{
  final EsmaulHusna item;
  ShowEsmaulHusnaEventShowDetail({required this.item});
}

class ShowEsmaulHusnaEventSetSelected extends IShowEsmaulHusnaEvent{
  final EsmaulHusna? item;
  ShowEsmaulHusnaEventSetSelected({required this.item});
}


