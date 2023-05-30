

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/hadith_entity.dart';

@dao
abstract class HadithAllDao{

  @Query("select count(*) from hadith where bookId = :bookId")
  Future<int?> getHadithCountByBookId(int bookId);

  @Query("select * from hadith where bookId = :bookId limit :pageSize offset :startIndex")
  Future<List<HadithEntity>> getPagingHadithsByBookId(int bookId, int pageSize, int startIndex);


  @Query("select * from hadith where id=:id")
  Future<HadithEntity?> getHadithById(int id);

  @Query("""
    select count(*) from hadith where id<:id
  """)
  Future<int?> getPosById(int id);


  @Query("""select H.* from Hadith H,ListHadith LH
     where LH.hadithId=H.id and LH.listId=:listId order by
      LH.pos desc
     """)
  Future<List<HadithEntity>> getHadithsFromListId(int listId);


}
