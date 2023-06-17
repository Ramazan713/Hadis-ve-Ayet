

import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
abstract class ShareManager{

  String getHadithSharedText(Hadith hadith);

  Future<String> getHadithSharedTextWithList(int listId);

  Future<List<Hadith>> getHadithsWithList(int listId);


  String getVerseSharedText(Verse verse);

  Future<String> getVerseSharedTextWithList(int listId);

  Future<List<Verse>> getVersesWithList(int listId);
}