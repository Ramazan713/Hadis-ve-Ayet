

enum CounterType {
  classic(
    typeId: 1,
    title: "Klasik (99 lu)"
  ),
  unlimited(
    typeId: 2,
    title: "Sınırsız"
  );

  const CounterType({
    required this.typeId,
    required this.title
  });

  final int typeId;
  final String title;


  static CounterType from(int typeId){
    if(CounterType.unlimited.typeId == typeId){
      return CounterType.unlimited;
    }
    return CounterType.classic;
  }
}
