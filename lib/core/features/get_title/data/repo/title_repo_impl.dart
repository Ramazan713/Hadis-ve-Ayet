import 'package:hadith/core/data/local/services/title_dao.dart';
import 'package:hadith/core/features/get_title/domain/enums/title_enum.dart';
import 'package:hadith/core/features/get_title/domain/repo/title_repo.dart';


class TitleRepoImpl extends TitleRepo{

  late final TitleDao _titleDao;

  TitleRepoImpl({required TitleDao titleDao}){
    _titleDao = titleDao;
  }

  @override
  Future<String> getTitle(int itemId, TitleEnum titleEnum) async{
    String? title;

    switch(titleEnum){
      case TitleEnum.topic:
        title = await _titleDao.getTopicTitleById(itemId);
        break;
      case TitleEnum.list:
        title = await _titleDao.getListTitleById(itemId);
        break;
      case TitleEnum.surah:
        title = await _titleDao.getSurahTitleById(itemId);
        break;
      case TitleEnum.cuz:
        title = await _titleDao.getCuzTitleById(itemId);
        break;
      case TitleEnum.counter:
        title = await _titleDao.getCounterTitleById(itemId);
        break;
    }
    return title ?? "";
  }

}