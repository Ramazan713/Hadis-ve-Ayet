

import 'package:hadith/core/data/local/services/topic/section_view_dao.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';
import 'package:hadith/features/topics/data/mapper/section_view_mapper.dart';
import 'package:hadith/features/topics/domain/model/section_view_model.dart';
import 'package:hadith/features/topics/domain/repo/section_view_repo.dart';

class SectionViewRepoImpl extends SectionViewRepo{

  late final SectionViewDao _sectionViewDao;
  late final QueryExtUseCase _queryExtUseCase;

  SectionViewRepoImpl({
    required SectionViewDao sectionViewDao,
    required QueryExtUseCase queryExtUseCase
  }){
    _sectionViewDao = sectionViewDao;
    _queryExtUseCase = queryExtUseCase;
  }

  @override
  Stream<List<SectionViewModel>> getSectionTopicsByBookId(int bookId){
    return (_sectionViewDao.getSectionTopicsByBookId(bookId))
    .map((items) => items.map((e) => e.toSectionViewModel()).toList());
  }

  @override
  Stream<List<SectionViewModel>> getSectionTopicsByBookIdAndQuery(int bookId, String query){
    final queryResult = _queryExtUseCase.call(query);
    return (_sectionViewDao.getSectionTopicsByBookIdAndQuery(bookId,
        queryResult.queryLikeForSearch, queryResult.queryLikeForOrder, queryResult.queryRaw
    )).map((items) => items.map((e) => e.toSectionViewModel()).toList());
  }

  @override
  Future<int> getTopicsCountByBookId(int bookId) async{
    return (await _sectionViewDao.getTopicsCountByBookId(bookId))??0;
  }

}