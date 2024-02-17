


abstract class ISavePointListNavigatorEvent{}

class SavePointListNavigatorEventLoadData extends ISavePointListNavigatorEvent{
  final int listId;

  SavePointListNavigatorEventLoadData({
    required this.listId,
  });
}

class SavePointListNavigatorEventClearNavigation extends ISavePointListNavigatorEvent{}
