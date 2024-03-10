// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_dhikr.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PrayerDhikr {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get arabicContent => throw _privateConstructorUsedError;
  String get meaningContent => throw _privateConstructorUsedError;
  String get pronunciationContent => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;
  int? get counterId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerDhikrCopyWith<PrayerDhikr> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerDhikrCopyWith<$Res> {
  factory $PrayerDhikrCopyWith(
          PrayerDhikr value, $Res Function(PrayerDhikr) then) =
      _$PrayerDhikrCopyWithImpl<$Res, PrayerDhikr>;
  @useResult
  $Res call(
      {int id,
      String name,
      String arabicContent,
      String meaningContent,
      String pronunciationContent,
      int orderItem,
      int? counterId});
}

/// @nodoc
class _$PrayerDhikrCopyWithImpl<$Res, $Val extends PrayerDhikr>
    implements $PrayerDhikrCopyWith<$Res> {
  _$PrayerDhikrCopyWithImpl(this._value, this._then);

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
    Object? pronunciationContent = null,
    Object? orderItem = null,
    Object? counterId = freezed,
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
      pronunciationContent: null == pronunciationContent
          ? _value.pronunciationContent
          : pronunciationContent // ignore: cast_nullable_to_non_nullable
              as String,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      counterId: freezed == counterId
          ? _value.counterId
          : counterId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrayerDhikrImplCopyWith<$Res>
    implements $PrayerDhikrCopyWith<$Res> {
  factory _$$PrayerDhikrImplCopyWith(
          _$PrayerDhikrImpl value, $Res Function(_$PrayerDhikrImpl) then) =
      __$$PrayerDhikrImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String arabicContent,
      String meaningContent,
      String pronunciationContent,
      int orderItem,
      int? counterId});
}

/// @nodoc
class __$$PrayerDhikrImplCopyWithImpl<$Res>
    extends _$PrayerDhikrCopyWithImpl<$Res, _$PrayerDhikrImpl>
    implements _$$PrayerDhikrImplCopyWith<$Res> {
  __$$PrayerDhikrImplCopyWithImpl(
      _$PrayerDhikrImpl _value, $Res Function(_$PrayerDhikrImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? pronunciationContent = null,
    Object? orderItem = null,
    Object? counterId = freezed,
  }) {
    return _then(_$PrayerDhikrImpl(
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
      pronunciationContent: null == pronunciationContent
          ? _value.pronunciationContent
          : pronunciationContent // ignore: cast_nullable_to_non_nullable
              as String,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      counterId: freezed == counterId
          ? _value.counterId
          : counterId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$PrayerDhikrImpl implements _PrayerDhikr {
  const _$PrayerDhikrImpl(
      {required this.id,
      required this.name,
      required this.arabicContent,
      required this.meaningContent,
      required this.pronunciationContent,
      required this.orderItem,
      this.counterId});

  @override
  final int id;
  @override
  final String name;
  @override
  final String arabicContent;
  @override
  final String meaningContent;
  @override
  final String pronunciationContent;
  @override
  final int orderItem;
  @override
  final int? counterId;

  @override
  String toString() {
    return 'PrayerDhikr(id: $id, name: $name, arabicContent: $arabicContent, meaningContent: $meaningContent, pronunciationContent: $pronunciationContent, orderItem: $orderItem, counterId: $counterId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerDhikrImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent) &&
            (identical(other.pronunciationContent, pronunciationContent) ||
                other.pronunciationContent == pronunciationContent) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem) &&
            (identical(other.counterId, counterId) ||
                other.counterId == counterId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, arabicContent,
      meaningContent, pronunciationContent, orderItem, counterId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerDhikrImplCopyWith<_$PrayerDhikrImpl> get copyWith =>
      __$$PrayerDhikrImplCopyWithImpl<_$PrayerDhikrImpl>(this, _$identity);
}

abstract class _PrayerDhikr implements PrayerDhikr {
  const factory _PrayerDhikr(
      {required final int id,
      required final String name,
      required final String arabicContent,
      required final String meaningContent,
      required final String pronunciationContent,
      required final int orderItem,
      final int? counterId}) = _$PrayerDhikrImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get arabicContent;
  @override
  String get meaningContent;
  @override
  String get pronunciationContent;
  @override
  int get orderItem;
  @override
  int? get counterId;
  @override
  @JsonKey(ignore: true)
  _$$PrayerDhikrImplCopyWith<_$PrayerDhikrImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
