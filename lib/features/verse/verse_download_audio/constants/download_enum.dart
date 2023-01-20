

enum DownloadEnum{
  downloading,pause,success,idle,error,retry
}


extension DownloadEnumExtension on DownloadEnum{
  String get description{
    switch(this){
      case DownloadEnum.downloading:
       return "indiriliyor";
      case DownloadEnum.pause:
        return "durduruldu";
      case DownloadEnum.success:
        return "başarılı";
      case DownloadEnum.idle:
        return "boşta";
      case DownloadEnum.error:
        return "hata";
      case DownloadEnum.retry:
        return "tekrar dene";
    }
  }
}
