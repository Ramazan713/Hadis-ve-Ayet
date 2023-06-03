
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/book_entity.dart';

@Entity(tableName: "section",foreignKeys: [
  ForeignKey(
      childColumns: ["bookId"],
      parentColumns: ["id"],
      entity: BookEntity
  )
])
class SectionEntity{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int bookId;

  SectionEntity({this.id,required this.name,required this.bookId});
}