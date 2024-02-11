

import 'package:hadith/core/data/local/services/topic/topic_hadiths_view_dao.dart';
import 'package:hadith/core/data/local/services/topic/topic_verses_view_dao.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';
import 'package:hadith/features/topics/data/mapper/topic_view_mapper.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/domain/repo/topic_view_repo.dart';

class TopicViewRepoImpl extends TopicViewRepo{
  late final TopicHadithViewDao _topicHadithsViewDao;
  late final TopicVersesViewDao _topicVersesViewDao;
  late final QueryExtUseCase _queryExtUseCase;

  TopicViewRepoImpl({
    required TopicHadithViewDao topicHadithViewDao,
    required TopicVersesViewDao topicVersesViewDao,
    required QueryExtUseCase queryExtUseCase
  }){
    _topicHadithsViewDao = topicHadithViewDao;
    _topicVersesViewDao = topicVersesViewDao;
    _queryExtUseCase = queryExtUseCase;
  }

  @override
  Stream<List<TopicViewModel>> getStreamTopicViewsByBookId(int bookId, SourceTypeEnum sourceType){
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return (_topicHadithsViewDao.getStreamTopicHadithsByBookId(bookId))
            .map((items) => items.map((e) => e.toTopicViewModel()).toList());
      case SourceTypeEnum.verse:
        return (_topicVersesViewDao.getStreamTopicVersesByBookId(bookId))
            .map((items) => items.map((e) => e.toTopicViewModel()).toList());
    }
  }

  @override
  Future<List<TopicViewModel>> getTopicViewsByBookId(int bookId, SourceTypeEnum sourceType) async{
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return (await _topicHadithsViewDao.getTopicHadithsByBookId(bookId))
            .map((e) => e.toTopicViewModel()).toList();
      case SourceTypeEnum.verse:
        return (await _topicVersesViewDao.getTopicVersesByBookId(bookId))
            .map((e) => e.toTopicViewModel()).toList();
    }
  }

  @override
  Stream<List<TopicViewModel>> getStreamTopicViewsByBookIdAndQuery(
      int bookId,
      String query,
      SourceTypeEnum sourceType
  ) {
    final queryRs = _queryExtUseCase.call(query);
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return (_topicHadithsViewDao.getStreamTopicHadithsByBookIdAndQuery(bookId,
            queryRs.queryLikeForSearch, queryRs.queryLikeForOrder, queryRs.queryRaw)
        ).map((items) => items.map((e) => e.toTopicViewModel()).toList());
      case SourceTypeEnum.verse:
        return (_topicVersesViewDao.getStreamTopicVersesByBookIdAndQuery(bookId,
            queryRs.queryLikeForSearch, queryRs.queryLikeForOrder, queryRs.queryRaw)
        ).map((items) => items.map((e) => e.toTopicViewModel()).toList());
    }
  }

  @override
  Stream<List<TopicViewModel>> getStreamTopicViewsBySectionId(int sectionId, SourceTypeEnum sourceType) {
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return (_topicHadithsViewDao.getStreamTopicHadithsBySectionId(sectionId))
            .map((items) => items.map((e) => e.toTopicViewModel()).toList());
      case SourceTypeEnum.verse:
        return (_topicVersesViewDao.getStreamTopicVersesBySectionId(sectionId))
            .map((items) => items.map((e) => e.toTopicViewModel()).toList());
    }
  }

  @override
  Future<List<TopicViewModel>> getTopicViewsBySectionId(int sectionId, SourceTypeEnum sourceType) async{
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return (await _topicHadithsViewDao.getTopicHadithsBySectionId(sectionId))
            .map((e) => e.toTopicViewModel()).toList();
      case SourceTypeEnum.verse:
        return (await _topicVersesViewDao.getTopicVersesBySectionId(sectionId))
            .map((e) => e.toTopicViewModel()).toList();
    }
  }

  @override
  Stream<List<TopicViewModel>> getStreamTopicViewsBySectionIdAndQuery(
      int sectionId,
      String query,
      SourceTypeEnum sourceType
  ) {
    final queryRs = _queryExtUseCase.call(query);
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return (_topicHadithsViewDao.getStreamTopicHadithsBySectionIdAndQuery(sectionId,
            queryRs.queryLikeForSearch, queryRs.queryLikeForOrder, queryRs.queryRaw)
        ).map((items) => items.map((e) => e.toTopicViewModel()).toList());
      case SourceTypeEnum.verse:
        return (_topicVersesViewDao.getStreamTopicVersesBySectionIdAndQuery(sectionId,
            queryRs.queryLikeForSearch, queryRs.queryLikeForOrder, queryRs.queryRaw)
        ).map((items) => items.map((e) => e.toTopicViewModel()).toList());
    }
  }

}