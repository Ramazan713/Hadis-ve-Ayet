

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/esmaul_husna/data/entity/esmaul_husna_entity.dart';

@dao
abstract class EsmaulHusnaDao{

  @Query("select * from esmaulHusna")
  Future<List<EsmaulHusnaEntity>>getAllEsmaulHusna();

  @Query("select * from esmaulHusna where id=:id")
  Future<EsmaulHusnaEntity?>getEsmaulHusnaWithId(int id);

}