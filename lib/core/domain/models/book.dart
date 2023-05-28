

import 'package:hadith/core/domain/enums/source_type_enum.dart';

class Book{
  final int? id;
  final String name;
  final SourceTypeEnum sourceType;

  Book({this.id, required this.name, required this.sourceType});
}