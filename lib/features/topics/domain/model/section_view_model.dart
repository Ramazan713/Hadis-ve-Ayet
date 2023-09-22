

import 'package:hadith/core/domain/enums/book_enum.dart';

class SectionViewModel{
  final int id;
  final String name;
  final int topicsCount;
  final BookEnum book;

  SectionViewModel({required this.id, required this.name,
    required this.topicsCount, required this.book
  });
}

