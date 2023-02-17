

abstract class ICounterSettingEvent{}

class CounterSettingEventSetInit extends ICounterSettingEvent{}

class CounterSettingEventSetEndOfVibration extends ICounterSettingEvent{
  final bool endOfVibration;
  CounterSettingEventSetEndOfVibration({required this.endOfVibration});
}

class CounterSettingEventSetEachDhikrVibration extends ICounterSettingEvent{
  final bool eachDhikrVibration;
  CounterSettingEventSetEachDhikrVibration({required this.eachDhikrVibration});
}

