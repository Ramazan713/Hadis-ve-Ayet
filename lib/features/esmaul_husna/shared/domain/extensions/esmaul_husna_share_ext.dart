

import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';

extension EsmaulHusnaShareExt on EsmaulHusna{

  String getShareShort(){
    var buffer = StringBuffer();
    buffer.write("$order $name\n");
    buffer.write("$arabicName\n");
    buffer.write(meaning);
    return buffer.toString();
  }

  String getShareLong(){
    var buffer = StringBuffer();
    buffer.write("$order $name\n");
    buffer.write("$arabicName\n");

    buffer.write("Açıklaması:\n");
    buffer.write("$meaning\n\n");

    buffer.write("Zikir:\n");
    buffer.write("$virtue ($dhikr adet)");
    return buffer.toString();
  }
}