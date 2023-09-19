

import 'package:hadith/core/data/local/entities/surah_entity.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

extension SurahEntityExt on SurahEntity{
  Surah toSurah(){
    return Surah(
      id: id,
      name: name,
      searchName: searchName
    );
  }
}