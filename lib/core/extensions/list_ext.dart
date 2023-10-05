
extension ListExt<T> on List<T>{

  T? getOrNull(int index){
    if(index >= length) return null;
    return this[index];
  }

}