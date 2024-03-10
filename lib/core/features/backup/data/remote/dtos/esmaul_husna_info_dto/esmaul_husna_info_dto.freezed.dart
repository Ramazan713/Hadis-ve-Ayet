// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'esmaul_husna_info_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EsmaulHusnaInfoDto _$EsmaulHusnaInfoDtoFromJson(Map<String, dynamic> json) {
  return _EsmaulHusnaInfoDto.fromJson(json);
}

/// @nodoc
mixin _$EsmaulHusnaInfoDto {
  int get orderItem => throw _privateConstructorUsedError;
  int? get counterId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EsmaulHusnaInfoDtoCopyWith<EsmaulHusnaInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EsmaulHusnaInfoDtoCopyWith<$Res> {
  factory $EsmaulHusnaInfoDtoCopyWith(
          EsmaulHusnaInfoDto value, $Res Function(EsmaulHusnaInfoDto) then) =
      _$EsmaulHusnaInfoDtoCopyWithImpl<$Res, EsmaulHusnaInfoDto>;
  @useResult
  $Res call({int orderItem, int? counterId});
}

/// @nodoc
class _$EsmaulHusnaInfoDtoCopyWithImpl<$Res, $Val extends EsmaulHusnaInfoDto>
    implements $EsmaulHusnaInfoDtoCopyWith<$Res> {
  _$EsmaulHusnaInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderItem = null,
    Object? counterId = freezed,
  }) {
    return _then(_value.copyWith(
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      counterId: freezed == counterId
          ? _value.counterId
          : counterId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EsmaulHusnaInfoDtoImplCopyWith<$Res>
    implements $EsmaulHusnaInfoDtoCopyWith<$Res> {
  factory _$$EsmaulHusnaInfoDtoImplCopyWith(_$EsmaulHusnaInfoDtoImpl value,
          $Res Function(_$EsmaulHusnaInfoDtoImpl) then) =
      __$$EsmaulHusnaInfoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int orderItem, int? counterId});
}

/// @nodoc
class __$$EsmaulHusnaInfoDtoImplCopyWithImpl<$Res>
    extends _$EsmaulHusnaInfoDtoCopyWithImpl<$Res, _$EsmaulHusnaInfoDtoImpl>
    implements _$$EsmaulHusnaInfoDtoImplCopyWith<$Res> {
  __$$EsmaulHusnaInfoDtoImplCopyWithImpl(_$EsmaulHusnaInfoDtoImpl _value,
      $Res Function(_$EsmaulHusnaInfoDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderItem = null,
    Object? counterId = freezed,
  }) {
    return _then(_$EsmaulHusnaInfoDtoImpl(
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      counterId: freezed == counterId
          ? _value.counterId
          : counterId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EsmaulHusnaInfoDtoImpl
    with DiagnosticableTreeMixin
    implements _EsmaulHusnaInfoDto {
  const _$EsmaulHusnaInfoDtoImpl(
      {required this.orderItem, required this.counterId});

  factory _$EsmaulHusnaInfoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EsmaulHusnaInfoDtoImplFromJson(json);

  @override
  final int orderItem;
  @override
  final int? counterId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EsmaulHusnaInfoDto(orderItem: $orderItem, counterId: $counterId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EsmaulHusnaInfoDto'))
      ..add(DiagnosticsProperty('orderItem', orderItem))
      ..add(DiagnosticsProperty('counterId', counterId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EsmaulHusnaInfoDtoImpl &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem) &&
            (identical(other.counterId, counterId) ||
                other.counterId == counterId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderItem, counterId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EsmaulHusnaInfoDtoImplCopyWith<_$EsmaulHusnaInfoDtoImpl> get copyWith =>
      __$$EsmaulHusnaInfoDtoImplCopyWithImpl<_$EsmaulHusnaInfoDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EsmaulHusnaInfoDtoImplToJson(
      this,
    );
  }
}

abstract class _EsmaulHusnaInfoDto implements EsmaulHusnaInfoDto {
  const factory _EsmaulHusnaInfoDto(
      {required final int orderItem,
      required final int? counterId}) = _$EsmaulHusnaInfoDtoImpl;

  factory _EsmaulHusnaInfoDto.fromJson(Map<String, dynamic> json) =
      _$EsmaulHusnaInfoDtoImpl.fromJson;

  @override
  int get orderItem;
  @override
  int? get counterId;
  @override
  @JsonKey(ignore: true)
  _$$EsmaulHusnaInfoDtoImplCopyWith<_$EsmaulHusnaInfoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
