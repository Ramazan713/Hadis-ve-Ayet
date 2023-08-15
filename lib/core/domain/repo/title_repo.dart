

import 'package:hadith/core/domain/enums/paging_title_enum.dart';

abstract class TitleRepo{

  Future<String> getTitle(int itemId, TitleEnum titleEnum);
}