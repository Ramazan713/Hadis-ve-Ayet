

import 'package:hadith/core/domain/models/icon_info.dart';

mixin ISelectItem{
  String get title;
}

mixin ISearchableSelectItem implements ISelectItem{
  String get searchableText;
}

mixin IMenuItem implements ISelectItem{
  IconInfo? get iconInfo;
}

mixin IDetailItem implements IMenuItem{
  String get details;
}