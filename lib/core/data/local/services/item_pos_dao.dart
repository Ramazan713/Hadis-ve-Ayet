
import 'package:floor/floor.dart';

@dao
abstract class ItemPositionDao{

  @Query("""
    select count(*) from verse where surahId = :surahId and id < :mealId
  """)
  Future<int?> getSurahPos(int surahId, int mealId);

}