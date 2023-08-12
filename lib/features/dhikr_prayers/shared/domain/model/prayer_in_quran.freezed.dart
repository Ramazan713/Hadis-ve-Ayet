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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrayerInQuran {
  int get id => throw _privateConstructorUsedError;
  String get arabicContent => throw _privateConstructorUsedError;
  String get meaningContent => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;

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
      int orderItem});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrayerInQuranCopyWith<$Res>
    implements $PrayerInQuranCopyWith<$Res> {
  factory _$$_PrayerInQuranCopyWith(
          _$_PrayerInQuran value, $Res Function(_$_PrayerInQuran) then) =
      __$$_PrayerInQuranCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String arabicContent,
      String meaningContent,
      String source,
      int orderItem});
}

/// @nodoc
class __$$_PrayerInQuranCopyWithImpl<$Res>
    extends _$PrayerInQuranCopyWithImpl<$Res, _$_PrayerInQuran>
    implements _$$_PrayerInQuranCopyWith<$Res> {
  __$$_PrayerInQuranCopyWithImpl(
      _$_PrayerInQuran _value, $Res Function(_$_PrayerInQuran) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? source = null,
    Object? orderItem = null,
  }) {
    return _then(_$_PrayerInQuran(
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
    ));
  }
}

/// @nodoc

class _$_PrayerInQuran with DiagnosticableTreeMixin implements _PrayerInQuran {
  const _$_PrayerInQuran(
      {required this.id,
      required this.arabicContent,
      required this.meaningContent,
      required this.source,
      required this.orderItem});

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerInQuran(id: $id, arabicContent: $arabicContent, meaningContent: $meaningContent, source: $source, orderItem: $orderItem)';
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
      ..add(DiagnosticsProperty('orderItem', orderItem));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrayerInQuran &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, arabicContent, meaningContent, source, orderItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrayerInQuranCopyWith<_$_PrayerInQuran> get copyWith =>
      __$$_PrayerInQuranCopyWithImpl<_$_PrayerInQuran>(this, _$identity);
}

abstract class _PrayerInQuran implements PrayerInQuran {
  const factory _PrayerInQuran(
      {required final int id,
      required final String arabicContent,
      required final String meaningContent,
      required final String source,
      required final int orderItem}) = _$_PrayerInQuran;

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
  @JsonKey(ignore: true)
  _$$_PrayerInQuranCopyWith<_$_PrayerInQuran> get copyWith =>
      throw _privateConstructorUsedError;
}
