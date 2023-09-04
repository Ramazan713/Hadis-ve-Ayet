// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_ready_counter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddReadyCounterState {
  List<PrayerDhikr> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get navigateBack => throw _privateConstructorUsedError;
  bool get showDetails => throw _privateConstructorUsedError;
  PrayerDhikr? get selectedItem => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddReadyCounterStateCopyWith<AddReadyCounterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddReadyCounterStateCopyWith<$Res> {
  factory $AddReadyCounterStateCopyWith(AddReadyCounterState value,
          $Res Function(AddReadyCounterState) then) =
      _$AddReadyCounterStateCopyWithImpl<$Res, AddReadyCounterState>;
  @useResult
  $Res call(
      {List<PrayerDhikr> items,
      bool isLoading,
      bool navigateBack,
      bool showDetails,
      PrayerDhikr? selectedItem,
      String? message});

  $PrayerDhikrCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class _$AddReadyCounterStateCopyWithImpl<$Res,
        $Val extends AddReadyCounterState>
    implements $AddReadyCounterStateCopyWith<$Res> {
  _$AddReadyCounterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? navigateBack = null,
    Object? showDetails = null,
    Object? selectedItem = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PrayerDhikr>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      navigateBack: null == navigateBack
          ? _value.navigateBack
          : navigateBack // ignore: cast_nullable_to_non_nullable
              as bool,
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as PrayerDhikr?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PrayerDhikrCopyWith<$Res>? get selectedItem {
    if (_value.selectedItem == null) {
      return null;
    }

    return $PrayerDhikrCopyWith<$Res>(_value.selectedItem!, (value) {
      return _then(_value.copyWith(selectedItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AddReadyCounterStateCopyWith<$Res>
    implements $AddReadyCounterStateCopyWith<$Res> {
  factory _$$_AddReadyCounterStateCopyWith(_$_AddReadyCounterState value,
          $Res Function(_$_AddReadyCounterState) then) =
      __$$_AddReadyCounterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PrayerDhikr> items,
      bool isLoading,
      bool navigateBack,
      bool showDetails,
      PrayerDhikr? selectedItem,
      String? message});

  @override
  $PrayerDhikrCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class __$$_AddReadyCounterStateCopyWithImpl<$Res>
    extends _$AddReadyCounterStateCopyWithImpl<$Res, _$_AddReadyCounterState>
    implements _$$_AddReadyCounterStateCopyWith<$Res> {
  __$$_AddReadyCounterStateCopyWithImpl(_$_AddReadyCounterState _value,
      $Res Function(_$_AddReadyCounterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? navigateBack = null,
    Object? showDetails = null,
    Object? selectedItem = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_AddReadyCounterState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PrayerDhikr>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      navigateBack: null == navigateBack
          ? _value.navigateBack
          : navigateBack // ignore: cast_nullable_to_non_nullable
              as bool,
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as PrayerDhikr?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AddReadyCounterState
    with DiagnosticableTreeMixin
    implements _AddReadyCounterState {
  const _$_AddReadyCounterState(
      {required final List<PrayerDhikr> items,
      required this.isLoading,
      required this.navigateBack,
      required this.showDetails,
      this.selectedItem,
      this.message})
      : _items = items;

  final List<PrayerDhikr> _items;
  @override
  List<PrayerDhikr> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isLoading;
  @override
  final bool navigateBack;
  @override
  final bool showDetails;
  @override
  final PrayerDhikr? selectedItem;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddReadyCounterState(items: $items, isLoading: $isLoading, navigateBack: $navigateBack, showDetails: $showDetails, selectedItem: $selectedItem, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AddReadyCounterState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('navigateBack', navigateBack))
      ..add(DiagnosticsProperty('showDetails', showDetails))
      ..add(DiagnosticsProperty('selectedItem', selectedItem))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddReadyCounterState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.navigateBack, navigateBack) ||
                other.navigateBack == navigateBack) &&
            (identical(other.showDetails, showDetails) ||
                other.showDetails == showDetails) &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      navigateBack,
      showDetails,
      selectedItem,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddReadyCounterStateCopyWith<_$_AddReadyCounterState> get copyWith =>
      __$$_AddReadyCounterStateCopyWithImpl<_$_AddReadyCounterState>(
          this, _$identity);
}

abstract class _AddReadyCounterState implements AddReadyCounterState {
  const factory _AddReadyCounterState(
      {required final List<PrayerDhikr> items,
      required final bool isLoading,
      required final bool navigateBack,
      required final bool showDetails,
      final PrayerDhikr? selectedItem,
      final String? message}) = _$_AddReadyCounterState;

  @override
  List<PrayerDhikr> get items;
  @override
  bool get isLoading;
  @override
  bool get navigateBack;
  @override
  bool get showDetails;
  @override
  PrayerDhikr? get selectedItem;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_AddReadyCounterStateCopyWith<_$_AddReadyCounterState> get copyWith =>
      throw _privateConstructorUsedError;
}
