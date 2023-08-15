// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_counter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddCounterState {
  List<PrayerDhikr> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get navigateBack => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddCounterStateCopyWith<AddCounterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddCounterStateCopyWith<$Res> {
  factory $AddCounterStateCopyWith(
          AddCounterState value, $Res Function(AddCounterState) then) =
      _$AddCounterStateCopyWithImpl<$Res, AddCounterState>;
  @useResult
  $Res call(
      {List<PrayerDhikr> items,
      bool isLoading,
      bool navigateBack,
      String? message});
}

/// @nodoc
class _$AddCounterStateCopyWithImpl<$Res, $Val extends AddCounterState>
    implements $AddCounterStateCopyWith<$Res> {
  _$AddCounterStateCopyWithImpl(this._value, this._then);

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
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddCounterStateCopyWith<$Res>
    implements $AddCounterStateCopyWith<$Res> {
  factory _$$_AddCounterStateCopyWith(
          _$_AddCounterState value, $Res Function(_$_AddCounterState) then) =
      __$$_AddCounterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PrayerDhikr> items,
      bool isLoading,
      bool navigateBack,
      String? message});
}

/// @nodoc
class __$$_AddCounterStateCopyWithImpl<$Res>
    extends _$AddCounterStateCopyWithImpl<$Res, _$_AddCounterState>
    implements _$$_AddCounterStateCopyWith<$Res> {
  __$$_AddCounterStateCopyWithImpl(
      _$_AddCounterState _value, $Res Function(_$_AddCounterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? navigateBack = null,
    Object? message = freezed,
  }) {
    return _then(_$_AddCounterState(
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
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AddCounterState
    with DiagnosticableTreeMixin
    implements _AddCounterState {
  const _$_AddCounterState(
      {required final List<PrayerDhikr> items,
      required this.isLoading,
      required this.navigateBack,
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
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AddCounterState(items: $items, isLoading: $isLoading, navigateBack: $navigateBack, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AddCounterState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('navigateBack', navigateBack))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddCounterState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.navigateBack, navigateBack) ||
                other.navigateBack == navigateBack) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      navigateBack,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddCounterStateCopyWith<_$_AddCounterState> get copyWith =>
      __$$_AddCounterStateCopyWithImpl<_$_AddCounterState>(this, _$identity);
}

abstract class _AddCounterState implements AddCounterState {
  const factory _AddCounterState(
      {required final List<PrayerDhikr> items,
      required final bool isLoading,
      required final bool navigateBack,
      final String? message}) = _$_AddCounterState;

  @override
  List<PrayerDhikr> get items;
  @override
  bool get isLoading;
  @override
  bool get navigateBack;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_AddCounterStateCopyWith<_$_AddCounterState> get copyWith =>
      throw _privateConstructorUsedError;
}
