// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_audio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BasicAudioState {
  bool get isDownloading => throw _privateConstructorUsedError;
  bool get showAudioPlayerWidget => throw _privateConstructorUsedError;
  ListenAudioServiceState? get audioServiceState =>
      throw _privateConstructorUsedError;
  String? get activeIdentifier => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get audioTag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BasicAudioStateCopyWith<BasicAudioState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasicAudioStateCopyWith<$Res> {
  factory $BasicAudioStateCopyWith(
          BasicAudioState value, $Res Function(BasicAudioState) then) =
      _$BasicAudioStateCopyWithImpl<$Res, BasicAudioState>;
  @useResult
  $Res call(
      {bool isDownloading,
      bool showAudioPlayerWidget,
      ListenAudioServiceState? audioServiceState,
      String? activeIdentifier,
      String? message,
      String? audioTag});
}

/// @nodoc
class _$BasicAudioStateCopyWithImpl<$Res, $Val extends BasicAudioState>
    implements $BasicAudioStateCopyWith<$Res> {
  _$BasicAudioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDownloading = null,
    Object? showAudioPlayerWidget = null,
    Object? audioServiceState = freezed,
    Object? activeIdentifier = freezed,
    Object? message = freezed,
    Object? audioTag = freezed,
  }) {
    return _then(_value.copyWith(
      isDownloading: null == isDownloading
          ? _value.isDownloading
          : isDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      showAudioPlayerWidget: null == showAudioPlayerWidget
          ? _value.showAudioPlayerWidget
          : showAudioPlayerWidget // ignore: cast_nullable_to_non_nullable
              as bool,
      audioServiceState: freezed == audioServiceState
          ? _value.audioServiceState
          : audioServiceState // ignore: cast_nullable_to_non_nullable
              as ListenAudioServiceState?,
      activeIdentifier: freezed == activeIdentifier
          ? _value.activeIdentifier
          : activeIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      audioTag: freezed == audioTag
          ? _value.audioTag
          : audioTag // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BasicAudioStateImplCopyWith<$Res>
    implements $BasicAudioStateCopyWith<$Res> {
  factory _$$BasicAudioStateImplCopyWith(_$BasicAudioStateImpl value,
          $Res Function(_$BasicAudioStateImpl) then) =
      __$$BasicAudioStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDownloading,
      bool showAudioPlayerWidget,
      ListenAudioServiceState? audioServiceState,
      String? activeIdentifier,
      String? message,
      String? audioTag});
}

/// @nodoc
class __$$BasicAudioStateImplCopyWithImpl<$Res>
    extends _$BasicAudioStateCopyWithImpl<$Res, _$BasicAudioStateImpl>
    implements _$$BasicAudioStateImplCopyWith<$Res> {
  __$$BasicAudioStateImplCopyWithImpl(
      _$BasicAudioStateImpl _value, $Res Function(_$BasicAudioStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDownloading = null,
    Object? showAudioPlayerWidget = null,
    Object? audioServiceState = freezed,
    Object? activeIdentifier = freezed,
    Object? message = freezed,
    Object? audioTag = freezed,
  }) {
    return _then(_$BasicAudioStateImpl(
      isDownloading: null == isDownloading
          ? _value.isDownloading
          : isDownloading // ignore: cast_nullable_to_non_nullable
              as bool,
      showAudioPlayerWidget: null == showAudioPlayerWidget
          ? _value.showAudioPlayerWidget
          : showAudioPlayerWidget // ignore: cast_nullable_to_non_nullable
              as bool,
      audioServiceState: freezed == audioServiceState
          ? _value.audioServiceState
          : audioServiceState // ignore: cast_nullable_to_non_nullable
              as ListenAudioServiceState?,
      activeIdentifier: freezed == activeIdentifier
          ? _value.activeIdentifier
          : activeIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      audioTag: freezed == audioTag
          ? _value.audioTag
          : audioTag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BasicAudioStateImpl extends _BasicAudioState
    with DiagnosticableTreeMixin {
  const _$BasicAudioStateImpl(
      {required this.isDownloading,
      required this.showAudioPlayerWidget,
      this.audioServiceState,
      this.activeIdentifier,
      this.message,
      this.audioTag})
      : super._();

  @override
  final bool isDownloading;
  @override
  final bool showAudioPlayerWidget;
  @override
  final ListenAudioServiceState? audioServiceState;
  @override
  final String? activeIdentifier;
  @override
  final String? message;
  @override
  final String? audioTag;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BasicAudioState(isDownloading: $isDownloading, showAudioPlayerWidget: $showAudioPlayerWidget, audioServiceState: $audioServiceState, activeIdentifier: $activeIdentifier, message: $message, audioTag: $audioTag)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BasicAudioState'))
      ..add(DiagnosticsProperty('isDownloading', isDownloading))
      ..add(DiagnosticsProperty('showAudioPlayerWidget', showAudioPlayerWidget))
      ..add(DiagnosticsProperty('audioServiceState', audioServiceState))
      ..add(DiagnosticsProperty('activeIdentifier', activeIdentifier))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('audioTag', audioTag));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasicAudioStateImpl &&
            (identical(other.isDownloading, isDownloading) ||
                other.isDownloading == isDownloading) &&
            (identical(other.showAudioPlayerWidget, showAudioPlayerWidget) ||
                other.showAudioPlayerWidget == showAudioPlayerWidget) &&
            (identical(other.audioServiceState, audioServiceState) ||
                other.audioServiceState == audioServiceState) &&
            (identical(other.activeIdentifier, activeIdentifier) ||
                other.activeIdentifier == activeIdentifier) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.audioTag, audioTag) ||
                other.audioTag == audioTag));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isDownloading,
      showAudioPlayerWidget,
      audioServiceState,
      activeIdentifier,
      message,
      audioTag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BasicAudioStateImplCopyWith<_$BasicAudioStateImpl> get copyWith =>
      __$$BasicAudioStateImplCopyWithImpl<_$BasicAudioStateImpl>(
          this, _$identity);
}

abstract class _BasicAudioState extends BasicAudioState {
  const factory _BasicAudioState(
      {required final bool isDownloading,
      required final bool showAudioPlayerWidget,
      final ListenAudioServiceState? audioServiceState,
      final String? activeIdentifier,
      final String? message,
      final String? audioTag}) = _$BasicAudioStateImpl;
  const _BasicAudioState._() : super._();

  @override
  bool get isDownloading;
  @override
  bool get showAudioPlayerWidget;
  @override
  ListenAudioServiceState? get audioServiceState;
  @override
  String? get activeIdentifier;
  @override
  String? get message;
  @override
  String? get audioTag;
  @override
  @JsonKey(ignore: true)
  _$$BasicAudioStateImplCopyWith<_$BasicAudioStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
