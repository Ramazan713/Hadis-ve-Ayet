

import 'package:hadith/core/domain/enums/source_type_enum.dart';

class TopicViewModel{
  final int id;
  final String name;
  final int sectionId;
  final int itemsCount;
  final SourceTypeEnum sourceTypeEnum;

  TopicViewModel({required this.id, required this.name, required this.sectionId,
    required this.itemsCount, required this.sourceTypeEnum
  });
}