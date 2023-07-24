
enum DownloadEnum{
  downloading,
  pause,
  successStep,
  idle,
  error,
  retry,
  successAll;

  bool get isAvailable => [DownloadEnum.idle, DownloadEnum.successAll].contains(this);

  bool get isActiveRunning => [
    DownloadEnum.downloading, DownloadEnum.error, DownloadEnum.successStep, DownloadEnum.retry, DownloadEnum.pause,
  ].contains(this);

  bool get isDownloading => this == DownloadEnum.downloading;
  bool get isPausing => this == DownloadEnum.pause;
  bool get isRetry => this == DownloadEnum.retry;
  bool get isSuccessAll => this == DownloadEnum.successAll;
  bool get isSuccessStep => this == DownloadEnum.successStep;
  bool get isAnySuccess => isSuccessAll || isSuccessStep;
}


extension DownloadEnumExtension on DownloadEnum{
  String get description{
    switch(this){
      case DownloadEnum.downloading:
        return "indiriliyor";
      case DownloadEnum.pause:
        return "durduruldu";
      case DownloadEnum.successStep:
        return "başarılı item";
      case DownloadEnum.idle:
        return "boşta";
      case DownloadEnum.error:
        return "hata";
      case DownloadEnum.retry:
        return "tekrar dene";
      case DownloadEnum.successAll:
        return "başarılı";
    }
  }
}
