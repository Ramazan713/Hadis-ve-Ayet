

import 'package:floor/floor.dart';

import 'entity/counter_entity.dart';

@dao
abstract class CounterDaoOld{

  @Query("""select * from counters where isRemovable = 1 order by orderItem desc""")
  Stream<List<CounterEntityOld>> getStreamRemovableCounters();

  @Query("""select * from counters where isRemovable = 0 order by orderItem asc""")
  Future<List<CounterEntityOld>> getNonRemovableCounters();

  @Query("""select * from counters where id=:id""")
  Future<CounterEntityOld?> getCounterById(int id);

  @Query("""select * from counters where id=:id""")
  Stream<CounterEntityOld?> getStreamCounterById(int id);

  @Query("""select max(orderItem) from counters""")
  Future<int?> getMaxOrder();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertCounterEntity(CounterEntityOld counterEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCounterEntity(CounterEntityOld counterEntity);

  @delete
  Future<void> deleteCounterEntity(CounterEntityOld counterEntity);

}