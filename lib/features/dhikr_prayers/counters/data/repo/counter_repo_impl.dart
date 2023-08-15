

import 'package:hadith/core/data/local/services/counter_dao.dart';
import 'package:hadith/features/dhikr_prayers/counters/data/mapper/counter_mapper.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';

class CounterRepoImpl extends CounterRepo{
  late final CounterDao _counterDao;

  CounterRepoImpl({
    required CounterDao counterDao
  }){
    _counterDao = counterDao;
  }

  @override
  Future<List<Counter>> getCounters() async{
    return (await _counterDao.getCounters())
        .map((e) => e.toCounter()).toList();
  }

  @override
  Stream<List<Counter>> getStreamCounters() {
    return _counterDao.getStreamCounters()
        .map((items) => items.map((e) => e.toCounter()).toList());
  }

  @override
  Future<int> insertCounter(Counter counter) async{
    final pos = await _counterDao.getMaxOrder();
    final counterEntity = counter.copyWith(order: (pos ?? 0) + 1).toCounterEntity();
    return _counterDao.insertCounterEntity(counterEntity);
  }

  @override
  Future<void> updateCounter(Counter counter) async{
    _counterDao.updateCounterEntity(counter.toCounterEntity());
  }

  @override
  Future<Counter?> getCounterById(int id) async{
    return (await _counterDao.getCounterById(id))?.toCounter();
  }

  @override
  Stream<Counter?> getStreamCounterById(int id) {
      return _counterDao.getStreamCounterById(id).map((event) => event?.toCounter());
  }

  @override
  Future<void> deleteCounter(Counter counter) async{
    _counterDao.deleteCounterEntity(counter.toCounterEntity());
  }
}