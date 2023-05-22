import 'package:hadith/core/features/pagination/domain/model/i_paging_item.dart';
import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/db/entities/topic.dart';

class HadithListModel with IPagingItem {
  final bool isInFavorite;
  final bool isInAnyList;
  final Hadith hadith;
  final int rowNumber;
  final List<Topic> topics;

  HadithListModel({required this.isInFavorite, required this.isInAnyList, required this.hadith,
    required this.rowNumber, required this.topics});

  @override
  int get pagingId => hadith.id??0;
}
