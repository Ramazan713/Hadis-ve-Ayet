

enum ScrollDelayType{
  throttle, debouncer,both;


  bool isThrottle() => [ScrollDelayType.throttle, ScrollDelayType.both].contains(this);

  bool isDebouncer() => [ScrollDelayType.debouncer, ScrollDelayType.both].contains(this);

}