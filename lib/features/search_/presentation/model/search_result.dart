

import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

class SearchResult{
  final String title;
  final int resultCount;
  final BookScopeEnum bookScope;

  SearchResult({required this.title, required this.resultCount, required this.bookScope});
}