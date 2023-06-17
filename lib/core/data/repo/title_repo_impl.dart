

import 'package:hadith/core/data/local/services/title_dao.dart';
import 'package:hadith/core/domain/enums/paging/paging_title_enum.dart';
import 'package:hadith/core/domain/repo/title_repo.dart';

class TitleRepoImpl extends TitleRepo{

  late final TitleDao _titleDao;

  TitleRepoImpl({required TitleDao titleDao}){
    _titleDao = titleDao;
  }

  @override
  Future<String> getTitle(int itemId, PagingTitleEnum titleEnum) async{
    String? title;

    switch(titleEnum){
      case PagingTitleEnum.topic:
        title = await _titleDao.getTopicTitleById(itemId);
        break;
      case PagingTitleEnum.list:
        title = await _titleDao.getListTitleById(itemId);
        break;
      case PagingTitleEnum.surah:
        title = await _titleDao.getSurahTitleById(itemId);
        break;
      case PagingTitleEnum.cuz:
        title = await _titleDao.getCuzTitleById(itemId);
        break;
    }
    return title ?? "";
  }

}