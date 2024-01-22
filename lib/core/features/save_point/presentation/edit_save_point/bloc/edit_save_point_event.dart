

import 'package:hadith/core/features/save_point/domain/enums/local_destination_scope.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';

abstract class IEditSavePointEvent{}

class EditSavePointEventLoadData extends IEditSavePointEvent{
  final SavePointDestination destination;
  final int? selectedSavePointId;
  final int position;
  final LocalDestinationScope? scope;

  EditSavePointEventLoadData({
    required this.destination,
    required this.position,
    this.selectedSavePointId,
    this.scope
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
  final DateTime dateTime;
  final String title;
  EditSavePointEventInsert({ required this.title, required this.dateTime});
}

class EditSavePointEventAutoInsert extends IEditSavePointEvent{
  final SavePointDestination destination;
  final int itemIndexPos;
  final SaveAutoType autoType;
  EditSavePointEventAutoInsert({
    required this.destination,
    required this.itemIndexPos,
    this.autoType = SaveAutoType.general
  });
}


class EditSavePointEventSelect extends IEditSavePointEvent{
  final SavePoint? savePoint;
  EditSavePointEventSelect({required this.savePoint});
}





