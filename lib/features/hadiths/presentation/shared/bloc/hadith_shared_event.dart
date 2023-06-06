

import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_fetch_name_enum.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';

abstract class IHadithSharedEvent{}

class HadithSharedEventClearInvalidateEvent extends IHadithSharedEvent{}

class HadithSharedEventFavorite extends IHadithSharedEvent{
  final HadithListModel item;
  final bool listFavAffected;
  HadithSharedEventFavorite({required this.item, required this.listFavAffected});
}

class HadithSharedEventListenFontSize extends IHadithSharedEvent{}

class HadithSharedEventFetchName extends IHadithSharedEvent{
  final HadithFetchNameEnum fetchNameEnum;
  final int itemId;

  HadithSharedEventFetchName({required this.fetchNameEnum, required this.itemId});
}
