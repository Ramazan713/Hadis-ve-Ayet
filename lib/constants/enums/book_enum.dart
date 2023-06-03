
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

enum BookEnum{
  none(
    bookId: 0,
    bookScope: null
  ),
  serlevha(
    bookId: 1,
    bookScope: BookScopeEnum.serlevha
  ),
  sitte(
    bookId: 2,
    bookScope: BookScopeEnum.sitte
  ),
  diyanetMeal(
    bookId: 3,
    bookScope: BookScopeEnum.diyanetMeal
  );

  const BookEnum({required this.bookId, required this.bookScope});

  final int bookId;
  final BookScopeEnum? bookScope;


  static BookEnum from(int bookId) {
    if (bookId == BookEnum.none.bookId) {
      return BookEnum.none;
    }
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