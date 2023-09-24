

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/counter_entity.dart';
@Entity(
  tableName: "EsmaulHusnas",
  foreignKeys: [
    ForeignKey(
      childColumns: ["counterId"],
      parentColumns: ["id"],
      entity: CounterEntity,
      onDelete: ForeignKeyAction.setNull
    )
  ]
)
class EsmaulHusnaEntity{
  @PrimaryKey(autoGenerate: false)
  final int? id;
  final int orderItem;
  final String name;
  final String arabicName;
  final String searchName;
  final String meaning;
  final String dhikr;
  final String virtue;
  final int? counterId;

  EsmaulHusnaEntity({
    this.id,
    required this.orderItem,
    required this.name,
    required this.arabicName
    ,required this.meaning,
    required this.dhikr,
    required this.virtue,
    required this.counterId,
    required this.searchName
  });
}