import 'package:hadith/core/domain/models/item_list_info.dart';
import 'package:hadith/core/domain/models/paging/i_paging_item.dart';
import 'package:hadith/core/domain/models/hadith.dart';

class HadithListModel with IPagingItem {
  final bool isInFavorite;
  final bool isInAnyList;
  final bool isInAnyArchiveList;
  final Hadith hadith;
  final int rowNumber;
  final String topicNames;

  HadithListModel({required this.isInFavorite, required this.isInAnyList, required this.hadith,
    required this.rowNumber, required this.topicNames,required this.isInAnyArchiveList});


  HadithListModel copyWith({
    bool? isInFavorite,
    bool? isInAnyList,
    bool? isInAnyArchiveList,
    Hadith? hadith,
    int? rowNumber,
    String? topicNames
  }){

    return HadithListModel(
      topicNames: topicNames??this.topicNames,
      hadith: hadith??this.hadith,
      isInAnyArchiveList: isInAnyArchiveList??this.isInAnyArchiveList,
      isInAnyList: isInAnyList??this.isInAnyList,
      isInFavorite: isInFavorite??this.isInFavorite,
      rowNumber: rowNumber??this.rowNumber,
    );
  }

  HadithListModel updateWith({required ItemListInfo itemListInfo, required bool useArchiveListFeatures, required Hadith updatedHadith}){
    return HadithListModel(
        isInFavorite: itemListInfo.inFavorite,
        isInAnyList: itemListInfo.getInAnyListWithArchiveList(useArchiveListFeatures),
        hadith: updatedHadith,
        rowNumber: rowNumber,
        topicNames: topicNames,
        isInAnyArchiveList: itemListInfo.inAnyArchiveList
    );
  }


  @override
  int get pagingId => hadith.id??0;
}
