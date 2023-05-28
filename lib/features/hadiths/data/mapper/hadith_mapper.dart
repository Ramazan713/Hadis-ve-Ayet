

import 'package:hadith/core/data/local/entities/hadith_entity.dart';
import 'package:hadith/features/hadiths/domain/models/hadith.dart';


extension HadithEntityExt on HadithEntity{

  Hadith toHadith(){
    return Hadith(
      id: id,
      bookId: bookId,
      content: content,
      contentSize: contentSize,
      source: source
    );
  }
}