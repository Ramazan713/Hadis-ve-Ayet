


import '../../domain/model/counter.dart';
import '../../domain/repo/counter_repo.dart';
import '../counter_dao.dart';

class CounterRepoImpl extends CounterRepoOld{
  late final CounterDaoOld _counterDao;

  CounterRepoImpl({required CounterDaoOld counterDao}){
    _counterDao = counterDao;
  }

  @override
  Future<void> deleteCounter(Counter counter) async{
    _counterDao.deleteCounterEntity(counter.toCounterEntity());
  }

  @override
  Stream<List<Counter>> getStreamRemovableCounters(){
    return _counterDao.getStreamRemovableCounters().map((items) => items.map((e) => e.toCounter()).toList());
  }

  @override
  Future<int> insertCounter(Counter counter) async{
    return _counterDao.insertCounterEntity(counter.toCounterEntity());
  }

  @override
  Future<void> updateCounter(Counter counter) async{
    _counterDao.updateCounterEntity(counter.toCounterEntity());
  }

  @override
  Future<int?> getMaxOrder() {
    return _counterDao.getMaxOrder();
  }

  @override
  Future<Counter?> getCounterById(int id) async{
    return (await _counterDao.getCounterById(id))?.toCounter();
  }

  @override
  Future<List<Counter>> getNonRemovableCounters() async{
    return (await _counterDao.getNonRemovableCounters()).map((item) => item.toCounter()).toList();
  }

  @override
  Stream<Counter?> getStreamCounterById(int id) {
      return _counterDao.getStreamCounterById(id).map((event) => event?.toCounter());
  }

}