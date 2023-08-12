

import 'package:floor/floor.dart';

@Entity(
    tableName: "Prayers",
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

  const PrayerEntity({
    this.id,
    required this.name,
    required this.arabicContent,
    required this.meaningContent,
    required this.pronunciationContent,
    required this.source,
    required this.typeId,
    required this.orderItem,
    required this.isRemovable
  });
}