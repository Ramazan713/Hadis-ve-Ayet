

import 'package:flutter/material.dart';

enum CounterSelectMenuEnum{
  edit,remove
}

extension CounterSelectMenuExt on CounterSelectMenuEnum{
  String get label{
    switch(this){
      case CounterSelectMenuEnum.edit:
        return "Düzenle";
      case CounterSelectMenuEnum.remove:
        return "Sil";
    }
  }

  IconData get iconData{
    switch(this){
      case CounterSelectMenuEnum.edit:
        return Icons.edit;
      case CounterSelectMenuEnum.remove:
        return Icons.delete_forever;
    }
  }

}