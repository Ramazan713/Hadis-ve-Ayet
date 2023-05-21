

import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';

abstract class IHadithEvent{}

class HadithEventClearInvalidateEvent extends IHadithEvent{}

class HadithEventFavorite extends IHadithEvent{
  final HadithListModel item;
  HadithEventFavorite({required this.item});
}
