
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

abstract class ICounterDetailEvent{}

class CounterDetailEventInit extends ICounterDetailEvent{}

class CounterDetailEventIncrease extends ICounterDetailEvent{}

class CounterDetailEventReset extends ICounterDetailEvent{}

class CounterDetailEventStartListenCounter extends ICounterDetailEvent{
  final Counter counter;
  CounterDetailEventStartListenCounter({required this.counter});
}


class CounterDetailEventSetInit extends ICounterDetailEvent{
  final Counter? counter;
  final CounterType counterType;
  CounterDetailEventSetInit({required this.counter,required this.counterType});
}

class CounterDetailEventSetCounterUi extends ICounterDetailEvent{
  final ArabicVerseUI3X counterUi;
  CounterDetailEventSetCounterUi({required this.counterUi});
}

class CounterDetailEventAddCounter extends ICounterDetailEvent{
  CounterDetailEventAddCounter();
}
