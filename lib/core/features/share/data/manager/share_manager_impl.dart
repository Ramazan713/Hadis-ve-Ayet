

import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/repo/hadith_repo.dart';
import 'package:hadith/core/domain/repo/verse/verse_repo.dart';
import 'package:hadith/core/features/share/domain/manager/share_manager.dart';

class ShareManagerImpl extends ShareManager{
  late final HadithRepo _hadithRepo;
  late final VerseRepo _verseRepo;

  ShareManagerImpl({
    required HadithRepo hadithRepo,
    required VerseRepo verseRepo
  }){
    _hadithRepo = hadithRepo;
    _verseRepo = verseRepo;
  }

  @override
  Future<String> getHadithSharedTextWithList(int listId) async{
    final items=await _hadithRepo.getHadithsFromListId(listId);
    var text="";
    for(var item in items){
      text+="${item.content}\n\t- ${item.source}\n\n\n";
    }
    return text;
  }

  @override
  Future<String> getVerseSharedTextWithList(int listId) async{
    final items=await _verseRepo.getVersesByListId(listId);
    var text="";
    for(var item in items){
      text+="""${item.surahId}/${item.surahName}\n${item.verseNumber} - ${item.content}\n\n\n""";
    }
    return text;
  }

  @override
  Future<List<Hadith>> getHadithsWithList(int listId) async{
    return (await _hadithRepo.getHadithsFromListId(listId));
  }

  @override
  Future<List<Verse>> getVersesWithList(int listId) async{
    return await _verseRepo.getVersesByListId(listId);
  }

}