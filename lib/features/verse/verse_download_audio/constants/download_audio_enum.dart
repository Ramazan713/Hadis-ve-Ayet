

enum DownloadAudioEnum{
  allBook,cuz,surah,verse,page
}

extension AudioEnumExtension on DownloadAudioEnum{
  String get description{
    switch(this){
      case DownloadAudioEnum.cuz:
        return "Cüz seslerini indir";
      case DownloadAudioEnum.surah:
        return "Sure seslerini indir";
      case DownloadAudioEnum.verse:
        return "Ayet sesini indir";
      case DownloadAudioEnum.page:
        return "Sayfa seslerini indir";
      case DownloadAudioEnum.allBook:
        return "Tüm kitabı indir";
    }
  }
}