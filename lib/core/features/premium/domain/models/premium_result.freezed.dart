// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PremiumResult {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PremiumResultCopyWith<PremiumResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumResultCopyWith<$Res> {
  factory $PremiumResultCopyWith(
          PremiumResult value, $Res Function(PremiumResult) then) =
      _$PremiumResultCopyWithImpl<$Res, PremiumResult>;
  @useResult
  $Res call({bool isLoading, bool isPremium, String? error});
}

/// @nodoc
class _$PremiumResultCopyWithImpl<$Res, $Val extends PremiumResult>
    implements $PremiumResultCopyWith<$Res> {
  _$PremiumResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isPremium = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PremiumResultImplCopyWith<$Res>
    implements $PremiumResultCopyWith<$Res> {
  factory _$$PremiumResultImplCopyWith(
          _$PremiumResultImpl value, $Res Function(_$PremiumResultImpl) then) =
      __$$PremiumResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, bool isPremium, String? error});
}

/// @nodoc
class __$$PremiumResultImplCopyWithImpl<$Res>
    extends _$PremiumResultCopyWithImpl<$Res, _$PremiumResultImpl>
    implements _$$PremiumResultImplCopyWith<$Res> {
  __$$PremiumResultImplCopyWithImpl(
      _$PremiumResultImpl _value, $Res Function(_$PremiumResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isPremium = null,
    Object? error = freezed,
  }) {
    return _then(_$PremiumResultImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PremiumResultImpl
    with DiagnosticableTreeMixin
    implements _PremiumResult {
  const _$PremiumResultImpl(
      {required this.isLoading, required this.isPremium, this.error});

  @override
  final bool isLoading;
  @override
  final bool isPremium;
  @override
  final String? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PremiumResult(isLoading: $isLoading, isPremium: $isPremium, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PremiumResult'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isPremium', isPremium))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumResultImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isPremium, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumResultImplCopyWith<_$PremiumResultImpl> get copyWith =>
      __$$PremiumResultImplCopyWithImpl<_$PremiumResultImpl>(this, _$identity);
}

abstract class _PremiumResult implements PremiumResult {
  const factory _PremiumResult(
      {required final bool isLoading,
      required final bool isPremium,
      final String? error}) = _$PremiumResultImpl;

  @override
  bool get isLoading;
  @override
  bool get isPremium;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$PremiumResultImplCopyWith<_$PremiumResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
