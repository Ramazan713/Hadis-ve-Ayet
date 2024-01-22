// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  LoadingEnum get loadingEnum => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  AuthDialogEvent? get dialogEvent => throw _privateConstructorUsedError;
  AuthUser? get currentUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {LoadingEnum loadingEnum,
      String? message,
      AuthDialogEvent? dialogEvent,
      AuthUser? currentUser});

  $AuthUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? message = freezed,
    Object? dialogEvent = freezed,
    Object? currentUser = freezed,
  }) {
    return _then(_value.copyWith(
      loadingEnum: null == loadingEnum
          ? _value.loadingEnum
          : loadingEnum // ignore: cast_nullable_to_non_nullable
              as LoadingEnum,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      dialogEvent: freezed == dialogEvent
          ? _value.dialogEvent
          : dialogEvent // ignore: cast_nullable_to_non_nullable
              as AuthDialogEvent?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AuthUser?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthUserCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $AuthUserCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$$_AuthStateCopyWith(
          _$_AuthState value, $Res Function(_$_AuthState) then) =
      __$$_AuthStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingEnum loadingEnum,
      String? message,
      AuthDialogEvent? dialogEvent,
      AuthUser? currentUser});

  @override
  $AuthUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$_AuthStateCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthState>
    implements _$$_AuthStateCopyWith<$Res> {
  __$$_AuthStateCopyWithImpl(
      _$_AuthState _value, $Res Function(_$_AuthState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? message = freezed,
    Object? dialogEvent = freezed,
    Object? currentUser = freezed,
  }) {
    return _then(_$_AuthState(
      loadingEnum: null == loadingEnum
          ? _value.loadingEnum
          : loadingEnum // ignore: cast_nullable_to_non_nullable
              as LoadingEnum,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      dialogEvent: freezed == dialogEvent
          ? _value.dialogEvent
          : dialogEvent // ignore: cast_nullable_to_non_nullable
              as AuthDialogEvent?,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AuthUser?,
    ));
  }
}

/// @nodoc

class _$_AuthState with DiagnosticableTreeMixin implements _AuthState {
  const _$_AuthState(
      {required this.loadingEnum,
      this.message,
      this.dialogEvent,
      this.currentUser});

  @override
  final LoadingEnum loadingEnum;
  @override
  final String? message;
  @override
  final AuthDialogEvent? dialogEvent;
  @override
  final AuthUser? currentUser;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState(loadingEnum: $loadingEnum, message: $message, dialogEvent: $dialogEvent, currentUser: $currentUser)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState'))
      ..add(DiagnosticsProperty('loadingEnum', loadingEnum))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('dialogEvent', dialogEvent))
      ..add(DiagnosticsProperty('currentUser', currentUser));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthState &&
            (identical(other.loadingEnum, loadingEnum) ||
                other.loadingEnum == loadingEnum) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dialogEvent, dialogEvent) ||
                other.dialogEvent == dialogEvent) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, loadingEnum, message, dialogEvent, currentUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      __$$_AuthStateCopyWithImpl<_$_AuthState>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {required final LoadingEnum loadingEnum,
      final String? message,
      final AuthDialogEvent? dialogEvent,
      final AuthUser? currentUser}) = _$_AuthState;

  @override
  LoadingEnum get loadingEnum;
  @override
  String? get message;
  @override
  AuthDialogEvent? get dialogEvent;
  @override
  AuthUser? get currentUser;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
