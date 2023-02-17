

import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

abstract class CounterRepo{
  Stream<List<Counter>> getStreamRemovableCounters();
  Future<List<Counter>> getNonRemovableCounters();
  Future<int> insertCounter(Counter counter);
  Future<void> updateCounter(Counter counter);
  Future<void> deleteCounter(Counter counter);
  Future<Counter?> getCounterById(int id);
  Future<int?> getMaxOrder();
  Stream<Counter?> getStreamCounterById(int id);
}