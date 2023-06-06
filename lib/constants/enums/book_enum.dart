
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

enum BookEnum{
  serlevha(
    bookId: 1,
    bookScope: BookScopeEnum.serlevha,
    title: "Serlevha"
  ),
  sitte(
    bookId: 2,
    bookScope: BookScopeEnum.sitte,
    title: "Kütübi Sitte"
  ),
  diyanetMeal(
    bookId: 3,
    bookScope: BookScopeEnum.diyanetMeal,
    title: "Kur'an"
  );

  const BookEnum({required this.bookId, required this.bookScope, required this.title});

  final int bookId;
  final BookScopeEnum bookScope;
  final String title;


  SourceTypeEnum get sourceType{
    return bookScope.sourceType;
  }

  static BookEnum from(int bookId) {
    if (bookId == BookEnum.serlevha.bookId) {
      return BookEnum.serlevha;
    }
    if (bookId == BookEnum.sitte.bookId) {
      return BookEnum.sitte;
    }
    if (bookId == BookEnum.diyanetMeal.bookId) {
      return BookEnum.diyanetMeal;
    }
    return BookEnum.serlevha;
  }
}