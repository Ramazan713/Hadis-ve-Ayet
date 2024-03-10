// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListBackupDto _$ListBackupDtoFromJson(Map<String, dynamic> json) {
  return _ListBackupDto.fromJson(json);
}

/// @nodoc
mixin _$ListBackupDto {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isRemovable => throw _privateConstructorUsedError;
  int get sourceId => throw _privateConstructorUsedError;
  bool get isArchive => throw _privateConstructorUsedError;
  int get pos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListBackupDtoCopyWith<ListBackupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListBackupDtoCopyWith<$Res> {
  factory $ListBackupDtoCopyWith(
          ListBackupDto value, $Res Function(ListBackupDto) then) =
      _$ListBackupDtoCopyWithImpl<$Res, ListBackupDto>;
  @useResult
  $Res call(
      {int? id,
      String name,
      bool isRemovable,
      int sourceId,
      bool isArchive,
      int pos});
}

/// @nodoc
class _$ListBackupDtoCopyWithImpl<$Res, $Val extends ListBackupDto>
    implements $ListBackupDtoCopyWith<$Res> {
  _$ListBackupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? isRemovable = null,
    Object? sourceId = null,
    Object? isArchive = null,
    Object? pos = null,
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
      isRemovable: null == isRemovable
          ? _value.isRemovable
          : isRemovable // ignore: cast_nullable_to_non_nullable
              as bool,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as int,
      isArchive: null == isArchive
          ? _value.isArchive
          : isArchive // ignore: cast_nullable_to_non_nullable
              as bool,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListBackupDtoImplCopyWith<$Res>
    implements $ListBackupDtoCopyWith<$Res> {
  factory _$$ListBackupDtoImplCopyWith(
          _$ListBackupDtoImpl value, $Res Function(_$ListBackupDtoImpl) then) =
      __$$ListBackupDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      bool isRemovable,
      int sourceId,
      bool isArchive,
      int pos});
}

/// @nodoc
class __$$ListBackupDtoImplCopyWithImpl<$Res>
    extends _$ListBackupDtoCopyWithImpl<$Res, _$ListBackupDtoImpl>
    implements _$$ListBackupDtoImplCopyWith<$Res> {
  __$$ListBackupDtoImplCopyWithImpl(
      _$ListBackupDtoImpl _value, $Res Function(_$ListBackupDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? isRemovable = null,
    Object? sourceId = null,
    Object? isArchive = null,
    Object? pos = null,
  }) {
    return _then(_$ListBackupDtoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isRemovable: null == isRemovable
          ? _value.isRemovable
          : isRemovable // ignore: cast_nullable_to_non_nullable
              as bool,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as int,
      isArchive: null == isArchive
          ? _value.isArchive
          : isArchive // ignore: cast_nullable_to_non_nullable
              as bool,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListBackupDtoImpl
    with DiagnosticableTreeMixin
    implements _ListBackupDto {
  const _$ListBackupDtoImpl(
      {this.id,
      required this.name,
      required this.isRemovable,
      required this.sourceId,
      required this.isArchive,
      required this.pos});

  factory _$ListBackupDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListBackupDtoImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final bool isRemovable;
  @override
  final int sourceId;
  @override
  final bool isArchive;
  @override
  final int pos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListBackupDto(id: $id, name: $name, isRemovable: $isRemovable, sourceId: $sourceId, isArchive: $isArchive, pos: $pos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ListBackupDto'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('isRemovable', isRemovable))
      ..add(DiagnosticsProperty('sourceId', sourceId))
      ..add(DiagnosticsProperty('isArchive', isArchive))
      ..add(DiagnosticsProperty('pos', pos));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListBackupDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isRemovable, isRemovable) ||
                other.isRemovable == isRemovable) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.isArchive, isArchive) ||
                other.isArchive == isArchive) &&
            (identical(other.pos, pos) || other.pos == pos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isRemovable, sourceId, isArchive, pos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListBackupDtoImplCopyWith<_$ListBackupDtoImpl> get copyWith =>
      __$$ListBackupDtoImplCopyWithImpl<_$ListBackupDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListBackupDtoImplToJson(
      this,
    );
  }
}

abstract class _ListBackupDto implements ListBackupDto {
  const factory _ListBackupDto(
      {final int? id,
      required final String name,
      required final bool isRemovable,
      required final int sourceId,
      required final bool isArchive,
      required final int pos}) = _$ListBackupDtoImpl;

  factory _ListBackupDto.fromJson(Map<String, dynamic> json) =
      _$ListBackupDtoImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  bool get isRemovable;
  @override
  int get sourceId;
  @override
  bool get isArchive;
  @override
  int get pos;
  @override
  @JsonKey(ignore: true)
  _$$ListBackupDtoImplCopyWith<_$ListBackupDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
