

enum DownloadedAudioViewEnum{
  cuz,
  surah;

  String get description{
    switch(this){
      case DownloadedAudioViewEnum.surah:
        return "Sure";
      case DownloadedAudioViewEnum.cuz:
        return "Cuz";
    }
  }
}