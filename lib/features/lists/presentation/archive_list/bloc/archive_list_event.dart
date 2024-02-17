

import 'package:hadith/core/domain/models/list/list_view_model.dart';

abstract class IArchiveListEvent{}

class ArchiveListEventListenListModels extends IArchiveListEvent{}

class ArchiveListEventLoadData extends IArchiveListEvent{
  final int? selectedListId;
  ArchiveListEventLoadData({required this.selectedListId});
}

class ArchiveListEventRename extends IArchiveListEvent{
  final String newTitle;
  final ListViewModel listViewModel;
  ArchiveListEventRename({required this.listViewModel, required this.newTitle});
}

class ArchiveListEventRemove extends IArchiveListEvent{
  final ListViewModel listViewModel;
  ArchiveListEventRemove({required this.listViewModel});
}

class ArchiveListEventUnArchive extends IArchiveListEvent{
  final ListViewModel listViewModel;
  ArchiveListEventUnArchive({required this.listViewModel});
}

class ArchiveListEventHideDetail extends IArchiveListEvent{}

class ArchiveListEventShowDetail extends IArchiveListEvent{
  final ListViewModel item;
  ArchiveListEventShowDetail({required this.item});
}

class ArchiveListEventClearMessage extends IArchiveListEvent{}

class ArchiveEventClearJumpToPos extends IArchiveListEvent{}