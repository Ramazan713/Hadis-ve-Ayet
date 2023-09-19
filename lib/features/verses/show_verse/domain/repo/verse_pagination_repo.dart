

import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/item_list_info.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/repo/item_list_info_repo.dart';
import 'package:hadith/core/domain/repo/pagination_repo.dart';
import 'package:hadith/core/domain/models/verse/verse_arabic.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/domain/repo/verse/verse_arabic_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class VersePaginationRepo extends PaginationRepo<VerseListModel, int>{

  @protected
  late final VerseRepo verseRepo;
  late final VerseArabicRepo _verseArabicRepo;
  late final ItemListInfoRepo _itemListInfoRepo;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  bool get _useArchiveListFeatures => _sharedPreferences.getBool(PrefConstants.useArchiveListFeatures.key)??false;

  VersePaginationRepo({
    required this.verseRepo,
    required VerseArabicRepo verseArabicRepo,
    required ItemListInfoRepo itemListInfoRepo
  }){
    _verseArabicRepo = verseArabicRepo;
    _itemListInfoRepo = itemListInfoRepo;
  }

  @protected
  Future<List<Verse>> getVerseItems(int pageSize, int startIndex, int startPage, int endPage);

  @override
  Future<List<VerseListModel>> getItems(int startIndex, int endIndex, int startPage, int endPage) async{
    final verses = await getVerseItems(endIndex-startIndex, startIndex, startPage, endPage);
    final items = <VerseListModel>[];

    var index = 1;
    for(final verse in verses){
      final item = await _getVerseListModel(verse, startIndex + index, _useArchiveListFeatures);
      items.add(item);
      index++;
    }
    return items;

  }

  Future<VerseListModel> _getVerseListModel(Verse verse, int rowNumber,bool useArchiveListFeatures)async{
    final verseId = verse.id ?? 0;

    final listInfo = await _getListInfo(verseId);
    final verseArabics = await _getVerseArabics(verseId);

    return VerseListModel(
        isInFavorite: listInfo.inFavorite,
        isInAnyList: listInfo.getInAnyListWithArchiveList(useArchiveListFeatures),
        isInAnyArchiveList: listInfo.inAnyArchiveList,
        rowNumber: rowNumber,
        verse: verse,
        verseArabics: verseArabics
    );
  }


  Future<List<VerseArabic>> _getVerseArabics(int mealId) async{
    return _verseArabicRepo.getArabicVersesByMealId(mealId);
  }


  Future<ItemListInfo> _getListInfo(int verseId)async{
    final listInfo = await _itemListInfoRepo.getItemListInfo(verseId, SourceTypeEnum.verse);
    return listInfo ??
        ItemListInfo(
            itemId: verseId,
            sourceType: SourceTypeEnum.verse,
            inAnyList: false,
            inAnyArchiveList: false,
            inFavorite: false
        );
  }

  @override
  Future<VerseListModel?> getUpdatedItem(VerseListModel item) async{
    final itemListInfo = await _getListInfo(item.pagingId);
    return item.updateWith(
        itemListInfo: itemListInfo,
        useArchiveListFeatures: _useArchiveListFeatures,
    );
  }

  @override
  groupBy(item) {
    return item.pagingId;
  }

}