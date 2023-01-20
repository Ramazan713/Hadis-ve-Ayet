

enum AudioQualityEnum{
  q64,q128
}

extension AudioQualityExtension on AudioQualityEnum{
  int get quality{
    switch(this){
      case AudioQualityEnum.q64:
        return 64;
      case AudioQualityEnum.q128:
        return 128;
    }
  }
}