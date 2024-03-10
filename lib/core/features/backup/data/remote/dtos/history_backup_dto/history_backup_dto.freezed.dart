// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistoryBackupDto _$HistoryBackupDtoFromJson(Map<String, dynamic> json) {
  return _HistoryBackupDto.fromJson(json);
}

/// @nodoc
mixin _$HistoryBackupDto {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get originType => throw _privateConstructorUsedError;
  String get modifiedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryBackupDtoCopyWith<HistoryBackupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryBackupDtoCopyWith<$Res> {
  factory $HistoryBackupDtoCopyWith(
          HistoryBackupDto value, $Res Function(HistoryBackupDto) then) =
      _$HistoryBackupDtoCopyWithImpl<$Res, HistoryBackupDto>;
  @useResult
  $Res call({int? id, String name, int originType, String modifiedDate});
}

/// @nodoc
class _$HistoryBackupDtoCopyWithImpl<$Res, $Val extends HistoryBackupDto>
    implements $HistoryBackupDtoCopyWith<$Res> {
  _$HistoryBackupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? originType = null,
    Object? modifiedDate = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originType: null == originType
          ? _value.originType
          : originType // ignore: cast_nullable_to_non_nullable
              as int,
      modifiedDate: null == modifiedDate
          ? _value.modifiedDate
          : modifiedDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryBackupDtoImplCopyWith<$Res>
    implements $HistoryBackupDtoCopyWith<$Res> {
  factory _$$HistoryBackupDtoImplCopyWith(_$HistoryBackupDtoImpl value,
          $Res Function(_$HistoryBackupDtoImpl) then) =
      __$$HistoryBackupDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String name, int originType, String modifiedDate});
}

/// @nodoc
class __$$HistoryBackupDtoImplCopyWithImpl<$Res>
    extends _$HistoryBackupDtoCopyWithImpl<$Res, _$HistoryBackupDtoImpl>
    implements _$$HistoryBackupDtoImplCopyWith<$Res> {
  __$$HistoryBackupDtoImplCopyWithImpl(_$HistoryBackupDtoImpl _value,
      $Res Function(_$HistoryBackupDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? originType = null,
    Object? modifiedDate = null,
  }) {
    return _then(_$HistoryBackupDtoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originType: null == originType
          ? _value.originType
          : originType // ignore: cast_nullable_to_non_nullable
              as int,
      modifiedDate: null == modifiedDate
          ? _value.modifiedDate
          : modifiedDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryBackupDtoImpl
    with DiagnosticableTreeMixin
    implements _HistoryBackupDto {
  const _$HistoryBackupDtoImpl(
      {required this.id,
      required this.name,
      required this.originType,
      required this.modifiedDate});

  factory _$HistoryBackupDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryBackupDtoImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final int originType;
  @override
  final String modifiedDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryBackupDto(id: $id, name: $name, originType: $originType, modifiedDate: $modifiedDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HistoryBackupDto'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('originType', originType))
      ..add(DiagnosticsProperty('modifiedDate', modifiedDate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryBackupDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originType, originType) ||
                other.originType == originType) &&
            (identical(other.modifiedDate, modifiedDate) ||
                other.modifiedDate == modifiedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, originType, modifiedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryBackupDtoImplCopyWith<_$HistoryBackupDtoImpl> get copyWith =>
      __$$HistoryBackupDtoImplCopyWithImpl<_$HistoryBackupDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryBackupDtoImplToJson(
      this,
    );
  }
}

abstract class _HistoryBackupDto implements HistoryBackupDto {
  const factory _HistoryBackupDto(
      {required final int? id,
      required final String name,
      required final int originType,
      required final String modifiedDate}) = _$HistoryBackupDtoImpl;

  factory _HistoryBackupDto.fromJson(Map<String, dynamic> json) =
      _$HistoryBackupDtoImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  int get originType;
  @override
  String get modifiedDate;
  @override
  @JsonKey(ignore: true)
  _$$HistoryBackupDtoImplCopyWith<_$HistoryBackupDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
