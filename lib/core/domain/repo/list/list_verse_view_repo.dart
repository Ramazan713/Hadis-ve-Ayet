import 'package:hadith/core/domain/models/list/list_view_model.dart';

abstract class ListVerseViewRepo{

  Stream<List<ListViewModel>> getStreamListVerseViewByIsArchive(bool isArchive);

  Stream<List<ListViewModel>> getStreamListVersesViewByQueryAndIsArchive(String query, bool isArchive);
}