

import 'package:hadith/core/data/local/entities/surah_entity.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

extension SurahEntityExt on SurahEntity{
  Surah toSurah(){
    return Surah(
      id: id,
      name: name,
      searchName: searchName
    );
  }
}