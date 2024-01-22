import 'package:hadith/core/domain/models/item_list_info.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/features/pagination/domain/models/i_paging_item.dart';

class HadithListModel with IPagingItem {
  final bool isInFavorite;
  final bool isInAnyList;
  final bool isInAnyArchiveList;
  final Hadith hadith;
  int _rowNumber = 0;
  final String topicNames;

  HadithListModel({required this.isInFavorite, required this.isInAnyList, required this.hadith,
    required int rowNumber, required this.topicNames,required this.isInAnyArchiveList}){
    _rowNumber = rowNumber;
  }


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
      rowNumber: rowNumber??_rowNumber,
    );
  }

  HadithListModel updateWith({required ItemListInfo itemListInfo, required bool useArchiveListFeatures, required Hadith updatedHadith}){
    return HadithListModel(
        isInFavorite: itemListInfo.inFavorite,
        isInAnyList: itemListInfo.getInAnyListWithArchiveList(useArchiveListFeatures),
        hadith: updatedHadith,
        rowNumber: _rowNumber,
        topicNames: topicNames,
        isInAnyArchiveList: itemListInfo.inAnyArchiveList
    );
  }


  @override
  int get pagingId => hadith.id??0;

  @override
  int get rowNumber => _rowNumber;

  @override
  set rowNumber(value) {
    _rowNumber = value;
  }
}
