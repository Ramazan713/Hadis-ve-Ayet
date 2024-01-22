import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/selectable_list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_view_repo.dart';
import 'package:rxdart/rxdart.dart';

class GetSelectableListView{
  late final ListHadithViewRepo _listHadithViewRepo;
  late final ListHadithRepo _listHadithRepo;
  late final ListVerseViewRepo _listVerseViewRepo;
  late final ListVerseRepo _listVerseRepo;

  GetSelectableListView({
    required ListHadithViewRepo listHadithViewRepo,
    required ListHadithRepo listHadithRepo,
    required ListVerseViewRepo listVerseViewRepo,
    required ListVerseRepo listVerseRepo
  }){
    _listHadithViewRepo = listHadithViewRepo;
    _listHadithRepo = listHadithRepo;

    _listVerseViewRepo = listVerseViewRepo;
    _listVerseRepo = listVerseRepo;
  }


  Stream<List<SelectableListViewModel>> call({
    bool includeArchiveLists = false,
    required int itemId,
    required SourceTypeEnum sourceType
  }){
    switch(sourceType){
      case SourceTypeEnum.hadith:
        return _getHadiths(itemId, includeArchiveLists);
      case SourceTypeEnum.verse:
        return _getVerses(itemId, includeArchiveLists);
    }
  }

  Stream<List<SelectableListViewModel>> _getHadiths(int hadithId,bool includeArchiveLists){
    final streamList = includeArchiveLists ?
        _listHadithViewRepo.getStreamRemovableListHadithViews() :
        _listHadithViewRepo.getStreamRemovableListHadithViewsByIsArchive(false);

    return streamList.asyncMap((listViews)async{
      final selectedListIds = await _listHadithRepo.getListIdsFromHadithId(hadithId);
      return listViews.map((listView){
        return SelectableListViewModel(
            listViewModel: listView,
            isSelected: selectedListIds.contains(listView.id)
        );
      }).toList();
    }).asBroadcastStream();
  }


  Stream<List<SelectableListViewModel>> _getVerses(int verseId,bool includeArchiveLists){
    final streamList = includeArchiveLists ?
        _listVerseViewRepo.getStreamRemovableListVerseView() :
        _listVerseViewRepo.getStreamRemovableListVerseViewByIsArchive(false);


    return streamList.asyncMap((listViews)async{
      final selectedListIds = await _listVerseRepo.getListIdsFromVerseId(verseId);
      return listViews.map((listView){
        return SelectableListViewModel(
            listViewModel: listView,
            isSelected: selectedListIds.contains(listView.id)
        );
      }).toList();
    }).asBroadcastStream();
  }


}