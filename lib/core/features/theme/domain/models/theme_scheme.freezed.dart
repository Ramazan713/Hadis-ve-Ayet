// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_scheme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ThemeScheme {
  ColorScheme get currentScheme => throw _privateConstructorUsedError;
  ColorScheme get lightScheme => throw _privateConstructorUsedError;
  ColorScheme get darkScheme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeSchemeCopyWith<ThemeScheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeSchemeCopyWith<$Res> {
  factory $ThemeSchemeCopyWith(
          ThemeScheme value, $Res Function(ThemeScheme) then) =
      _$ThemeSchemeCopyWithImpl<$Res, ThemeScheme>;
  @useResult
  $Res call(
      {ColorScheme currentScheme,
      ColorScheme lightScheme,
      ColorScheme darkScheme});
}

/// @nodoc
class _$ThemeSchemeCopyWithImpl<$Res, $Val extends ThemeScheme>
    implements $ThemeSchemeCopyWith<$Res> {
  _$ThemeSchemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentScheme = null,
    Object? lightScheme = null,
    Object? darkScheme = null,
  }) {
    return _then(_value.copyWith(
      currentScheme: null == currentScheme
          ? _value.currentScheme
          : currentScheme // ignore: cast_nullable_to_non_nullable
              as ColorScheme,
      lightScheme: null == lightScheme
          ? _value.lightScheme
          : lightScheme // ignore: cast_nullable_to_non_nullable
              as ColorScheme,
      darkScheme: null == darkScheme
          ? _value.darkScheme
          : darkScheme // ignore: cast_nullable_to_non_nullable
              as ColorScheme,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThemeSchemeImplCopyWith<$Res>
    implements $ThemeSchemeCopyWith<$Res> {
  factory _$$ThemeSchemeImplCopyWith(
          _$ThemeSchemeImpl value, $Res Function(_$ThemeSchemeImpl) then) =
      __$$ThemeSchemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ColorScheme currentScheme,
      ColorScheme lightScheme,
      ColorScheme darkScheme});
}

/// @nodoc
class __$$ThemeSchemeImplCopyWithImpl<$Res>
    extends _$ThemeSchemeCopyWithImpl<$Res, _$ThemeSchemeImpl>
    implements _$$ThemeSchemeImplCopyWith<$Res> {
  __$$ThemeSchemeImplCopyWithImpl(
      _$ThemeSchemeImpl _value, $Res Function(_$ThemeSchemeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentScheme = null,
    Object? lightScheme = null,
    Object? darkScheme = null,
  }) {
    return _then(_$ThemeSchemeImpl(
      currentScheme: null == currentScheme
          ? _value.currentScheme
          : currentScheme // ignore: cast_nullable_to_non_nullable
              as ColorScheme,
      lightScheme: null == lightScheme
          ? _value.lightScheme
          : lightScheme // ignore: cast_nullable_to_non_nullable
              as ColorScheme,
      darkScheme: null == darkScheme
          ? _value.darkScheme
          : darkScheme // ignore: cast_nullable_to_non_nullable
              as ColorScheme,
    ));
  }
}

/// @nodoc

class _$ThemeSchemeImpl implements _ThemeScheme {
  const _$ThemeSchemeImpl(
      {required this.currentScheme,
      required this.lightScheme,
      required this.darkScheme});

  @override
  final ColorScheme currentScheme;
  @override
  final ColorScheme lightScheme;
  @override
  final ColorScheme darkScheme;

  @override
  String toString() {
    return 'ThemeScheme(currentScheme: $currentScheme, lightScheme: $lightScheme, darkScheme: $darkScheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeSchemeImpl &&
            (identical(other.currentScheme, currentScheme) ||
                other.currentScheme == currentScheme) &&
            (identical(other.lightScheme, lightScheme) ||
                other.lightScheme == lightScheme) &&
            (identical(other.darkScheme, darkScheme) ||
                other.darkScheme == darkScheme));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentScheme, lightScheme, darkScheme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeSchemeImplCopyWith<_$ThemeSchemeImpl> get copyWith =>
      __$$ThemeSchemeImplCopyWithImpl<_$ThemeSchemeImpl>(this, _$identity);
}

abstract class _ThemeScheme implements ThemeScheme {
  const factory _ThemeScheme(
      {required final ColorScheme currentScheme,
      required final ColorScheme lightScheme,
      required final ColorScheme darkScheme}) = _$ThemeSchemeImpl;

  @override
  ColorScheme get currentScheme;
  @override
  ColorScheme get lightScheme;
  @override
  ColorScheme get darkScheme;
  @override
  @JsonKey(ignore: true)
  _$$ThemeSchemeImplCopyWith<_$ThemeSchemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
