// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_verse_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ListVerseBackupDto _$ListVerseBackupDtoFromJson(Map<String, dynamic> json) {
  return _ListVerseBackupDto.fromJson(json);
}

/// @nodoc
mixin _$ListVerseBackupDto {
  int get listId => throw _privateConstructorUsedError;
  int get verseId => throw _privateConstructorUsedError;
  int get pos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListVerseBackupDtoCopyWith<ListVerseBackupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListVerseBackupDtoCopyWith<$Res> {
  factory $ListVerseBackupDtoCopyWith(
          ListVerseBackupDto value, $Res Function(ListVerseBackupDto) then) =
      _$ListVerseBackupDtoCopyWithImpl<$Res, ListVerseBackupDto>;
  @useResult
  $Res call({int listId, int verseId, int pos});
}

/// @nodoc
class _$ListVerseBackupDtoCopyWithImpl<$Res, $Val extends ListVerseBackupDto>
    implements $ListVerseBackupDtoCopyWith<$Res> {
  _$ListVerseBackupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listId = null,
    Object? verseId = null,
    Object? pos = null,
  }) {
    return _then(_value.copyWith(
      listId: null == listId
          ? _value.listId
          : listId // ignore: cast_nullable_to_non_nullable
              as int,
      verseId: null == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ListVerseBackupDtoCopyWith<$Res>
    implements $ListVerseBackupDtoCopyWith<$Res> {
  factory _$$_ListVerseBackupDtoCopyWith(_$_ListVerseBackupDto value,
          $Res Function(_$_ListVerseBackupDto) then) =
      __$$_ListVerseBackupDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int listId, int verseId, int pos});
}

/// @nodoc
class __$$_ListVerseBackupDtoCopyWithImpl<$Res>
    extends _$ListVerseBackupDtoCopyWithImpl<$Res, _$_ListVerseBackupDto>
    implements _$$_ListVerseBackupDtoCopyWith<$Res> {
  __$$_ListVerseBackupDtoCopyWithImpl(
      _$_ListVerseBackupDto _value, $Res Function(_$_ListVerseBackupDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listId = null,
    Object? verseId = null,
    Object? pos = null,
  }) {
    return _then(_$_ListVerseBackupDto(
      listId: null == listId
          ? _value.listId
          : listId // ignore: cast_nullable_to_non_nullable
              as int,
      verseId: null == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ListVerseBackupDto
    with DiagnosticableTreeMixin
    implements _ListVerseBackupDto {
  const _$_ListVerseBackupDto(
      {required this.listId, required this.verseId, required this.pos});

  factory _$_ListVerseBackupDto.fromJson(Map<String, dynamic> json) =>
      _$$_ListVerseBackupDtoFromJson(json);

  @override
  final int listId;
  @override
  final int verseId;
  @override
  final int pos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListVerseBackupDto(listId: $listId, verseId: $verseId, pos: $pos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ListVerseBackupDto'))
      ..add(DiagnosticsProperty('listId', listId))
      ..add(DiagnosticsProperty('verseId', verseId))
      ..add(DiagnosticsProperty('pos', pos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListVerseBackupDto &&
            (identical(other.listId, listId) || other.listId == listId) &&
            (identical(other.verseId, verseId) || other.verseId == verseId) &&
            (identical(other.pos, pos) || other.pos == pos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, listId, verseId, pos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ListVerseBackupDtoCopyWith<_$_ListVerseBackupDto> get copyWith =>
      __$$_ListVerseBackupDtoCopyWithImpl<_$_ListVerseBackupDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ListVerseBackupDtoToJson(
      this,
    );
  }
}

abstract class _ListVerseBackupDto implements ListVerseBackupDto {
  const factory _ListVerseBackupDto(
      {required final int listId,
      required final int verseId,
      required final int pos}) = _$_ListVerseBackupDto;

  factory _ListVerseBackupDto.fromJson(Map<String, dynamic> json) =
      _$_ListVerseBackupDto.fromJson;

  @override
  int get listId;
  @override
  int get verseId;
  @override
  int get pos;
  @override
  @JsonKey(ignore: true)
  _$$_ListVerseBackupDtoCopyWith<_$_ListVerseBackupDto> get copyWith =>
      throw _privateConstructorUsedError;
}
