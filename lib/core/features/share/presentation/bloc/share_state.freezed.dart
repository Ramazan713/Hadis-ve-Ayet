// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShareState {
  LoadingEnum get loadingEnum => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ShareUiEvent? get shareUiEvent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShareStateCopyWith<ShareState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareStateCopyWith<$Res> {
  factory $ShareStateCopyWith(
          ShareState value, $Res Function(ShareState) then) =
      _$ShareStateCopyWithImpl<$Res, ShareState>;
  @useResult
  $Res call(
      {LoadingEnum loadingEnum, String? message, ShareUiEvent? shareUiEvent});
}

/// @nodoc
class _$ShareStateCopyWithImpl<$Res, $Val extends ShareState>
    implements $ShareStateCopyWith<$Res> {
  _$ShareStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? message = freezed,
    Object? shareUiEvent = freezed,
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
      shareUiEvent: freezed == shareUiEvent
          ? _value.shareUiEvent
          : shareUiEvent // ignore: cast_nullable_to_non_nullable
              as ShareUiEvent?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShareStateCopyWith<$Res>
    implements $ShareStateCopyWith<$Res> {
  factory _$$_ShareStateCopyWith(
          _$_ShareState value, $Res Function(_$_ShareState) then) =
      __$$_ShareStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoadingEnum loadingEnum, String? message, ShareUiEvent? shareUiEvent});
}

/// @nodoc
class __$$_ShareStateCopyWithImpl<$Res>
    extends _$ShareStateCopyWithImpl<$Res, _$_ShareState>
    implements _$$_ShareStateCopyWith<$Res> {
  __$$_ShareStateCopyWithImpl(
      _$_ShareState _value, $Res Function(_$_ShareState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingEnum = null,
    Object? message = freezed,
    Object? shareUiEvent = freezed,
  }) {
    return _then(_$_ShareState(
      loadingEnum: null == loadingEnum
          ? _value.loadingEnum
          : loadingEnum // ignore: cast_nullable_to_non_nullable
              as LoadingEnum,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      shareUiEvent: freezed == shareUiEvent
          ? _value.shareUiEvent
          : shareUiEvent // ignore: cast_nullable_to_non_nullable
              as ShareUiEvent?,
    ));
  }
}

/// @nodoc

class _$_ShareState with DiagnosticableTreeMixin implements _ShareState {
  const _$_ShareState(
      {required this.loadingEnum, this.message, this.shareUiEvent});

  @override
  final LoadingEnum loadingEnum;
  @override
  final String? message;
  @override
  final ShareUiEvent? shareUiEvent;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ShareState(loadingEnum: $loadingEnum, message: $message, shareUiEvent: $shareUiEvent)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ShareState'))
      ..add(DiagnosticsProperty('loadingEnum', loadingEnum))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('shareUiEvent', shareUiEvent));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShareState &&
            (identical(other.loadingEnum, loadingEnum) ||
                other.loadingEnum == loadingEnum) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.shareUiEvent, shareUiEvent) ||
                other.shareUiEvent == shareUiEvent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, loadingEnum, message, shareUiEvent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShareStateCopyWith<_$_ShareState> get copyWith =>
      __$$_ShareStateCopyWithImpl<_$_ShareState>(this, _$identity);
}

abstract class _ShareState implements ShareState {
  const factory _ShareState(
      {required final LoadingEnum loadingEnum,
      final String? message,
      final ShareUiEvent? shareUiEvent}) = _$_ShareState;

  @override
  LoadingEnum get loadingEnum;
  @override
  String? get message;
  @override
  ShareUiEvent? get shareUiEvent;
  @override
  @JsonKey(ignore: true)
  _$$_ShareStateCopyWith<_$_ShareState> get copyWith =>
      throw _privateConstructorUsedError;
}
