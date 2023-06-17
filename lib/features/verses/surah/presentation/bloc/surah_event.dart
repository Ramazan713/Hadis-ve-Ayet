

import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/scroll_direction.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';

abstract class ISurahEvent{}

class SurahEventLoadData extends ISurahEvent{}

class SurahEventSetSearchBarVisibility extends ISurahEvent{
  final bool isSearchBarVisible;
  SurahEventSetSearchBarVisibility({required this.isSearchBarVisible});
}

class SurahEventSearch extends ISurahEvent{
  final String query;
  SurahEventSearch({required this.query});
}