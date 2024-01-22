
import 'package:hadith/core/features/get_title/domain/enums/title_enum.dart';

abstract class TitleRepo{

  Future<String> getTitle(int itemId, TitleEnum titleEnum);
}