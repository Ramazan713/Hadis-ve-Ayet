


import 'package:floor/floor.dart';

import 'book_entity.dart';

@Entity(tableName: "hadith",foreignKeys: [
  ForeignKey(
      childColumns: ["bookId"],
      parentColumns: ["id"],
      entity: BookEntity
  )
])
class HadithEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int bookId;
  final String content;
  final String source;
  final int contentSize;

  const HadithEntity({this.id,required this.bookId,required this.content,required this.contentSize,required this.source});
}