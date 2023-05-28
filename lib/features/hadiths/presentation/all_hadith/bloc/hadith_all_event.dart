

import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';

abstract class IHadithAllEvent{}

class HadithEventClearInvalidateEvent extends IHadithAllEvent{}

class HadithEventFavorite extends IHadithAllEvent{
  final HadithListModel item;
  HadithEventFavorite({required this.item});
}

class HadithEventListenFontSize extends IHadithAllEvent{}
