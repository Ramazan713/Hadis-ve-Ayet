
import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';

abstract class IDetailIslamicInfoEvent{}

class DetailIslamicInfoEventSetInit extends IDetailIslamicInfoEvent{
  final IslamicInfoType infoType;
  DetailIslamicInfoEventSetInit({required this.infoType});
}