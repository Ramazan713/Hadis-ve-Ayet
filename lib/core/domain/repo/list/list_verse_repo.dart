

import 'package:hadith/core/domain/models/list/list_verse.dart';

abstract class ListVerseRepo{

  Future<int> insertListVerse(ListVerse listVerse);

  Future<List<int>> insertListVerses(List<ListVerse> listVerses);

  Future<int> updateListVerse(ListVerse listVerse);

  Future<int> deleteListVerse(ListVerse listVerse);

  Future<int> deleteListVerses(List<ListVerse> listVerses);

  Future<List<ListVerse>> getListVersesWithListId(int listId);

  Future<ListVerse?> getListVerse(int verseId, int listId);

  Future<int> getMaxPos();

  Future<List<int>> getListIdsFromVerseId(int verseId);
}