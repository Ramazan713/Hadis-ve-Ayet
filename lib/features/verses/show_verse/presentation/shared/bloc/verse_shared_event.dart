

import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
abstract class IVerseSharedEvent{}

class VerseSharedEventInit extends IVerseSharedEvent{}

class VerseSharedEventAddFavorite extends IVerseSharedEvent{
  final VerseListModel verseListModel;
  final bool listFavAffected;

  VerseSharedEventAddFavorite({required this.verseListModel, required this.listFavAffected});
}

class VerseSharedEventSetTitle extends IVerseSharedEvent{
  final int itemId;
  final TitleEnum titleEnum;

  VerseSharedEventSetTitle({required this.itemId, required this.titleEnum});
}


class VerseSharedEventClearInvalidateEvent extends IVerseSharedEvent{}


