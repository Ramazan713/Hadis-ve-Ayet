// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_verse_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PrayerVerseBackupDto _$PrayerVerseBackupDtoFromJson(Map<String, dynamic> json) {
  return _PrayerVerseBackupDto.fromJson(json);
}

/// @nodoc
mixin _$PrayerVerseBackupDto {
  int get verseId => throw _privateConstructorUsedError;
  int get prayerId => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrayerVerseBackupDtoCopyWith<PrayerVerseBackupDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerVerseBackupDtoCopyWith<$Res> {
  factory $PrayerVerseBackupDtoCopyWith(PrayerVerseBackupDto value,
          $Res Function(PrayerVerseBackupDto) then) =
      _$PrayerVerseBackupDtoCopyWithImpl<$Res, PrayerVerseBackupDto>;
  @useResult
  $Res call({int verseId, int prayerId, int orderItem});
}

/// @nodoc
class _$PrayerVerseBackupDtoCopyWithImpl<$Res,
        $Val extends PrayerVerseBackupDto>
    implements $PrayerVerseBackupDtoCopyWith<$Res> {
  _$PrayerVerseBackupDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verseId = null,
    Object? prayerId = null,
    Object? orderItem = null,
  }) {
    return _then(_value.copyWith(
      verseId: null == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int,
      prayerId: null == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrayerVerseBackupDtoImplCopyWith<$Res>
    implements $PrayerVerseBackupDtoCopyWith<$Res> {
  factory _$$PrayerVerseBackupDtoImplCopyWith(_$PrayerVerseBackupDtoImpl value,
          $Res Function(_$PrayerVerseBackupDtoImpl) then) =
      __$$PrayerVerseBackupDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int verseId, int prayerId, int orderItem});
}

/// @nodoc
class __$$PrayerVerseBackupDtoImplCopyWithImpl<$Res>
    extends _$PrayerVerseBackupDtoCopyWithImpl<$Res, _$PrayerVerseBackupDtoImpl>
    implements _$$PrayerVerseBackupDtoImplCopyWith<$Res> {
  __$$PrayerVerseBackupDtoImplCopyWithImpl(_$PrayerVerseBackupDtoImpl _value,
      $Res Function(_$PrayerVerseBackupDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verseId = null,
    Object? prayerId = null,
    Object? orderItem = null,
  }) {
    return _then(_$PrayerVerseBackupDtoImpl(
      verseId: null == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int,
      prayerId: null == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerVerseBackupDtoImpl
    with DiagnosticableTreeMixin
    implements _PrayerVerseBackupDto {
  const _$PrayerVerseBackupDtoImpl(
      {required this.verseId, required this.prayerId, required this.orderItem});

  factory _$PrayerVerseBackupDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerVerseBackupDtoImplFromJson(json);

  @override
  final int verseId;
  @override
  final int prayerId;
  @override
  final int orderItem;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerVerseBackupDto(verseId: $verseId, prayerId: $prayerId, orderItem: $orderItem)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrayerVerseBackupDto'))
      ..add(DiagnosticsProperty('verseId', verseId))
      ..add(DiagnosticsProperty('prayerId', prayerId))
      ..add(DiagnosticsProperty('orderItem', orderItem));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerVerseBackupDtoImpl &&
            (identical(other.verseId, verseId) || other.verseId == verseId) &&
            (identical(other.prayerId, prayerId) ||
                other.prayerId == prayerId) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, verseId, prayerId, orderItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerVerseBackupDtoImplCopyWith<_$PrayerVerseBackupDtoImpl>
      get copyWith =>
          __$$PrayerVerseBackupDtoImplCopyWithImpl<_$PrayerVerseBackupDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerVerseBackupDtoImplToJson(
      this,
    );
  }
}

abstract class _PrayerVerseBackupDto implements PrayerVerseBackupDto {
  const factory _PrayerVerseBackupDto(
      {required final int verseId,
      required final int prayerId,
      required final int orderItem}) = _$PrayerVerseBackupDtoImpl;

  factory _PrayerVerseBackupDto.fromJson(Map<String, dynamic> json) =
      _$PrayerVerseBackupDtoImpl.fromJson;

  @override
  int get verseId;
  @override
  int get prayerId;
  @override
  int get orderItem;
  @override
  @JsonKey(ignore: true)
  _$$PrayerVerseBackupDtoImplCopyWith<_$PrayerVerseBackupDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
