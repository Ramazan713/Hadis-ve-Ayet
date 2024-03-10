// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_hadith_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListHadithBackupDto _$ListHadithBackupDtoFromJson(Map<String, dynamic> json) {
  return _ListHadithBackupDto.fromJson(json);
}

/// @nodoc
mixin _$ListHadithBackupDto {
  int get listId => throw _privateConstructorUsedError;
  int get hadithId => throw _privateConstructorUsedError;
  int get pos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListHadithBackupDtoCopyWith<ListHadithBackupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListHadithBackupDtoCopyWith<$Res> {
  factory $ListHadithBackupDtoCopyWith(
          ListHadithBackupDto value, $Res Function(ListHadithBackupDto) then) =
      _$ListHadithBackupDtoCopyWithImpl<$Res, ListHadithBackupDto>;
  @useResult
  $Res call({int listId, int hadithId, int pos});
}

/// @nodoc
class _$ListHadithBackupDtoCopyWithImpl<$Res, $Val extends ListHadithBackupDto>
    implements $ListHadithBackupDtoCopyWith<$Res> {
  _$ListHadithBackupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listId = null,
    Object? hadithId = null,
    Object? pos = null,
  }) {
    return _then(_value.copyWith(
      listId: null == listId
          ? _value.listId
          : listId // ignore: cast_nullable_to_non_nullable
              as int,
      hadithId: null == hadithId
          ? _value.hadithId
          : hadithId // ignore: cast_nullable_to_non_nullable
              as int,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListHadithBackupDtoImplCopyWith<$Res>
    implements $ListHadithBackupDtoCopyWith<$Res> {
  factory _$$ListHadithBackupDtoImplCopyWith(_$ListHadithBackupDtoImpl value,
          $Res Function(_$ListHadithBackupDtoImpl) then) =
      __$$ListHadithBackupDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int listId, int hadithId, int pos});
}

/// @nodoc
class __$$ListHadithBackupDtoImplCopyWithImpl<$Res>
    extends _$ListHadithBackupDtoCopyWithImpl<$Res, _$ListHadithBackupDtoImpl>
    implements _$$ListHadithBackupDtoImplCopyWith<$Res> {
  __$$ListHadithBackupDtoImplCopyWithImpl(_$ListHadithBackupDtoImpl _value,
      $Res Function(_$ListHadithBackupDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listId = null,
    Object? hadithId = null,
    Object? pos = null,
  }) {
    return _then(_$ListHadithBackupDtoImpl(
      listId: null == listId
          ? _value.listId
          : listId // ignore: cast_nullable_to_non_nullable
              as int,
      hadithId: null == hadithId
          ? _value.hadithId
          : hadithId // ignore: cast_nullable_to_non_nullable
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
class _$ListHadithBackupDtoImpl
    with DiagnosticableTreeMixin
    implements _ListHadithBackupDto {
  const _$ListHadithBackupDtoImpl(
      {required this.listId, required this.hadithId, required this.pos});

  factory _$ListHadithBackupDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListHadithBackupDtoImplFromJson(json);

  @override
  final int listId;
  @override
  final int hadithId;
  @override
  final int pos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ListHadithBackupDto(listId: $listId, hadithId: $hadithId, pos: $pos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ListHadithBackupDto'))
      ..add(DiagnosticsProperty('listId', listId))
      ..add(DiagnosticsProperty('hadithId', hadithId))
      ..add(DiagnosticsProperty('pos', pos));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListHadithBackupDtoImpl &&
            (identical(other.listId, listId) || other.listId == listId) &&
            (identical(other.hadithId, hadithId) ||
                other.hadithId == hadithId) &&
            (identical(other.pos, pos) || other.pos == pos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, listId, hadithId, pos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListHadithBackupDtoImplCopyWith<_$ListHadithBackupDtoImpl> get copyWith =>
      __$$ListHadithBackupDtoImplCopyWithImpl<_$ListHadithBackupDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListHadithBackupDtoImplToJson(
      this,
    );
  }
}

abstract class _ListHadithBackupDto implements ListHadithBackupDto {
  const factory _ListHadithBackupDto(
      {required final int listId,
      required final int hadithId,
      required final int pos}) = _$ListHadithBackupDtoImpl;

  factory _ListHadithBackupDto.fromJson(Map<String, dynamic> json) =
      _$ListHadithBackupDtoImpl.fromJson;

  @override
  int get listId;
  @override
  int get hadithId;
  @override
  int get pos;
  @override
  @JsonKey(ignore: true)
  _$$ListHadithBackupDtoImplCopyWith<_$ListHadithBackupDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
