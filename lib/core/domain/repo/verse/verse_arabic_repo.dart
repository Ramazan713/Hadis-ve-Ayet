

import 'package:hadith/core/domain/models/verse/verse_arabic.dart';

abstract class VerseArabicRepo{

  Future<List<VerseArabic>> getArabicVersesByMealId(int mealId);
}