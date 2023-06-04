

import 'package:hadith/core/domain/models/list/list_view_model.dart';

abstract class ListHadithViewRepo{

  Stream<List<ListViewModel>> getStreamListHadithViewsByIsArchive(bool isArchive);

  Stream<List<ListViewModel>> getStreamRemovableListHadithViews();

  Stream<List<ListViewModel>> getStreamRemovableListHadithViewsByIsArchive(bool isArchive);

  Stream<List<ListViewModel>> getStreamListHadithByQueryAndIsArchive(String query, bool isArchive);

}