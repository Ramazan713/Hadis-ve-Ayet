

import 'package:hadith/core/domain/models/list/list_view_model.dart';

abstract class IShowListEvent{}

class ShowListEventListenListHadiths extends IShowListEvent{}
class ShowListEventListenListVerses extends IShowListEvent{}

class ShowListEventChangeTab extends IShowListEvent{
    final int index;
    ShowListEventChangeTab({required this.index});
}

class ShowListEventSetVisibilitySearchBar extends IShowListEvent{
    final bool searchBarVisible;
    ShowListEventSetVisibilitySearchBar({required this.searchBarVisible});
}

class ShowListEventSearch extends IShowListEvent{
    final String query;
    ShowListEventSearch({required this.query});
}

class ShowListEventAddNewList extends IShowListEvent{
    final String listName;
    ShowListEventAddNewList({required this.listName});
}

class ShowListEventRename extends IShowListEvent{
    final String newTitle;
    final ListViewModel listViewModel;
    ShowListEventRename({required this.listViewModel, required this.newTitle});
}

class ShowListEventRemove extends IShowListEvent{
    final ListViewModel listViewModel;
    ShowListEventRemove({required this.listViewModel});
}

class ShowListEventArchive extends IShowListEvent{
    final ListViewModel listViewModel;
    ShowListEventArchive({required this.listViewModel});
}

class ShowListEventRemoveItems extends IShowListEvent{
    final ListViewModel listViewModel;
    ShowListEventRemoveItems({required this.listViewModel});
}

class ShowListEventCopy extends IShowListEvent{
    final ListViewModel listViewModel;
    ShowListEventCopy({required this.listViewModel});
}


class ShowListEventHideDetail extends IShowListEvent{}

class ShowListEventShowDetail extends IShowListEvent{
    final ListViewModel item;
    ShowListEventShowDetail({required this.item});
}

class ShowListEventSetSelected extends IShowListEvent{
    final ListViewModel? item;
    ShowListEventSetSelected({required this.item});
}


class ShowListEventClearMessage extends IShowListEvent{}