

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/counter_entity.dart';

@Entity(
  tableName: "Prayers",
  foreignKeys: [
    ForeignKey(
      childColumns: ["counterId"],
      parentColumns: ["id"],
      entity: CounterEntity,
      onDelete: ForeignKeyAction.setNull,
      onUpdate: ForeignKeyAction.cascade
    ),
    ForeignKey(
        childColumns: ["parentPrayerId"],
        parentColumns: ["id"],
        entity: PrayerEntity,
        onDelete: ForeignKeyAction.setNull,
        onUpdate: ForeignKeyAction.cascade
    ),
  ]
)
class PrayerEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? name;
  final String? arabicContent;
  final String? meaningContent;
  final String? pronunciationContent;
  final String? source;
  final int typeId;
  final int orderItem;
  final bool isRemovable;
  final int? counterId;
  final int? parentPrayerId;
  final bool updateCounter;

  const PrayerEntity({
    this.id,
    required this.name,
    required this.arabicContent,
    required this.meaningContent,
    required this.pronunciationContent,
    required this.source,
    required this.typeId,
    required this.orderItem,
    required this.isRemovable,
    required this.counterId,
    required this.updateCounter,
    required this.parentPrayerId
  });

  PrayerEntity copyWith({int? orderItem, int? parentPrayerId}){
    return PrayerEntity(
      id: id,
      name: name,
      source: source,
      counterId: counterId,
      orderItem: orderItem ?? this.orderItem,
      isRemovable: isRemovable,
      typeId: typeId,
      updateCounter: updateCounter,
      arabicContent: arabicContent,
      pronunciationContent: pronunciationContent,
      meaningContent: meaningContent,
      parentPrayerId: parentPrayerId ?? this.parentPrayerId
    );
  }
}