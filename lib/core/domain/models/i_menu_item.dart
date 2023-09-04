

import 'package:hadith/core/domain/models/icon_info.dart';

mixin IMenuItem{
  String get title;
  IconInfo? get iconInfo;
}

mixin IDetailItem implements IMenuItem{
  String get details;
}