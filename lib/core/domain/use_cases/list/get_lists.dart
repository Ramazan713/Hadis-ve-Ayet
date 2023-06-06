

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_view_repo.dart';
import 'package:rxdart/rxdart.dart';

class GetLists {
  late final ListHadithViewRepo _listHadithViewRepo;
  late final ListVerseViewRepo _listVerseViewRepo;
  GetLists({required ListHadithViewRepo listHadithViewRepo, required ListVerseViewRepo listVerseViewRepo}){
    _listHadithViewRepo = listHadithViewRepo;
    _listVerseViewRepo = listVerseViewRepo;
  }

  Stream<List<ListViewModel>> call(SourceTypeEnum sourceType, bool isArchive){
    final Stream<List<ListViewModel>> streamData;
    switch(sourceType){
      case SourceTypeEnum.hadith:
        streamData = _listHadithViewRepo.getStreamListHadithViewsByIsArchive(isArchive);
        break;
      case SourceTypeEnum.verse:
        streamData = _listVerseViewRepo.getStreamListVerseViewByIsArchive(isArchive);
        break;
    }
    return streamData;
  }

  Stream<List<ListViewModel>> callRemovableWithArchive(bool isArchive){
    final hadithStream = _listHadithViewRepo.getStreamRemovableListHadithViewsByIsArchive(isArchive);
    final verseStream = _listVerseViewRepo.getStreamRemovableListVerseViewByIsArchive(isArchive);

    return Rx.combineLatest2(hadithStream, verseStream, (a, b){
      final items = <ListViewModel>[];
      items.addAll(a);
      items.addAll(b);

      items.sort((a,b){
        return a.listPos.compareTo(b.listPos);
      });
      return items;
    });
  }

}