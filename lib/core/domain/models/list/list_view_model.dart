

import 'package:hadith/core/domain/enums/source_type_enum.dart';

class ListViewModel{

  final int id;
  final String name;
  final int itemCounts;
  final bool isRemovable;
  final int contentMaxPos;
  final bool isArchive;
  final SourceTypeEnum sourceType;
  final int listPos;

  ListViewModel({
    required this.id,
    required this.contentMaxPos,
    required this.name,
    required this.isArchive,
    required this.sourceType,
    required this.listPos,
    required this.itemCounts,
    required this.isRemovable
  });

}
