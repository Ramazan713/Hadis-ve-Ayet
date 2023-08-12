// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Prayer {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get arabicContent => throw _privateConstructorUsedError;
  String? get meaningContent => throw _privateConstructorUsedError;
  String? get pronunciationContent => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  PrayerTypeEnum get prayerType => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerCopyWith<Prayer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerCopyWith<$Res> {
  factory $PrayerCopyWith(Prayer value, $Res Function(Prayer) then) =
      _$PrayerCopyWithImpl<$Res, Prayer>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? arabicContent,
      String? meaningContent,
      String? pronunciationContent,
      String? source,
      PrayerTypeEnum prayerType,
      int orderItem});
}

/// @nodoc
class _$PrayerCopyWithImpl<$Res, $Val extends Prayer>
    implements $PrayerCopyWith<$Res> {
  _$PrayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? arabicContent = freezed,
    Object? meaningContent = freezed,
    Object? pronunciationContent = freezed,
    Object? source = freezed,
    Object? prayerType = null,
    Object? orderItem = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicContent: freezed == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String?,
      meaningContent: freezed == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String?,
      pronunciationContent: freezed == pronunciationContent
          ? _value.pronunciationContent
          : pronunciationContent // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      prayerType: null == prayerType
          ? _value.prayerType
          : prayerType // ignore: cast_nullable_to_non_nullable
              as PrayerTypeEnum,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrayerCopyWith<$Res> implements $PrayerCopyWith<$Res> {
  factory _$$_PrayerCopyWith(_$_Prayer value, $Res Function(_$_Prayer) then) =
      __$$_PrayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? arabicContent,
      String? meaningContent,
      String? pronunciationContent,
      String? source,
      PrayerTypeEnum prayerType,
      int orderItem});
}

/// @nodoc
class __$$_PrayerCopyWithImpl<$Res>
    extends _$PrayerCopyWithImpl<$Res, _$_Prayer>
    implements _$$_PrayerCopyWith<$Res> {
  __$$_PrayerCopyWithImpl(_$_Prayer _value, $Res Function(_$_Prayer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? arabicContent = freezed,
    Object? meaningContent = freezed,
    Object? pronunciationContent = freezed,
    Object? source = freezed,
    Object? prayerType = null,
    Object? orderItem = null,
  }) {
    return _then(_$_Prayer(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicContent: freezed == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String?,
      meaningContent: freezed == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String?,
      pronunciationContent: freezed == pronunciationContent
          ? _value.pronunciationContent
          : pronunciationContent // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      prayerType: null == prayerType
          ? _value.prayerType
          : prayerType // ignore: cast_nullable_to_non_nullable
              as PrayerTypeEnum,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Prayer with DiagnosticableTreeMixin implements _Prayer {
  const _$_Prayer(
      {this.id,
      this.name,
      this.arabicContent,
      this.meaningContent,
      this.pronunciationContent,
      this.source,
      required this.prayerType,
      required this.orderItem});

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? arabicContent;
  @override
  final String? meaningContent;
  @override
  final String? pronunciationContent;
  @override
  final String? source;
  @override
  final PrayerTypeEnum prayerType;
  @override
  final int orderItem;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Prayer(id: $id, name: $name, arabicContent: $arabicContent, meaningContent: $meaningContent, pronunciationContent: $pronunciationContent, source: $source, prayerType: $prayerType, orderItem: $orderItem)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Prayer'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('arabicContent', arabicContent))
      ..add(DiagnosticsProperty('meaningContent', meaningContent))
      ..add(DiagnosticsProperty('pronunciationContent', pronunciationContent))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('prayerType', prayerType))
      ..add(DiagnosticsProperty('orderItem', orderItem));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Prayer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent) &&
            (identical(other.pronunciationContent, pronunciationContent) ||
                other.pronunciationContent == pronunciationContent) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.prayerType, prayerType) ||
                other.prayerType == prayerType) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, arabicContent,
      meaningContent, pronunciationContent, source, prayerType, orderItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrayerCopyWith<_$_Prayer> get copyWith =>
      __$$_PrayerCopyWithImpl<_$_Prayer>(this, _$identity);
}

abstract class _Prayer implements Prayer {
  const factory _Prayer(
      {final int? id,
      final String? name,
      final String? arabicContent,
      final String? meaningContent,
      final String? pronunciationContent,
      final String? source,
      required final PrayerTypeEnum prayerType,
      required final int orderItem}) = _$_Prayer;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get arabicContent;
  @override
  String? get meaningContent;
  @override
  String? get pronunciationContent;
  @override
  String? get source;
  @override
  PrayerTypeEnum get prayerType;
  @override
  int get orderItem;
  @override
  @JsonKey(ignore: true)
  _$$_PrayerCopyWith<_$_Prayer> get copyWith =>
      throw _privateConstructorUsedError;
}
