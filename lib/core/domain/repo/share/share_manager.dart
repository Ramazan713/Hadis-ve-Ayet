

import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
abstract class ShareManager{

  Future<String> getHadithSharedTextWithList(int listId);

  Future<List<Hadith>> getHadithsWithList(int listId);

  Future<String> getVerseSharedTextWithList(int listId);

  Future<List<Verse>> getVersesWithList(int listId);
}