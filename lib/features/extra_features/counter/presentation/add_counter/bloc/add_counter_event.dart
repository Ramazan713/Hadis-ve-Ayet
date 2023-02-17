
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

abstract class IAddCounterEvent{}

class AddCounterEventInit extends IAddCounterEvent{}

class AddCounterEventAddCounter extends IAddCounterEvent{
  final Counter counter;
  AddCounterEventAddCounter({required this.counter});
}

