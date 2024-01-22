// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_meta_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BackupMetaState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<BackupMetaModel> get items => throw _privateConstructorUsedError;
  bool get isRefreshDisabled => throw _privateConstructorUsedError;
  String get counter => throw _privateConstructorUsedError;
  BackupMetaModel? get selectedItem => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BackupMetaStateCopyWith<BackupMetaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupMetaStateCopyWith<$Res> {
  factory $BackupMetaStateCopyWith(
          BackupMetaState value, $Res Function(BackupMetaState) then) =
      _$BackupMetaStateCopyWithImpl<$Res, BackupMetaState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<BackupMetaModel> items,
      bool isRefreshDisabled,
      String counter,
      BackupMetaModel? selectedItem,
      String? message});

  $BackupMetaModelCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class _$BackupMetaStateCopyWithImpl<$Res, $Val extends BackupMetaState>
    implements $BackupMetaStateCopyWith<$Res> {
  _$BackupMetaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? items = null,
    Object? isRefreshDisabled = null,
    Object? counter = null,
    Object? selectedItem = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BackupMetaModel>,
      isRefreshDisabled: null == isRefreshDisabled
          ? _value.isRefreshDisabled
          : isRefreshDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as String,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as BackupMetaModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BackupMetaModelCopyWith<$Res>? get selectedItem {
    if (_value.selectedItem == null) {
      return null;
    }

    return $BackupMetaModelCopyWith<$Res>(_value.selectedItem!, (value) {
      return _then(_value.copyWith(selectedItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BackupMetaStateCopyWith<$Res>
    implements $BackupMetaStateCopyWith<$Res> {
  factory _$$_BackupMetaStateCopyWith(
          _$_BackupMetaState value, $Res Function(_$_BackupMetaState) then) =
      __$$_BackupMetaStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<BackupMetaModel> items,
      bool isRefreshDisabled,
      String counter,
      BackupMetaModel? selectedItem,
      String? message});

  @override
  $BackupMetaModelCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class __$$_BackupMetaStateCopyWithImpl<$Res>
    extends _$BackupMetaStateCopyWithImpl<$Res, _$_BackupMetaState>
    implements _$$_BackupMetaStateCopyWith<$Res> {
  __$$_BackupMetaStateCopyWithImpl(
      _$_BackupMetaState _value, $Res Function(_$_BackupMetaState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? items = null,
    Object? isRefreshDisabled = null,
    Object? counter = null,
    Object? selectedItem = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_BackupMetaState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BackupMetaModel>,
      isRefreshDisabled: null == isRefreshDisabled
          ? _value.isRefreshDisabled
          : isRefreshDisabled // ignore: cast_nullable_to_non_nullable
              as bool,
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as String,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as BackupMetaModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_BackupMetaState
    with DiagnosticableTreeMixin
    implements _BackupMetaState {
  const _$_BackupMetaState(
      {required this.isLoading,
      required final List<BackupMetaModel> items,
      required this.isRefreshDisabled,
      required this.counter,
      this.selectedItem,
      this.message})
      : _items = items;

  @override
  final bool isLoading;
  final List<BackupMetaModel> _items;
  @override
  List<BackupMetaModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isRefreshDisabled;
  @override
  final String counter;
  @override
  final BackupMetaModel? selectedItem;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackupMetaState(isLoading: $isLoading, items: $items, isRefreshDisabled: $isRefreshDisabled, counter: $counter, selectedItem: $selectedItem, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackupMetaState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isRefreshDisabled', isRefreshDisabled))
      ..add(DiagnosticsProperty('counter', counter))
      ..add(DiagnosticsProperty('selectedItem', selectedItem))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BackupMetaState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isRefreshDisabled, isRefreshDisabled) ||
                other.isRefreshDisabled == isRefreshDisabled) &&
            (identical(other.counter, counter) || other.counter == counter) &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_items),
      isRefreshDisabled,
      counter,
      selectedItem,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BackupMetaStateCopyWith<_$_BackupMetaState> get copyWith =>
      __$$_BackupMetaStateCopyWithImpl<_$_BackupMetaState>(this, _$identity);
}

abstract class _BackupMetaState implements BackupMetaState {
  const factory _BackupMetaState(
      {required final bool isLoading,
      required final List<BackupMetaModel> items,
      required final bool isRefreshDisabled,
      required final String counter,
      final BackupMetaModel? selectedItem,
      final String? message}) = _$_BackupMetaState;

  @override
  bool get isLoading;
  @override
  List<BackupMetaModel> get items;
  @override
  bool get isRefreshDisabled;
  @override
  String get counter;
  @override
  BackupMetaModel? get selectedItem;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_BackupMetaStateCopyWith<_$_BackupMetaState> get copyWith =>
      throw _privateConstructorUsedError;
}
