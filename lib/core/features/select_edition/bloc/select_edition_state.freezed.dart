// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_edition_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectEditionState {
  List<SelectAudioEdition> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  BasicAudioRequest get audioRequest => throw _privateConstructorUsedError;
  String get audioRequestSource => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  SelectAudioEdition? get selectedEdition => throw _privateConstructorUsedError;
  SelectAudioEdition? get lastSavedEdition =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectEditionStateCopyWith<SelectEditionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectEditionStateCopyWith<$Res> {
  factory $SelectEditionStateCopyWith(
          SelectEditionState value, $Res Function(SelectEditionState) then) =
      _$SelectEditionStateCopyWithImpl<$Res, SelectEditionState>;
  @useResult
  $Res call(
      {List<SelectAudioEdition> items,
      bool isLoading,
      BasicAudioRequest audioRequest,
      String audioRequestSource,
      String? message,
      SelectAudioEdition? selectedEdition,
      SelectAudioEdition? lastSavedEdition});

  $BasicAudioRequestCopyWith<$Res> get audioRequest;
  $SelectAudioEditionCopyWith<$Res>? get selectedEdition;
  $SelectAudioEditionCopyWith<$Res>? get lastSavedEdition;
}

/// @nodoc
class _$SelectEditionStateCopyWithImpl<$Res, $Val extends SelectEditionState>
    implements $SelectEditionStateCopyWith<$Res> {
  _$SelectEditionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? audioRequest = null,
    Object? audioRequestSource = null,
    Object? message = freezed,
    Object? selectedEdition = freezed,
    Object? lastSavedEdition = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SelectAudioEdition>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      audioRequest: null == audioRequest
          ? _value.audioRequest
          : audioRequest // ignore: cast_nullable_to_non_nullable
              as BasicAudioRequest,
      audioRequestSource: null == audioRequestSource
          ? _value.audioRequestSource
          : audioRequestSource // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedEdition: freezed == selectedEdition
          ? _value.selectedEdition
          : selectedEdition // ignore: cast_nullable_to_non_nullable
              as SelectAudioEdition?,
      lastSavedEdition: freezed == lastSavedEdition
          ? _value.lastSavedEdition
          : lastSavedEdition // ignore: cast_nullable_to_non_nullable
              as SelectAudioEdition?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BasicAudioRequestCopyWith<$Res> get audioRequest {
    return $BasicAudioRequestCopyWith<$Res>(_value.audioRequest, (value) {
      return _then(_value.copyWith(audioRequest: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SelectAudioEditionCopyWith<$Res>? get selectedEdition {
    if (_value.selectedEdition == null) {
      return null;
    }

    return $SelectAudioEditionCopyWith<$Res>(_value.selectedEdition!, (value) {
      return _then(_value.copyWith(selectedEdition: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SelectAudioEditionCopyWith<$Res>? get lastSavedEdition {
    if (_value.lastSavedEdition == null) {
      return null;
    }

    return $SelectAudioEditionCopyWith<$Res>(_value.lastSavedEdition!, (value) {
      return _then(_value.copyWith(lastSavedEdition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SelectEditionStateImplCopyWith<$Res>
    implements $SelectEditionStateCopyWith<$Res> {
  factory _$$SelectEditionStateImplCopyWith(_$SelectEditionStateImpl value,
          $Res Function(_$SelectEditionStateImpl) then) =
      __$$SelectEditionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SelectAudioEdition> items,
      bool isLoading,
      BasicAudioRequest audioRequest,
      String audioRequestSource,
      String? message,
      SelectAudioEdition? selectedEdition,
      SelectAudioEdition? lastSavedEdition});

  @override
  $BasicAudioRequestCopyWith<$Res> get audioRequest;
  @override
  $SelectAudioEditionCopyWith<$Res>? get selectedEdition;
  @override
  $SelectAudioEditionCopyWith<$Res>? get lastSavedEdition;
}

/// @nodoc
class __$$SelectEditionStateImplCopyWithImpl<$Res>
    extends _$SelectEditionStateCopyWithImpl<$Res, _$SelectEditionStateImpl>
    implements _$$SelectEditionStateImplCopyWith<$Res> {
  __$$SelectEditionStateImplCopyWithImpl(_$SelectEditionStateImpl _value,
      $Res Function(_$SelectEditionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? audioRequest = null,
    Object? audioRequestSource = null,
    Object? message = freezed,
    Object? selectedEdition = freezed,
    Object? lastSavedEdition = freezed,
  }) {
    return _then(_$SelectEditionStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SelectAudioEdition>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      audioRequest: null == audioRequest
          ? _value.audioRequest
          : audioRequest // ignore: cast_nullable_to_non_nullable
              as BasicAudioRequest,
      audioRequestSource: null == audioRequestSource
          ? _value.audioRequestSource
          : audioRequestSource // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedEdition: freezed == selectedEdition
          ? _value.selectedEdition
          : selectedEdition // ignore: cast_nullable_to_non_nullable
              as SelectAudioEdition?,
      lastSavedEdition: freezed == lastSavedEdition
          ? _value.lastSavedEdition
          : lastSavedEdition // ignore: cast_nullable_to_non_nullable
              as SelectAudioEdition?,
    ));
  }
}

/// @nodoc

class _$SelectEditionStateImpl extends _SelectEditionState
    with DiagnosticableTreeMixin {
  const _$SelectEditionStateImpl(
      {required final List<SelectAudioEdition> items,
      required this.isLoading,
      required this.audioRequest,
      required this.audioRequestSource,
      this.message,
      this.selectedEdition,
      this.lastSavedEdition})
      : _items = items,
        super._();

  final List<SelectAudioEdition> _items;
  @override
  List<SelectAudioEdition> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isLoading;
  @override
  final BasicAudioRequest audioRequest;
  @override
  final String audioRequestSource;
  @override
  final String? message;
  @override
  final SelectAudioEdition? selectedEdition;
  @override
  final SelectAudioEdition? lastSavedEdition;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectEditionState(items: $items, isLoading: $isLoading, audioRequest: $audioRequest, audioRequestSource: $audioRequestSource, message: $message, selectedEdition: $selectedEdition, lastSavedEdition: $lastSavedEdition)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectEditionState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('audioRequest', audioRequest))
      ..add(DiagnosticsProperty('audioRequestSource', audioRequestSource))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('selectedEdition', selectedEdition))
      ..add(DiagnosticsProperty('lastSavedEdition', lastSavedEdition));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectEditionStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.audioRequest, audioRequest) ||
                other.audioRequest == audioRequest) &&
            (identical(other.audioRequestSource, audioRequestSource) ||
                other.audioRequestSource == audioRequestSource) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.selectedEdition, selectedEdition) ||
                other.selectedEdition == selectedEdition) &&
            (identical(other.lastSavedEdition, lastSavedEdition) ||
                other.lastSavedEdition == lastSavedEdition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      audioRequest,
      audioRequestSource,
      message,
      selectedEdition,
      lastSavedEdition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectEditionStateImplCopyWith<_$SelectEditionStateImpl> get copyWith =>
      __$$SelectEditionStateImplCopyWithImpl<_$SelectEditionStateImpl>(
          this, _$identity);
}

abstract class _SelectEditionState extends SelectEditionState {
  const factory _SelectEditionState(
      {required final List<SelectAudioEdition> items,
      required final bool isLoading,
      required final BasicAudioRequest audioRequest,
      required final String audioRequestSource,
      final String? message,
      final SelectAudioEdition? selectedEdition,
      final SelectAudioEdition? lastSavedEdition}) = _$SelectEditionStateImpl;
  const _SelectEditionState._() : super._();

  @override
  List<SelectAudioEdition> get items;
  @override
  bool get isLoading;
  @override
  BasicAudioRequest get audioRequest;
  @override
  String get audioRequestSource;
  @override
  String? get message;
  @override
  SelectAudioEdition? get selectedEdition;
  @override
  SelectAudioEdition? get lastSavedEdition;
  @override
  @JsonKey(ignore: true)
  _$$SelectEditionStateImplCopyWith<_$SelectEditionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
