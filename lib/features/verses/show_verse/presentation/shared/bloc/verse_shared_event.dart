import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/features/get_title/domain/enums/title_enum.dart';

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


