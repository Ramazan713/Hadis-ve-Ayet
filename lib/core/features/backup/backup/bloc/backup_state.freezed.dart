// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BackupState {
  LoadingEnum get loadingEnum => throw _privateConstructorUsedError;
  bool get refreshApp => throw _privateConstructorUsedError;
  ActionResult? get actionResult => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BackupStateCopyWith<BackupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupStateCopyWith<$Res> {
  factory $BackupStateCopyWith(
          BackupState value, $Res Function(BackupState) then) =
      _$BackupStateCopyWithImpl<$Res, BackupState>;
  @useResult
  $Res call(
      {LoadingEnum loadingEnum,
      bool refreshApp,
      ActionResult? actionResult,
      String? message});

  $ActionResultCopyWith<$Res>? get actionResult;
}

/// @nodoc
class _$BackupStateCopyWithImpl<$Res, $Val extends BackupState>
    implements $BackupStateCopyWith<$Res> {
  _$BackupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? refreshApp = null,
    Object? actionResult = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      loadingEnum: null == loadingEnum
          ? _value.loadingEnum
          : loadingEnum // ignore: cast_nullable_to_non_nullable
              as LoadingEnum,
      refreshApp: null == refreshApp
          ? _value.refreshApp
          : refreshApp // ignore: cast_nullable_to_non_nullable
              as bool,
      actionResult: freezed == actionResult
          ? _value.actionResult
          : actionResult // ignore: cast_nullable_to_non_nullable
              as ActionResult?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ActionResultCopyWith<$Res>? get actionResult {
    if (_value.actionResult == null) {
      return null;
    }

    return $ActionResultCopyWith<$Res>(_value.actionResult!, (value) {
      return _then(_value.copyWith(actionResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BackupStateCopyWith<$Res>
    implements $BackupStateCopyWith<$Res> {
  factory _$$_BackupStateCopyWith(
          _$_BackupState value, $Res Function(_$_BackupState) then) =
      __$$_BackupStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingEnum loadingEnum,
      bool refreshApp,
      ActionResult? actionResult,
      String? message});

  @override
  $ActionResultCopyWith<$Res>? get actionResult;
}

/// @nodoc
class __$$_BackupStateCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$_BackupState>
    implements _$$_BackupStateCopyWith<$Res> {
  __$$_BackupStateCopyWithImpl(
      _$_BackupState _value, $Res Function(_$_BackupState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? refreshApp = null,
    Object? actionResult = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_BackupState(
      loadingEnum: null == loadingEnum
          ? _value.loadingEnum
          : loadingEnum // ignore: cast_nullable_to_non_nullable
              as LoadingEnum,
      refreshApp: null == refreshApp
          ? _value.refreshApp
          : refreshApp // ignore: cast_nullable_to_non_nullable
              as bool,
      actionResult: freezed == actionResult
          ? _value.actionResult
          : actionResult // ignore: cast_nullable_to_non_nullable
              as ActionResult?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_BackupState with DiagnosticableTreeMixin implements _BackupState {
  const _$_BackupState(
      {required this.loadingEnum,
      required this.refreshApp,
      this.actionResult,
      this.message});

  @override
  final LoadingEnum loadingEnum;
  @override
  final bool refreshApp;
  @override
  final ActionResult? actionResult;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackupState(loadingEnum: $loadingEnum, refreshApp: $refreshApp, actionResult: $actionResult, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackupState'))
      ..add(DiagnosticsProperty('loadingEnum', loadingEnum))
      ..add(DiagnosticsProperty('refreshApp', refreshApp))
      ..add(DiagnosticsProperty('actionResult', actionResult))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BackupState &&
            (identical(other.loadingEnum, loadingEnum) ||
                other.loadingEnum == loadingEnum) &&
            (identical(other.refreshApp, refreshApp) ||
                other.refreshApp == refreshApp) &&
            (identical(other.actionResult, actionResult) ||
                other.actionResult == actionResult) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, loadingEnum, refreshApp, actionResult, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BackupStateCopyWith<_$_BackupState> get copyWith =>
      __$$_BackupStateCopyWithImpl<_$_BackupState>(this, _$identity);
}

abstract class _BackupState implements BackupState {
  const factory _BackupState(
      {required final LoadingEnum loadingEnum,
      required final bool refreshApp,
      final ActionResult? actionResult,
      final String? message}) = _$_BackupState;

  @override
  LoadingEnum get loadingEnum;
  @override
  bool get refreshApp;
  @override
  ActionResult? get actionResult;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_BackupStateCopyWith<_$_BackupState> get copyWith =>
      throw _privateConstructorUsedError;
}
