

import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';

abstract class CounterRepo{

  Stream<List<Counter>> getStreamCounters();

  Future<List<Counter>> getCounters();

  Future<int> insertCounter(Counter counter);

  Future<void> updateCounter(Counter counter);

  Future<void> deleteCounter(Counter counter);

  Future<Counter?> getCounterById(int id);

  Stream<Counter?> getStreamCounterById(int id);
}