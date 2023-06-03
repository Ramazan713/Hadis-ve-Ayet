

import 'package:hadith/constants/enums/book_enum.dart';

abstract class ISectionEvent{}

class SectionEventLoadData extends ISectionEvent{
  final BookEnum book;
  SectionEventLoadData({required this.book});
}

class SectionEventSetSearchBarVisibility extends ISectionEvent{
  final bool isSearchBarVisible;
  SectionEventSetSearchBarVisibility({required this.isSearchBarVisible});
}

class SectionEventSearch extends ISectionEvent{
  final String query;
  SectionEventSearch({required this.query});
}