

import 'package:hadith/core/domain/enums/paging/paging_title_enum.dart';

abstract class TitleRepo{

  Future<String> getTitle(int itemId, PagingTitleEnum titleEnum);
}