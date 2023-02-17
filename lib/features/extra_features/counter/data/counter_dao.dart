

import 'package:floor/floor.dart';

import 'entity/counter_entity.dart';

@dao
abstract class CounterDao{

  @Query("""select * from counters where isRemovable = 1 order by orderItem desc""")
  Stream<List<CounterEntity>> getStreamRemovableCounters();

  @Query("""select * from counters where isRemovable = 0 order by orderItem asc""")
  Future<List<CounterEntity>> getNonRemovableCounters();

  @Query("""select * from counters where id=:id""")
  Future<CounterEntity?> getCounterById(int id);

  @Query("""select * from counters where id=:id""")
  Stream<CounterEntity?> getStreamCounterById(int id);

  @Query("""select max(orderItem) from counters""")
  Future<int?> getMaxOrder();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertCounterEntity(CounterEntity counterEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCounterEntity(CounterEntity counterEntity);

  @delete
  Future<void> deleteCounterEntity(CounterEntity counterEntity);

}