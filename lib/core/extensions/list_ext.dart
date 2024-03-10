
extension ListExt<T> on List<T>{

  T? getOrNull(int index){
    if(index >= length) return null;
    return this[index];
  }

  List<T> addOrNot(T? item){
    if(item == null) return this;
    add(item);
    return this;
  }

  List<T> fromFilteredItems(List<T?> items){
    for (final element in items) {
      if(element == null) continue;
      add(element);
    }
    return this;
  }

  bool allIsNotNull(){
    return every((element) => element != null);
  }


}