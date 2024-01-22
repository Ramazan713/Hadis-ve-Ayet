
import 'package:hadith/core/features/get_title/domain/enums/title_enum.dart';

abstract class IGetTitleEvent{}

class GetTitleEventRequestTitle extends IGetTitleEvent{
  final int itemId;
  final TitleEnum titleEnum;

  GetTitleEventRequestTitle({required this.itemId,required this.titleEnum});
}