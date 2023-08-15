
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

abstract class IAddCounterEventOld{}

class AddCounterEventInit extends IAddCounterEventOld{}

class AddCounterEventAddCounter extends IAddCounterEventOld{
  final Counter counter;
  AddCounterEventAddCounter({required this.counter});
}

