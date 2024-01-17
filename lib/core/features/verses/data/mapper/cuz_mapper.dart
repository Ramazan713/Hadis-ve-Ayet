

import 'package:hadith/core/data/local/entities/cuz_entity.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';

extension CuzEntityExt on CuzEntity{
  Cuz toCuz(){
    return Cuz(no: cuzNo, name: name);
  }
}