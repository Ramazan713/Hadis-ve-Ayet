// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_quran_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrayerQuranData {
  String get arabicContent => throw _privateConstructorUsedError;
  String get meaningContent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerQuranDataCopyWith<PrayerQuranData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerQuranDataCopyWith<$Res> {
  factory $PrayerQuranDataCopyWith(
          PrayerQuranData value, $Res Function(PrayerQuranData) then) =
      _$PrayerQuranDataCopyWithImpl<$Res, PrayerQuranData>;
  @useResult
  $Res call({String arabicContent, String meaningContent});
}

/// @nodoc
class _$PrayerQuranDataCopyWithImpl<$Res, $Val extends PrayerQuranData>
    implements $PrayerQuranDataCopyWith<$Res> {
  _$PrayerQuranDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arabicContent = null,
    Object? meaningContent = null,
  }) {
    return _then(_value.copyWith(
      arabicContent: null == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String,
      meaningContent: null == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrayerQuranDataCopyWith<$Res>
    implements $PrayerQuranDataCopyWith<$Res> {
  factory _$$_PrayerQuranDataCopyWith(
          _$_PrayerQuranData value, $Res Function(_$_PrayerQuranData) then) =
      __$$_PrayerQuranDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String arabicContent, String meaningContent});
}

/// @nodoc
class __$$_PrayerQuranDataCopyWithImpl<$Res>
    extends _$PrayerQuranDataCopyWithImpl<$Res, _$_PrayerQuranData>
    implements _$$_PrayerQuranDataCopyWith<$Res> {
  __$$_PrayerQuranDataCopyWithImpl(
      _$_PrayerQuranData _value, $Res Function(_$_PrayerQuranData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arabicContent = null,
    Object? meaningContent = null,
  }) {
    return _then(_$_PrayerQuranData(
      arabicContent: null == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String,
      meaningContent: null == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_PrayerQuranData
    with DiagnosticableTreeMixin
    implements _PrayerQuranData {
  const _$_PrayerQuranData(
      {required this.arabicContent, required this.meaningContent});

  @override
  final String arabicContent;
  @override
  final String meaningContent;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerQuranData(arabicContent: $arabicContent, meaningContent: $meaningContent)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrayerQuranData'))
      ..add(DiagnosticsProperty('arabicContent', arabicContent))
      ..add(DiagnosticsProperty('meaningContent', meaningContent));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrayerQuranData &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arabicContent, meaningContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrayerQuranDataCopyWith<_$_PrayerQuranData> get copyWith =>
      __$$_PrayerQuranDataCopyWithImpl<_$_PrayerQuranData>(this, _$identity);
}

abstract class _PrayerQuranData implements PrayerQuranData {
  const factory _PrayerQuranData(
      {required final String arabicContent,
      required final String meaningContent}) = _$_PrayerQuranData;

  @override
  String get arabicContent;
  @override
  String get meaningContent;
  @override
  @JsonKey(ignore: true)
  _$$_PrayerQuranDataCopyWith<_$_PrayerQuranData> get copyWith =>
      throw _privateConstructorUsedError;
}
