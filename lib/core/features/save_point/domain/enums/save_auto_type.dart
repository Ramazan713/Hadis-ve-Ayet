

enum SaveAutoType{
  none,general,audio
}


extension SaveAutoTypeExt on SaveAutoType{
  String get label{
    switch(this){
      case SaveAutoType.none:
        return "";
      case SaveAutoType.general:
        return "Auto";
      case SaveAutoType.audio:
        return "Auto audio";
    }
  }

  static SaveAutoType fromIndex(int index){
    switch(index){
      case 0:
        return SaveAutoType.none;
      case 1:
        return SaveAutoType.general;
      case 2:
        return SaveAutoType.audio;
      default:
        return SaveAutoType.none;
    }
  }

}
