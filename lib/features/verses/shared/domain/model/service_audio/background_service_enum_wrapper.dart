


import 'package:equatable/equatable.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'background_service_enum_wrapper.g.dart';


@JsonSerializable(explicitToJson: true)
class BackgroundServiceEnumWrapper extends Equatable{
  final AudioServiceEnum serviceEnum;

  const BackgroundServiceEnumWrapper({required this.serviceEnum});

  factory BackgroundServiceEnumWrapper.fromJson(Map<String, dynamic> json) => _$BackgroundServiceEnumWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$BackgroundServiceEnumWrapperToJson(this);

  @override
  List<Object?> get props => [serviceEnum];
}