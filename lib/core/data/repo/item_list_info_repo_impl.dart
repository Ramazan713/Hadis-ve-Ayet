

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/item_list_info.dart';

import '../../domain/repo/item_list_info_repo.dart';
import '../local/services/hadith_info_list_dao.dart';
import '../local/services/verse_info_list_dao.dart';

import '../local/mapper/item_list_info_mapper.dart';

class ItemListInfoRepoImpl extends ItemListInfoRepo{

  late final HadithInfoListDao _hadithInfoListDao;
  late final VerseInfoListDao _verseInfoListDao;

  ItemListInfoRepoImpl({required HadithInfoListDao hadithInfoListDao, required VerseInfoListDao verseInfoListDao}){
    _hadithInfoListDao = hadithInfoListDao;
    _verseInfoListDao = verseInfoListDao;
  }

  @override
  Future<ItemListInfo?> getItemListInfo(int itemId, SourceTypeEnum sourceType) async{
    switch(sourceType){
      case SourceTypeEnum.verse:
        return (await _verseInfoListDao.getVerseInfoList(itemId))?.toItemListInfo();
      case SourceTypeEnum.hadith:
        return (await _hadithInfoListDao.getHadithInfoList(itemId))?.toItemListInfo();
    }
  }
}