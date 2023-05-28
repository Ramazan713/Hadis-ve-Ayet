
import 'package:hadith/core/domain/enums/save_point/local_destination_scope.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';

abstract class IEditSavePointEvent{}

class EditSavePointEventLoadData extends IEditSavePointEvent{
  final SavePointDestination destination;
  final int? selectedSavePointId;
  final int position;

  EditSavePointEventLoadData({
    required this.destination,
    this.selectedSavePointId,
    required this.position,
  });
}


class EditSavePointEventChangeDestinationScope extends IEditSavePointEvent{
  final LocalDestinationScope scope;
  EditSavePointEventChangeDestinationScope({required this.scope});
}

class EditSavePointEventClearMessage extends IEditSavePointEvent{}

class EditSavePointEventRename extends IEditSavePointEvent{
  final SavePoint savePoint;
  final String newTitle;
  EditSavePointEventRename({required this.savePoint,required this.newTitle});
}

class EditSavePointEventDelete extends IEditSavePointEvent{
  final SavePoint savePoint;
  EditSavePointEventDelete({required this.savePoint});
}

class EditSavePointEventOverride extends IEditSavePointEvent{
  final SavePoint selectedSavePoint;
  EditSavePointEventOverride({required this.selectedSavePoint});
}

class EditSavePointEventInsert extends IEditSavePointEvent{
  final bool useLocalWide;
  final DateTime dateTime;
  final String title;
  EditSavePointEventInsert({ required this.title,
    required this.useLocalWide, required this.dateTime});
}


class EditSavePointEventSelect extends IEditSavePointEvent{
  final SavePoint? savePoint;
  EditSavePointEventSelect({required this.savePoint});
}





