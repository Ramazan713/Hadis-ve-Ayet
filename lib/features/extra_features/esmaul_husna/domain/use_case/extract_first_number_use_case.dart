
class ExtractFirstNumberUseCase{


  int? operator(String item,{String delimeter="-"}){
    final itemSplit = item.split(delimeter);
    int? result;
    if(itemSplit.isNotEmpty){
      result = int.tryParse(itemSplit[0].replaceAll(".", ""));
    }
    return result;
  }

}