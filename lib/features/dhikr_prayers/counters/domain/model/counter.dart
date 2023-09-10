


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
part 'counter.freezed.dart';

@freezed
class Counter with _$Counter{
  const factory Counter({
    int? id,
    required String name,
    required CounterType counterType,
    required int lastCounter,
    @Default(0) int order,
    String? content,
    String? arabicContent,
    String? meaning,
    String? description,
    int? goal,
    int? prayerId
  }) = _Counter;
}
