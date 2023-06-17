

enum FontSize{
  small,medium,aLittleLarge,large,veryLarge
}

extension FontSizeExtension on FontSize{
  double get fontValue{
    switch(this){
      case FontSize.small:
        return -3;
      case FontSize.medium:
        return 0;
      case FontSize.aLittleLarge:
        return 3;
      case FontSize.large:
        return 7;
      case FontSize.veryLarge:
        return 13;
    }
  }

  String get shortName{
    switch(this){
      case FontSize.small:
        return "Küçük";
      case FontSize.medium:
        return "Orta";
      case FontSize.aLittleLarge:
        return "Biraz Büyük";
      case FontSize.large:
        return "Büyük";
      case FontSize.veryLarge:
        return "Çok Büyük";
    }
  }
}