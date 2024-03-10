// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_in_quran.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PrayerInQuran {
  int get id => throw _privateConstructorUsedError;
  String get arabicContent => throw _privateConstructorUsedError;
  String get meaningContent => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;
  int? get counterId => throw _privateConstructorUsedError;
  int? get parentPrayerId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerInQuranCopyWith<PrayerInQuran> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerInQuranCopyWith<$Res> {
  factory $PrayerInQuranCopyWith(
          PrayerInQuran value, $Res Function(PrayerInQuran) then) =
      _$PrayerInQuranCopyWithImpl<$Res, PrayerInQuran>;
  @useResult
  $Res call(
      {int id,
      String arabicContent,
      String meaningContent,
      String source,
      int orderItem,
      int? counterId,
      int? parentPrayerId});
}

/// @nodoc
class _$PrayerInQuranCopyWithImpl<$Res, $Val extends PrayerInQuran>
    implements $PrayerInQuranCopyWith<$Res> {
  _$PrayerInQuranCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? source = null,
    Object? orderItem = null,
    Object? counterId = freezed,
    Object? parentPrayerId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      arabicContent: null == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String,
      meaningContent: null == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      counterId: freezed == counterId
          ? _value.counterId
          : counterId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentPrayerId: freezed == parentPrayerId
          ? _value.parentPrayerId
          : parentPrayerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrayerInQuranImplCopyWith<$Res>
    implements $PrayerInQuranCopyWith<$Res> {
  factory _$$PrayerInQuranImplCopyWith(
          _$PrayerInQuranImpl value, $Res Function(_$PrayerInQuranImpl) then) =
      __$$PrayerInQuranImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String arabicContent,
      String meaningContent,
      String source,
      int orderItem,
      int? counterId,
      int? parentPrayerId});
}

/// @nodoc
class __$$PrayerInQuranImplCopyWithImpl<$Res>
    extends _$PrayerInQuranCopyWithImpl<$Res, _$PrayerInQuranImpl>
    implements _$$PrayerInQuranImplCopyWith<$Res> {
  __$$PrayerInQuranImplCopyWithImpl(
      _$PrayerInQuranImpl _value, $Res Function(_$PrayerInQuranImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? source = null,
    Object? orderItem = null,
    Object? counterId = freezed,
    Object? parentPrayerId = freezed,
  }) {
    return _then(_$PrayerInQuranImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      arabicContent: null == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String,
      meaningContent: null == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      counterId: freezed == counterId
          ? _value.counterId
          : counterId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentPrayerId: freezed == parentPrayerId
          ? _value.parentPrayerId
          : parentPrayerId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$PrayerInQuranImpl
    with DiagnosticableTreeMixin
    implements _PrayerInQuran {
  const _$PrayerInQuranImpl(
      {required this.id,
      required this.arabicContent,
      required this.meaningContent,
      required this.source,
      required this.orderItem,
      this.counterId,
      this.parentPrayerId});

  @override
  final int id;
  @override
  final String arabicContent;
  @override
  final String meaningContent;
  @override
  final String source;
  @override
  final int orderItem;
  @override
  final int? counterId;
  @override
  final int? parentPrayerId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerInQuran(id: $id, arabicContent: $arabicContent, meaningContent: $meaningContent, source: $source, orderItem: $orderItem, counterId: $counterId, parentPrayerId: $parentPrayerId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrayerInQuran'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('arabicContent', arabicContent))
      ..add(DiagnosticsProperty('meaningContent', meaningContent))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('orderItem', orderItem))
      ..add(DiagnosticsProperty('counterId', counterId))
      ..add(DiagnosticsProperty('parentPrayerId', parentPrayerId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerInQuranImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem) &&
            (identical(other.counterId, counterId) ||
                other.counterId == counterId) &&
            (identical(other.parentPrayerId, parentPrayerId) ||
                other.parentPrayerId == parentPrayerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, arabicContent,
      meaningContent, source, orderItem, counterId, parentPrayerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerInQuranImplCopyWith<_$PrayerInQuranImpl> get copyWith =>
      __$$PrayerInQuranImplCopyWithImpl<_$PrayerInQuranImpl>(this, _$identity);
}

abstract class _PrayerInQuran implements PrayerInQuran {
  const factory _PrayerInQuran(
      {required final int id,
      required final String arabicContent,
      required final String meaningContent,
      required final String source,
      required final int orderItem,
      final int? counterId,
      final int? parentPrayerId}) = _$PrayerInQuranImpl;

  @override
  int get id;
  @override
  String get arabicContent;
  @override
  String get meaningContent;
  @override
  String get source;
  @override
  int get orderItem;
  @override
  int? get counterId;
  @override
  int? get parentPrayerId;
  @override
  @JsonKey(ignore: true)
  _$$PrayerInQuranImplCopyWith<_$PrayerInQuranImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
