// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_dhikr_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectDhikrState {
  List<PrayerDhikr> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get showDetails => throw _privateConstructorUsedError;
  PrayerDhikr? get selectedItem => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectDhikrStateCopyWith<SelectDhikrState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectDhikrStateCopyWith<$Res> {
  factory $SelectDhikrStateCopyWith(
          SelectDhikrState value, $Res Function(SelectDhikrState) then) =
      _$SelectDhikrStateCopyWithImpl<$Res, SelectDhikrState>;
  @useResult
  $Res call(
      {List<PrayerDhikr> items,
      bool isLoading,
      bool showDetails,
      PrayerDhikr? selectedItem});

  $PrayerDhikrCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class _$SelectDhikrStateCopyWithImpl<$Res, $Val extends SelectDhikrState>
    implements $SelectDhikrStateCopyWith<$Res> {
  _$SelectDhikrStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? showDetails = null,
    Object? selectedItem = freezed,
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
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as PrayerDhikr?,
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
abstract class _$$_SelectDhikrStateCopyWith<$Res>
    implements $SelectDhikrStateCopyWith<$Res> {
  factory _$$_SelectDhikrStateCopyWith(
          _$_SelectDhikrState value, $Res Function(_$_SelectDhikrState) then) =
      __$$_SelectDhikrStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PrayerDhikr> items,
      bool isLoading,
      bool showDetails,
      PrayerDhikr? selectedItem});

  @override
  $PrayerDhikrCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class __$$_SelectDhikrStateCopyWithImpl<$Res>
    extends _$SelectDhikrStateCopyWithImpl<$Res, _$_SelectDhikrState>
    implements _$$_SelectDhikrStateCopyWith<$Res> {
  __$$_SelectDhikrStateCopyWithImpl(
      _$_SelectDhikrState _value, $Res Function(_$_SelectDhikrState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? showDetails = null,
    Object? selectedItem = freezed,
  }) {
    return _then(_$_SelectDhikrState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PrayerDhikr>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as PrayerDhikr?,
    ));
  }
}

/// @nodoc

class _$_SelectDhikrState
    with DiagnosticableTreeMixin
    implements _SelectDhikrState {
  const _$_SelectDhikrState(
      {required final List<PrayerDhikr> items,
      required this.isLoading,
      required this.showDetails,
      this.selectedItem})
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
  final bool showDetails;
  @override
  final PrayerDhikr? selectedItem;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectDhikrState(items: $items, isLoading: $isLoading, showDetails: $showDetails, selectedItem: $selectedItem)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectDhikrState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('showDetails', showDetails))
      ..add(DiagnosticsProperty('selectedItem', selectedItem));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectDhikrState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.showDetails, showDetails) ||
                other.showDetails == showDetails) &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      showDetails,
      selectedItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectDhikrStateCopyWith<_$_SelectDhikrState> get copyWith =>
      __$$_SelectDhikrStateCopyWithImpl<_$_SelectDhikrState>(this, _$identity);
}

abstract class _SelectDhikrState implements SelectDhikrState {
  const factory _SelectDhikrState(
      {required final List<PrayerDhikr> items,
      required final bool isLoading,
      required final bool showDetails,
      final PrayerDhikr? selectedItem}) = _$_SelectDhikrState;

  @override
  List<PrayerDhikr> get items;
  @override
  bool get isLoading;
  @override
  bool get showDetails;
  @override
  PrayerDhikr? get selectedItem;
  @override
  @JsonKey(ignore: true)
  _$$_SelectDhikrStateCopyWith<_$_SelectDhikrState> get copyWith =>
      throw _privateConstructorUsedError;
}
