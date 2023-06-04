

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/selectable_list_view_model.dart';

abstract class ISelectListEvent{}


class SelectListEventLoadData extends ISelectListEvent{
  final int itemId;
  final SourceTypeEnum sourceType;
  final int? listIdControl;

  SelectListEventLoadData({required this.itemId, required this.sourceType, this.listIdControl});
}

class SelectListEventInsertOrDelete extends ISelectListEvent{
  final SelectableListViewModel item;

  SelectListEventInsertOrDelete({required this.item});
}

class SelectListEventInsertNewList extends ISelectListEvent{
  final String listName;

  SelectListEventInsertNewList({required this.listName});
}

class SelectListEventClearMessage extends ISelectListEvent{}

