


import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_view_repo.dart';

class SearchLists {
  late final ListHadithViewRepo _listHadithViewRepo;
  late final ListVerseViewRepo _listVerseViewRepo;
  SearchLists({required ListHadithViewRepo listHadithViewRepo, required ListVerseViewRepo listVerseViewRepo}){
    _listHadithViewRepo = listHadithViewRepo;
    _listVerseViewRepo = listVerseViewRepo;
  }

  Stream<List<ListViewModel>> call(String query,SourceTypeEnum sourceType, bool isArchive){
    final Stream<List<ListViewModel>> streamData;
    switch(sourceType){
      case SourceTypeEnum.hadith:
        streamData = _listHadithViewRepo.getStreamListHadithByQueryAndIsArchive(query,isArchive);
        break;
      case SourceTypeEnum.verse:
        streamData = _listVerseViewRepo.getStreamListVersesViewByQueryAndIsArchive(query,isArchive);
        break;
    }
    return streamData;
  }

}