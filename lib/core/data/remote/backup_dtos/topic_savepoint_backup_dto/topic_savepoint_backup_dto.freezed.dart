// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic_savepoint_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TopicSavePointBackupDto _$TopicSavePointBackupDtoFromJson(
    Map<String, dynamic> json) {
  return _TopicSavePointBackupDto.fromJson(json);
}

/// @nodoc
mixin _$TopicSavePointBackupDto {
  int? get id => throw _privateConstructorUsedError;
  int get pos => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  String get parentKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopicSavePointBackupDtoCopyWith<TopicSavePointBackupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicSavePointBackupDtoCopyWith<$Res> {
  factory $TopicSavePointBackupDtoCopyWith(TopicSavePointBackupDto value,
          $Res Function(TopicSavePointBackupDto) then) =
      _$TopicSavePointBackupDtoCopyWithImpl<$Res, TopicSavePointBackupDto>;
  @useResult
  $Res call({int? id, int pos, int type, String parentKey});
}

/// @nodoc
class _$TopicSavePointBackupDtoCopyWithImpl<$Res,
        $Val extends TopicSavePointBackupDto>
    implements $TopicSavePointBackupDtoCopyWith<$Res> {
  _$TopicSavePointBackupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pos = null,
    Object? type = null,
    Object? parentKey = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      parentKey: null == parentKey
          ? _value.parentKey
          : parentKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TopicSavePointBackupDtoCopyWith<$Res>
    implements $TopicSavePointBackupDtoCopyWith<$Res> {
  factory _$$_TopicSavePointBackupDtoCopyWith(_$_TopicSavePointBackupDto value,
          $Res Function(_$_TopicSavePointBackupDto) then) =
      __$$_TopicSavePointBackupDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int pos, int type, String parentKey});
}

/// @nodoc
class __$$_TopicSavePointBackupDtoCopyWithImpl<$Res>
    extends _$TopicSavePointBackupDtoCopyWithImpl<$Res,
        _$_TopicSavePointBackupDto>
    implements _$$_TopicSavePointBackupDtoCopyWith<$Res> {
  __$$_TopicSavePointBackupDtoCopyWithImpl(_$_TopicSavePointBackupDto _value,
      $Res Function(_$_TopicSavePointBackupDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pos = null,
    Object? type = null,
    Object? parentKey = null,
  }) {
    return _then(_$_TopicSavePointBackupDto(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      parentKey: null == parentKey
          ? _value.parentKey
          : parentKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopicSavePointBackupDto
    with DiagnosticableTreeMixin
    implements _TopicSavePointBackupDto {
  const _$_TopicSavePointBackupDto(
      {this.id,
      required this.pos,
      required this.type,
      required this.parentKey});

  factory _$_TopicSavePointBackupDto.fromJson(Map<String, dynamic> json) =>
      _$$_TopicSavePointBackupDtoFromJson(json);

  @override
  final int? id;
  @override
  final int pos;
  @override
  final int type;
  @override
  final String parentKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TopicSavePointBackupDto(id: $id, pos: $pos, type: $type, parentKey: $parentKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TopicSavePointBackupDto'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('pos', pos))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('parentKey', parentKey));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopicSavePointBackupDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pos, pos) || other.pos == pos) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.parentKey, parentKey) ||
                other.parentKey == parentKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pos, type, parentKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopicSavePointBackupDtoCopyWith<_$_TopicSavePointBackupDto>
      get copyWith =>
          __$$_TopicSavePointBackupDtoCopyWithImpl<_$_TopicSavePointBackupDto>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopicSavePointBackupDtoToJson(
      this,
    );
  }
}

abstract class _TopicSavePointBackupDto implements TopicSavePointBackupDto {
  const factory _TopicSavePointBackupDto(
      {final int? id,
      required final int pos,
      required final int type,
      required final String parentKey}) = _$_TopicSavePointBackupDto;

  factory _TopicSavePointBackupDto.fromJson(Map<String, dynamic> json) =
      _$_TopicSavePointBackupDto.fromJson;

  @override
  int? get id;
  @override
  int get pos;
  @override
  int get type;
  @override
  String get parentKey;
  @override
  @JsonKey(ignore: true)
  _$$_TopicSavePointBackupDtoCopyWith<_$_TopicSavePointBackupDto>
      get copyWith => throw _privateConstructorUsedError;
}
