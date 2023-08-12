// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_and_verse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrayerAndVerse {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get arabicContent => throw _privateConstructorUsedError;
  String get meaningContent => throw _privateConstructorUsedError;
  String? get pronunciationContent => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerAndVerseCopyWith<PrayerAndVerse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerAndVerseCopyWith<$Res> {
  factory $PrayerAndVerseCopyWith(
          PrayerAndVerse value, $Res Function(PrayerAndVerse) then) =
      _$PrayerAndVerseCopyWithImpl<$Res, PrayerAndVerse>;
  @useResult
  $Res call(
      {int id,
      String name,
      String arabicContent,
      String meaningContent,
      String? pronunciationContent,
      int orderItem});
}

/// @nodoc
class _$PrayerAndVerseCopyWithImpl<$Res, $Val extends PrayerAndVerse>
    implements $PrayerAndVerseCopyWith<$Res> {
  _$PrayerAndVerseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? pronunciationContent = freezed,
    Object? orderItem = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      arabicContent: null == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String,
      meaningContent: null == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciationContent: freezed == pronunciationContent
          ? _value.pronunciationContent
          : pronunciationContent // ignore: cast_nullable_to_non_nullable
              as String?,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrayerAndVerseCopyWith<$Res>
    implements $PrayerAndVerseCopyWith<$Res> {
  factory _$$_PrayerAndVerseCopyWith(
          _$_PrayerAndVerse value, $Res Function(_$_PrayerAndVerse) then) =
      __$$_PrayerAndVerseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String arabicContent,
      String meaningContent,
      String? pronunciationContent,
      int orderItem});
}

/// @nodoc
class __$$_PrayerAndVerseCopyWithImpl<$Res>
    extends _$PrayerAndVerseCopyWithImpl<$Res, _$_PrayerAndVerse>
    implements _$$_PrayerAndVerseCopyWith<$Res> {
  __$$_PrayerAndVerseCopyWithImpl(
      _$_PrayerAndVerse _value, $Res Function(_$_PrayerAndVerse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? pronunciationContent = freezed,
    Object? orderItem = null,
  }) {
    return _then(_$_PrayerAndVerse(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      arabicContent: null == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String,
      meaningContent: null == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciationContent: freezed == pronunciationContent
          ? _value.pronunciationContent
          : pronunciationContent // ignore: cast_nullable_to_non_nullable
              as String?,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PrayerAndVerse implements _PrayerAndVerse {
  const _$_PrayerAndVerse(
      {required this.id,
      required this.name,
      required this.arabicContent,
      required this.meaningContent,
      this.pronunciationContent,
      required this.orderItem});

  @override
  final int id;
  @override
  final String name;
  @override
  final String arabicContent;
  @override
  final String meaningContent;
  @override
  final String? pronunciationContent;
  @override
  final int orderItem;

  @override
  String toString() {
    return 'PrayerAndVerse(id: $id, name: $name, arabicContent: $arabicContent, meaningContent: $meaningContent, pronunciationContent: $pronunciationContent, orderItem: $orderItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrayerAndVerse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent) &&
            (identical(other.pronunciationContent, pronunciationContent) ||
                other.pronunciationContent == pronunciationContent) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, arabicContent,
      meaningContent, pronunciationContent, orderItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrayerAndVerseCopyWith<_$_PrayerAndVerse> get copyWith =>
      __$$_PrayerAndVerseCopyWithImpl<_$_PrayerAndVerse>(this, _$identity);
}

abstract class _PrayerAndVerse implements PrayerAndVerse {
  const factory _PrayerAndVerse(
      {required final int id,
      required final String name,
      required final String arabicContent,
      required final String meaningContent,
      final String? pronunciationContent,
      required final int orderItem}) = _$_PrayerAndVerse;

  @override
  int get id;
  @override
  String get name;
  @override
  String get arabicContent;
  @override
  String get meaningContent;
  @override
  String? get pronunciationContent;
  @override
  int get orderItem;
  @override
  @JsonKey(ignore: true)
  _$$_PrayerAndVerseCopyWith<_$_PrayerAndVerse> get copyWith =>
      throw _privateConstructorUsedError;
}
