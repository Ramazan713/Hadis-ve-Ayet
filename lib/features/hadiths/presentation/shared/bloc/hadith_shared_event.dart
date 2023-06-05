

import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';

abstract class IHadithSharedEvent{}

class HadithSharedEventClearInvalidateEvent extends IHadithSharedEvent{}

class HadithSharedEventFavorite extends IHadithSharedEvent{
  final HadithListModel item;
  final bool listFavAffected;
  HadithSharedEventFavorite({required this.item, required this.listFavAffected});
}

class HadithSharedEventListenFontSize extends IHadithSharedEvent{}
