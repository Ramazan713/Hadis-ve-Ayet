

class ExtractCounterInfoUseCase{

  operator(int counterValue,{int base = 99}){

    int counterBase = (counterValue % (base));
    counterBase = counterBase == 0 && counterValue!=0 ? base : counterBase;
    final int subCounterBase = counterValue ~/ (base);
    return CounterInfo(counter: counterValue,
        subCounterBase: subCounterBase,
        counterBase: counterBase);
  }
}

class CounterInfo{
  final int counterBase;
  final int subCounterBase;
  final int counter;
  CounterInfo({required this.counter,required this.subCounterBase,required this.counterBase});
}
