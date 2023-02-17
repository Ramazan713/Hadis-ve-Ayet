

import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

class CounterDetailParam{
  final CounterType type;
  final Counter? counter;

  CounterDetailParam({required this.type,this.counter});

  static CounterDetailParam defaultParam(){
    return CounterDetailParam(
      type: CounterType.classic
    );
  }
}