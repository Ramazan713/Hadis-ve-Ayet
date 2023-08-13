


abstract class IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventClearMessage extends IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventSetQuery extends IShowEsmaulHusnaEvent{
  final String query;
  ShowEsmaulHusnaEventSetQuery({required this.query});
}

class ShowEsmaulHusnaEventSetSearchBarVisibility extends IShowEsmaulHusnaEvent{
  final bool isVisible;
  ShowEsmaulHusnaEventSetSearchBarVisibility({required this.isVisible});
}

class ShowEsmaulHusnaEventJumpToPos extends IShowEsmaulHusnaEvent{
  final int? jumpToPos;
  ShowEsmaulHusnaEventJumpToPos({required this.jumpToPos});
}

class ShowEsmaulHusnaEventListenData extends IShowEsmaulHusnaEvent{}

class ShowEsmaulHusnaEventListenAppPref extends IShowEsmaulHusnaEvent{}