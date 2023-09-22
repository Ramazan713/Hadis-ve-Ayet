
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/cuz_entity.dart';

@dao
abstract class CuzDao{

  @Query("select * from cuz")
  Future<List<CuzEntity>>getAllCuz();

  @Query("""select * from Cuz where cuzNo=:cuzNo""")
  Future<CuzEntity?>getCuz(int cuzNo);

}