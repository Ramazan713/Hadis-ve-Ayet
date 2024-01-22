
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'esmaul_husna_info_dto.freezed.dart';
part 'esmaul_husna_info_dto.g.dart';

@freezed
class EsmaulHusnaInfoDto with _$EsmaulHusnaInfoDto{
  const factory EsmaulHusnaInfoDto({
    required int orderItem,
    required int? counterId
  }) = _EsmaulHusnaInfoDto;

  factory EsmaulHusnaInfoDto.fromJson(Map<String, Object?> json) => _$EsmaulHusnaInfoDtoFromJson(json);
}