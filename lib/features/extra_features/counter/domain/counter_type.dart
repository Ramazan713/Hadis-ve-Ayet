enum CounterType { classic, unlimited }

extension CounterTypeExt on CounterType {
  static CounterType fromInt(int type) {
    switch (type) {
      case 1:
        return CounterType.classic;
      case 2:
        return CounterType.unlimited;
      default:
        return CounterType.classic;
    }
  }

  String get description{
    switch (this) {
      case CounterType.classic:
        return "Klasik (99 lu)";
      case CounterType.unlimited:
        return "Sınırsız";
    }
  }

  int get type {
    switch (this) {
      case CounterType.classic:
        return 1;
      case CounterType.unlimited:
        return 2;
    }
  }
}
