

enum LocalDestinationScope{
  wide,restrict
}

extension LocalDestinationScopeExt on LocalDestinationScope{
  String getDescription(){
    switch(this){
      case LocalDestinationScope.wide:
        return "Hepsi";
      case LocalDestinationScope.restrict:
        return "Geçerli Alan";
    }
  }
}