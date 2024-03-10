// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_quran_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectQuranContent {
  String get arabicContent => throw _privateConstructorUsedError;
  String get meaningContent => throw _privateConstructorUsedError;
  List<Verse> get verses => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectQuranContentCopyWith<SelectQuranContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectQuranContentCopyWith<$Res> {
  factory $SelectQuranContentCopyWith(
          SelectQuranContent value, $Res Function(SelectQuranContent) then) =
      _$SelectQuranContentCopyWithImpl<$Res, SelectQuranContent>;
  @useResult
  $Res call({String arabicContent, String meaningContent, List<Verse> verses});
}

/// @nodoc
class _$SelectQuranContentCopyWithImpl<$Res, $Val extends SelectQuranContent>
    implements $SelectQuranContentCopyWith<$Res> {
  _$SelectQuranContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? verses = null,
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
      verses: null == verses
          ? _value.verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<Verse>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectQuranContentImplCopyWith<$Res>
    implements $SelectQuranContentCopyWith<$Res> {
  factory _$$SelectQuranContentImplCopyWith(_$SelectQuranContentImpl value,
          $Res Function(_$SelectQuranContentImpl) then) =
      __$$SelectQuranContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String arabicContent, String meaningContent, List<Verse> verses});
}

/// @nodoc
class __$$SelectQuranContentImplCopyWithImpl<$Res>
    extends _$SelectQuranContentCopyWithImpl<$Res, _$SelectQuranContentImpl>
    implements _$$SelectQuranContentImplCopyWith<$Res> {
  __$$SelectQuranContentImplCopyWithImpl(_$SelectQuranContentImpl _value,
      $Res Function(_$SelectQuranContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arabicContent = null,
    Object? meaningContent = null,
    Object? verses = null,
  }) {
    return _then(_$SelectQuranContentImpl(
      arabicContent: null == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String,
      meaningContent: null == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String,
      verses: null == verses
          ? _value._verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<Verse>,
    ));
  }
}

/// @nodoc

class _$SelectQuranContentImpl
    with DiagnosticableTreeMixin
    implements _SelectQuranContent {
  const _$SelectQuranContentImpl(
      {required this.arabicContent,
      required this.meaningContent,
      required final List<Verse> verses})
      : _verses = verses;

  @override
  final String arabicContent;
  @override
  final String meaningContent;
  final List<Verse> _verses;
  @override
  List<Verse> get verses {
    if (_verses is EqualUnmodifiableListView) return _verses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verses);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectQuranContent(arabicContent: $arabicContent, meaningContent: $meaningContent, verses: $verses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectQuranContent'))
      ..add(DiagnosticsProperty('arabicContent', arabicContent))
      ..add(DiagnosticsProperty('meaningContent', meaningContent))
      ..add(DiagnosticsProperty('verses', verses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectQuranContentImpl &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent) &&
            const DeepCollectionEquality().equals(other._verses, _verses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arabicContent, meaningContent,
      const DeepCollectionEquality().hash(_verses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectQuranContentImplCopyWith<_$SelectQuranContentImpl> get copyWith =>
      __$$SelectQuranContentImplCopyWithImpl<_$SelectQuranContentImpl>(
          this, _$identity);
}

abstract class _SelectQuranContent implements SelectQuranContent {
  const factory _SelectQuranContent(
      {required final String arabicContent,
      required final String meaningContent,
      required final List<Verse> verses}) = _$SelectQuranContentImpl;

  @override
  String get arabicContent;
  @override
  String get meaningContent;
  @override
  List<Verse> get verses;
  @override
  @JsonKey(ignore: true)
  _$$SelectQuranContentImplCopyWith<_$SelectQuranContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
