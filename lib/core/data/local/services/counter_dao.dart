

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/counter_entity.dart';

@dao
abstract class CounterDao{

  @Query("""select * from counters order by orderItem desc""")
  Stream<List<CounterEntity>> getStreamCounters();

  @Query("""select * from counters order by orderItem desc""")
  Future<List<CounterEntity>> getCounters();

  @Query("""select * from counters where id=:id""")
  Future<CounterEntity?> getCounterById(int id);

  @Query("""select * from counters where id=:id""")
  Stream<CounterEntity?> getStreamCounterById(int id);

  @Query("""select ifnull(max(orderItem),0) from counters""")
  Future<int?> getMaxOrder();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertCounterEntity(CounterEntity counterEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCounterEntity(CounterEntity counterEntity);

  @delete
  Future<void> deleteCounterEntity(CounterEntity counterEntity);

}