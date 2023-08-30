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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectEditionState {
  List<AudioEdition> get items => throw _privateConstructorUsedError;
  AudioQualityEnum get selectedQuality => throw _privateConstructorUsedError;
  AudioQualityEnum get lastSavedQuality => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  AudioEdition? get selectedEdition => throw _privateConstructorUsedError;
  AudioEdition? get lastSavedEdition => throw _privateConstructorUsedError;

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
      {List<AudioEdition> items,
      AudioQualityEnum selectedQuality,
      AudioQualityEnum lastSavedQuality,
      bool isLoading,
      String? message,
      AudioEdition? selectedEdition,
      AudioEdition? lastSavedEdition});
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
    Object? selectedQuality = null,
    Object? lastSavedQuality = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? selectedEdition = freezed,
    Object? lastSavedEdition = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AudioEdition>,
      selectedQuality: null == selectedQuality
          ? _value.selectedQuality
          : selectedQuality // ignore: cast_nullable_to_non_nullable
              as AudioQualityEnum,
      lastSavedQuality: null == lastSavedQuality
          ? _value.lastSavedQuality
          : lastSavedQuality // ignore: cast_nullable_to_non_nullable
              as AudioQualityEnum,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedEdition: freezed == selectedEdition
          ? _value.selectedEdition
          : selectedEdition // ignore: cast_nullable_to_non_nullable
              as AudioEdition?,
      lastSavedEdition: freezed == lastSavedEdition
          ? _value.lastSavedEdition
          : lastSavedEdition // ignore: cast_nullable_to_non_nullable
              as AudioEdition?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectEditionStateCopyWith<$Res>
    implements $SelectEditionStateCopyWith<$Res> {
  factory _$$_SelectEditionStateCopyWith(_$_SelectEditionState value,
          $Res Function(_$_SelectEditionState) then) =
      __$$_SelectEditionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AudioEdition> items,
      AudioQualityEnum selectedQuality,
      AudioQualityEnum lastSavedQuality,
      bool isLoading,
      String? message,
      AudioEdition? selectedEdition,
      AudioEdition? lastSavedEdition});
}

/// @nodoc
class __$$_SelectEditionStateCopyWithImpl<$Res>
    extends _$SelectEditionStateCopyWithImpl<$Res, _$_SelectEditionState>
    implements _$$_SelectEditionStateCopyWith<$Res> {
  __$$_SelectEditionStateCopyWithImpl(
      _$_SelectEditionState _value, $Res Function(_$_SelectEditionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? selectedQuality = null,
    Object? lastSavedQuality = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? selectedEdition = freezed,
    Object? lastSavedEdition = freezed,
  }) {
    return _then(_$_SelectEditionState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AudioEdition>,
      selectedQuality: null == selectedQuality
          ? _value.selectedQuality
          : selectedQuality // ignore: cast_nullable_to_non_nullable
              as AudioQualityEnum,
      lastSavedQuality: null == lastSavedQuality
          ? _value.lastSavedQuality
          : lastSavedQuality // ignore: cast_nullable_to_non_nullable
              as AudioQualityEnum,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedEdition: freezed == selectedEdition
          ? _value.selectedEdition
          : selectedEdition // ignore: cast_nullable_to_non_nullable
              as AudioEdition?,
      lastSavedEdition: freezed == lastSavedEdition
          ? _value.lastSavedEdition
          : lastSavedEdition // ignore: cast_nullable_to_non_nullable
              as AudioEdition?,
    ));
  }
}

/// @nodoc

class _$_SelectEditionState extends _SelectEditionState
    with DiagnosticableTreeMixin {
  const _$_SelectEditionState(
      {required final List<AudioEdition> items,
      required this.selectedQuality,
      required this.lastSavedQuality,
      required this.isLoading,
      this.message,
      this.selectedEdition,
      this.lastSavedEdition})
      : _items = items,
        super._();

  final List<AudioEdition> _items;
  @override
  List<AudioEdition> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final AudioQualityEnum selectedQuality;
  @override
  final AudioQualityEnum lastSavedQuality;
  @override
  final bool isLoading;
  @override
  final String? message;
  @override
  final AudioEdition? selectedEdition;
  @override
  final AudioEdition? lastSavedEdition;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectEditionState(items: $items, selectedQuality: $selectedQuality, lastSavedQuality: $lastSavedQuality, isLoading: $isLoading, message: $message, selectedEdition: $selectedEdition, lastSavedEdition: $lastSavedEdition)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectEditionState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('selectedQuality', selectedQuality))
      ..add(DiagnosticsProperty('lastSavedQuality', lastSavedQuality))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('selectedEdition', selectedEdition))
      ..add(DiagnosticsProperty('lastSavedEdition', lastSavedEdition));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectEditionState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.selectedQuality, selectedQuality) ||
                other.selectedQuality == selectedQuality) &&
            (identical(other.lastSavedQuality, lastSavedQuality) ||
                other.lastSavedQuality == lastSavedQuality) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
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
      selectedQuality,
      lastSavedQuality,
      isLoading,
      message,
      selectedEdition,
      lastSavedEdition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectEditionStateCopyWith<_$_SelectEditionState> get copyWith =>
      __$$_SelectEditionStateCopyWithImpl<_$_SelectEditionState>(
          this, _$identity);
}

abstract class _SelectEditionState extends SelectEditionState {
  const factory _SelectEditionState(
      {required final List<AudioEdition> items,
      required final AudioQualityEnum selectedQuality,
      required final AudioQualityEnum lastSavedQuality,
      required final bool isLoading,
      final String? message,
      final AudioEdition? selectedEdition,
      final AudioEdition? lastSavedEdition}) = _$_SelectEditionState;
  const _SelectEditionState._() : super._();

  @override
  List<AudioEdition> get items;
  @override
  AudioQualityEnum get selectedQuality;
  @override
  AudioQualityEnum get lastSavedQuality;
  @override
  bool get isLoading;
  @override
  String? get message;
  @override
  AudioEdition? get selectedEdition;
  @override
  AudioEdition? get lastSavedEdition;
  @override
  @JsonKey(ignore: true)
  _$$_SelectEditionStateCopyWith<_$_SelectEditionState> get copyWith =>
      throw _privateConstructorUsedError;
}
