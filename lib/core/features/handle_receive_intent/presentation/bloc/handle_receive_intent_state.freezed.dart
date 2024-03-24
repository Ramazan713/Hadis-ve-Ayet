// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handle_receive_intent_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HandleReceiveIntentState {
  LoadingEnum get loadingEnum => throw _privateConstructorUsedError;
  bool get navigateToCustomPrayer => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HandleReceiveIntentStateCopyWith<HandleReceiveIntentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandleReceiveIntentStateCopyWith<$Res> {
  factory $HandleReceiveIntentStateCopyWith(HandleReceiveIntentState value,
          $Res Function(HandleReceiveIntentState) then) =
      _$HandleReceiveIntentStateCopyWithImpl<$Res, HandleReceiveIntentState>;
  @useResult
  $Res call(
      {LoadingEnum loadingEnum, bool navigateToCustomPrayer, String? message});
}

/// @nodoc
class _$HandleReceiveIntentStateCopyWithImpl<$Res,
        $Val extends HandleReceiveIntentState>
    implements $HandleReceiveIntentStateCopyWith<$Res> {
  _$HandleReceiveIntentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? navigateToCustomPrayer = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      loadingEnum: null == loadingEnum
          ? _value.loadingEnum
          : loadingEnum // ignore: cast_nullable_to_non_nullable
              as LoadingEnum,
      navigateToCustomPrayer: null == navigateToCustomPrayer
          ? _value.navigateToCustomPrayer
          : navigateToCustomPrayer // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HandleReceiveIntentStateImplCopyWith<$Res>
    implements $HandleReceiveIntentStateCopyWith<$Res> {
  factory _$$HandleReceiveIntentStateImplCopyWith(
          _$HandleReceiveIntentStateImpl value,
          $Res Function(_$HandleReceiveIntentStateImpl) then) =
      __$$HandleReceiveIntentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingEnum loadingEnum, bool navigateToCustomPrayer, String? message});
}

/// @nodoc
class __$$HandleReceiveIntentStateImplCopyWithImpl<$Res>
    extends _$HandleReceiveIntentStateCopyWithImpl<$Res,
        _$HandleReceiveIntentStateImpl>
    implements _$$HandleReceiveIntentStateImplCopyWith<$Res> {
  __$$HandleReceiveIntentStateImplCopyWithImpl(
      _$HandleReceiveIntentStateImpl _value,
      $Res Function(_$HandleReceiveIntentStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? navigateToCustomPrayer = null,
    Object? message = freezed,
  }) {
    return _then(_$HandleReceiveIntentStateImpl(
      loadingEnum: null == loadingEnum
          ? _value.loadingEnum
          : loadingEnum // ignore: cast_nullable_to_non_nullable
              as LoadingEnum,
      navigateToCustomPrayer: null == navigateToCustomPrayer
          ? _value.navigateToCustomPrayer
          : navigateToCustomPrayer // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HandleReceiveIntentStateImpl
    with DiagnosticableTreeMixin
    implements _HandleReceiveIntentState {
  const _$HandleReceiveIntentStateImpl(
      {required this.loadingEnum,
      required this.navigateToCustomPrayer,
      this.message});

  @override
  final LoadingEnum loadingEnum;
  @override
  final bool navigateToCustomPrayer;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HandleReceiveIntentState(loadingEnum: $loadingEnum, navigateToCustomPrayer: $navigateToCustomPrayer, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HandleReceiveIntentState'))
      ..add(DiagnosticsProperty('loadingEnum', loadingEnum))
      ..add(
          DiagnosticsProperty('navigateToCustomPrayer', navigateToCustomPrayer))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandleReceiveIntentStateImpl &&
            (identical(other.loadingEnum, loadingEnum) ||
                other.loadingEnum == loadingEnum) &&
            (identical(other.navigateToCustomPrayer, navigateToCustomPrayer) ||
                other.navigateToCustomPrayer == navigateToCustomPrayer) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, loadingEnum, navigateToCustomPrayer, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HandleReceiveIntentStateImplCopyWith<_$HandleReceiveIntentStateImpl>
      get copyWith => __$$HandleReceiveIntentStateImplCopyWithImpl<
          _$HandleReceiveIntentStateImpl>(this, _$identity);
}

abstract class _HandleReceiveIntentState implements HandleReceiveIntentState {
  const factory _HandleReceiveIntentState(
      {required final LoadingEnum loadingEnum,
      required final bool navigateToCustomPrayer,
      final String? message}) = _$HandleReceiveIntentStateImpl;

  @override
  LoadingEnum get loadingEnum;
  @override
  bool get navigateToCustomPrayer;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$HandleReceiveIntentStateImplCopyWith<_$HandleReceiveIntentStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
