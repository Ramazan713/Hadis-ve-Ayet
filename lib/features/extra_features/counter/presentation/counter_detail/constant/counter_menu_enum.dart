
import 'package:flutter/material.dart';

enum CounterMenuEnum{
  reset,save,selectFontSize,edit,setting
}

extension CounterMenuExt on CounterMenuEnum{
  String get label{
    switch(this){
      case CounterMenuEnum.reset:
        return "Sıfırla";
      case CounterMenuEnum.save:
        return "Zikri Ekle";
      case CounterMenuEnum.selectFontSize:
        return "Yazı Boyutu";
      case CounterMenuEnum.setting:
        return "Ayarlar";
      case CounterMenuEnum.edit:
        return "Düzenle";
    }
  }

  IconData get iconData{
    switch(this){
      case CounterMenuEnum.reset:
        return Icons.refresh;
      case CounterMenuEnum.save:
        return Icons.add;
      case CounterMenuEnum.selectFontSize:
        return Icons.text_format;
      case CounterMenuEnum.setting:
        return Icons.settings;
      case CounterMenuEnum.edit:
        return Icons.edit;
    }
  }

}