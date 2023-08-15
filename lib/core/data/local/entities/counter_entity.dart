

import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

@Entity(tableName: "counters")
class CounterEntity{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String? content;
  final String? arabicContent;
  final String? meaning;
  final String? description;
  final int orderItem;
  final int lastCounter;
  final int? goal;
  final int typeId;

  CounterEntity({
    this.id,
    required this.name,
    required this.typeId,
    required this.lastCounter,
    required this.orderItem,
    this.content,
    this.arabicContent,
    this.description,
    this.goal,
    this.meaning
  });
}
