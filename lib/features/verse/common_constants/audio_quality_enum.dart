

enum AudioQualityEnum{
  q32,q48,q64,q128,q192
}

extension AudioQualityExt on AudioQualityEnum{
  int get quality{
    switch(this){
      case AudioQualityEnum.q32:
        return 32;
      case AudioQualityEnum.q48:
        return 48;
      case AudioQualityEnum.q64:
        return 64;
      case AudioQualityEnum.q128:
        return 128;
      case AudioQualityEnum.q192:
        return 192;
    }
  }

  static AudioQualityEnum fromQuality(int quality){
    switch(quality){
      case 32:
        return AudioQualityEnum.q32;
      case 48:
        return AudioQualityEnum.q48;
      case 64:
        return AudioQualityEnum.q64;
      case 128:
        return AudioQualityEnum.q128;
      case 192:
        return AudioQualityEnum.q192;
    }
    return AudioQualityEnum.q64;
  }

}