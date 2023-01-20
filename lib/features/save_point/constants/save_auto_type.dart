

enum SaveAutoType{
  none,general,audio
}


extension AutoTypeExtension on SaveAutoType{
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
}
