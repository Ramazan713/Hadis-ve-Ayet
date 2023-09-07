// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeState {
  bool get isLoading => throw _privateConstructorUsedError;
  ThemeTypeEnum get themeType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res, ThemeState>;
  @useResult
  $Res call({bool isLoading, ThemeTypeEnum themeType, String? message});
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res, $Val extends ThemeState>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? themeType = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      themeType: null == themeType
          ? _value.themeType
          : themeType // ignore: cast_nullable_to_non_nullable
              as ThemeTypeEnum,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ThemeStateCopyWith<$Res>
    implements $ThemeStateCopyWith<$Res> {
  factory _$$_ThemeStateCopyWith(
          _$_ThemeState value, $Res Function(_$_ThemeState) then) =
      __$$_ThemeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, ThemeTypeEnum themeType, String? message});
}

/// @nodoc
class __$$_ThemeStateCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$_ThemeState>
    implements _$$_ThemeStateCopyWith<$Res> {
  __$$_ThemeStateCopyWithImpl(
      _$_ThemeState _value, $Res Function(_$_ThemeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? themeType = null,
    Object? message = freezed,
  }) {
    return _then(_$_ThemeState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      themeType: null == themeType
          ? _value.themeType
          : themeType // ignore: cast_nullable_to_non_nullable
              as ThemeTypeEnum,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ThemeState with DiagnosticableTreeMixin implements _ThemeState {
  const _$_ThemeState(
      {required this.isLoading, required this.themeType, this.message});

  @override
  final bool isLoading;
  @override
  final ThemeTypeEnum themeType;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ThemeState(isLoading: $isLoading, themeType: $themeType, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ThemeState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('themeType', themeType))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.themeType, themeType) ||
                other.themeType == themeType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, themeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ThemeStateCopyWith<_$_ThemeState> get copyWith =>
      __$$_ThemeStateCopyWithImpl<_$_ThemeState>(this, _$identity);
}

abstract class _ThemeState implements ThemeState {
  const factory _ThemeState(
      {required final bool isLoading,
      required final ThemeTypeEnum themeType,
      final String? message}) = _$_ThemeState;

  @override
  bool get isLoading;
  @override
  ThemeTypeEnum get themeType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeStateCopyWith<_$_ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}
