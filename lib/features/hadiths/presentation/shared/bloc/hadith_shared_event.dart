

import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';

abstract class IHadithSharedEvent{}

class HadithSharedEventClearInvalidateEvent extends IHadithSharedEvent{}

class HadithSharedEventFavorite extends IHadithSharedEvent{
  final HadithListModel item;
  final bool listFavAffected;
  HadithSharedEventFavorite({required this.item, required this.listFavAffected});
}

class HadithSharedEventListenFontSize extends IHadithSharedEvent{}

class HadithSharedEventSetTitle extends IHadithSharedEvent{
  final TitleEnum titleEnum;
  final int itemId;

  HadithSharedEventSetTitle({required this.titleEnum, required this.itemId});
}
