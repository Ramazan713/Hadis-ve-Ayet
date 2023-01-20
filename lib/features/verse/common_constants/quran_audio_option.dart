

enum QuranAudioOption{
  cuz,surah,page,verse
}

extension QuranAudioOptionExtension on QuranAudioOption{
  String get description{
    switch(this){
      case QuranAudioOption.cuz:
        return "Cüz";
      case QuranAudioOption.surah:
        return "Sure";
      case QuranAudioOption.page:
        return "Sayfa";
      case QuranAudioOption.verse:
        return "Ayet";
    }
  }
}