


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'esmaul_husna.freezed.dart';

@freezed
class EsmaulHusna with _$EsmaulHusna{
  const factory EsmaulHusna({
    required int? id,
    required int order,
    required String name,
    required String arabicName,
    required String meaning,
    required String dhikr,
    required String virtue,
    required int? counterId
  }) = _EsmaulHusna;
}