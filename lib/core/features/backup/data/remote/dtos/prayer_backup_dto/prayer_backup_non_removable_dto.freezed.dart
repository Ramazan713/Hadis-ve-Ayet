// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_backup_non_removable_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PrayerBackupNonRemovableDto _$PrayerBackupNonRemovableDtoFromJson(
    Map<String, dynamic> json) {
  return _PrayerBackupNonRemovableDto.fromJson(json);
}

/// @nodoc
mixin _$PrayerBackupNonRemovableDto {
  int get typeId => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;
  int? get parentPrayerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrayerBackupNonRemovableDtoCopyWith<PrayerBackupNonRemovableDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerBackupNonRemovableDtoCopyWith<$Res> {
  factory $PrayerBackupNonRemovableDtoCopyWith(
          PrayerBackupNonRemovableDto value,
          $Res Function(PrayerBackupNonRemovableDto) then) =
      _$PrayerBackupNonRemovableDtoCopyWithImpl<$Res,
          PrayerBackupNonRemovableDto>;
  @useResult
  $Res call({int typeId, int orderItem, int? parentPrayerId});
}

/// @nodoc
class _$PrayerBackupNonRemovableDtoCopyWithImpl<$Res,
        $Val extends PrayerBackupNonRemovableDto>
    implements $PrayerBackupNonRemovableDtoCopyWith<$Res> {
  _$PrayerBackupNonRemovableDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeId = null,
    Object? orderItem = null,
    Object? parentPrayerId = freezed,
  }) {
    return _then(_value.copyWith(
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      parentPrayerId: freezed == parentPrayerId
          ? _value.parentPrayerId
          : parentPrayerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrayerBackupNonRemovableDtoImplCopyWith<$Res>
    implements $PrayerBackupNonRemovableDtoCopyWith<$Res> {
  factory _$$PrayerBackupNonRemovableDtoImplCopyWith(
          _$PrayerBackupNonRemovableDtoImpl value,
          $Res Function(_$PrayerBackupNonRemovableDtoImpl) then) =
      __$$PrayerBackupNonRemovableDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int typeId, int orderItem, int? parentPrayerId});
}

/// @nodoc
class __$$PrayerBackupNonRemovableDtoImplCopyWithImpl<$Res>
    extends _$PrayerBackupNonRemovableDtoCopyWithImpl<$Res,
        _$PrayerBackupNonRemovableDtoImpl>
    implements _$$PrayerBackupNonRemovableDtoImplCopyWith<$Res> {
  __$$PrayerBackupNonRemovableDtoImplCopyWithImpl(
      _$PrayerBackupNonRemovableDtoImpl _value,
      $Res Function(_$PrayerBackupNonRemovableDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeId = null,
    Object? orderItem = null,
    Object? parentPrayerId = freezed,
  }) {
    return _then(_$PrayerBackupNonRemovableDtoImpl(
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      parentPrayerId: freezed == parentPrayerId
          ? _value.parentPrayerId
          : parentPrayerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerBackupNonRemovableDtoImpl
    with DiagnosticableTreeMixin
    implements _PrayerBackupNonRemovableDto {
  const _$PrayerBackupNonRemovableDtoImpl(
      {required this.typeId, required this.orderItem, this.parentPrayerId});

  factory _$PrayerBackupNonRemovableDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PrayerBackupNonRemovableDtoImplFromJson(json);

  @override
  final int typeId;
  @override
  final int orderItem;
  @override
  final int? parentPrayerId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerBackupNonRemovableDto(typeId: $typeId, orderItem: $orderItem, parentPrayerId: $parentPrayerId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrayerBackupNonRemovableDto'))
      ..add(DiagnosticsProperty('typeId', typeId))
      ..add(DiagnosticsProperty('orderItem', orderItem))
      ..add(DiagnosticsProperty('parentPrayerId', parentPrayerId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerBackupNonRemovableDtoImpl &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem) &&
            (identical(other.parentPrayerId, parentPrayerId) ||
                other.parentPrayerId == parentPrayerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, typeId, orderItem, parentPrayerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerBackupNonRemovableDtoImplCopyWith<_$PrayerBackupNonRemovableDtoImpl>
      get copyWith => __$$PrayerBackupNonRemovableDtoImplCopyWithImpl<
          _$PrayerBackupNonRemovableDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerBackupNonRemovableDtoImplToJson(
      this,
    );
  }
}

abstract class _PrayerBackupNonRemovableDto
    implements PrayerBackupNonRemovableDto {
  const factory _PrayerBackupNonRemovableDto(
      {required final int typeId,
      required final int orderItem,
      final int? parentPrayerId}) = _$PrayerBackupNonRemovableDtoImpl;

  factory _PrayerBackupNonRemovableDto.fromJson(Map<String, dynamic> json) =
      _$PrayerBackupNonRemovableDtoImpl.fromJson;

  @override
  int get typeId;
  @override
  int get orderItem;
  @override
  int? get parentPrayerId;
  @override
  @JsonKey(ignore: true)
  _$$PrayerBackupNonRemovableDtoImplCopyWith<_$PrayerBackupNonRemovableDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
