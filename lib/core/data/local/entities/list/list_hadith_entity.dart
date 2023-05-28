import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/hadith_entity.dart';


@Entity(tableName: "listHadith",foreignKeys: [
  ForeignKey(
      childColumns: ["listId"],
      parentColumns: ["id"],
      entity: List
  ),
  ForeignKey(
      childColumns: ["hadithId"],
      parentColumns: ["id"],
      entity: HadithEntity
  )
],primaryKeys: ["listId","hadithId"])
class ListHadithEntity{
  final int listId;
  final int hadithId;
  final int pos;

  const ListHadithEntity({required this.listId,required this.hadithId,required this.pos});

}