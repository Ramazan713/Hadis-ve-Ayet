

import 'package:floor/floor.dart';

import '../../views/verse_info_list_view.dart';

@dao
abstract class VerseInfoListDao{

  @Query("""
      select * from verseInfoListView where verseId = :verseId
  """)
  Future<VerseInfoListView?> getVerseInfoList(int verseId);
}