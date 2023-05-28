

import 'package:hadith/core/domain/enums/source_type_enum.dart';

import '../models/item_list_info.dart';

abstract class ItemListInfoRepo{

  Future<ItemListInfo?> getItemListInfo(int itemId, SourceTypeEnum sourceType);

}