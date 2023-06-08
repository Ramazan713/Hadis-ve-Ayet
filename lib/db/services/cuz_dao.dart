
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/cuz.dart';


@dao
abstract class CuzDaoOld{

  @Query("select * from cuz")
  Future<List<Cuz>>getAllCuz();

  @Query("""select * from Cuz where cuzNo=:cuzNo""")
  Future<Cuz?>getCuz(int cuzNo);

}