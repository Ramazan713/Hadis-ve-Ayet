

abstract class ICounterSettingEvent{}

class CounterSettingEventLoadData extends ICounterSettingEvent{}

class CounterSettingEventSetEndOfVibration extends ICounterSettingEvent{
  final bool endOfVibration;
  CounterSettingEventSetEndOfVibration({required this.endOfVibration});
}

class CounterSettingEventSetEachDhikrVibration extends ICounterSettingEvent{
  final bool eachDhikrVibration;
  CounterSettingEventSetEachDhikrVibration({required this.eachDhikrVibration});
}

