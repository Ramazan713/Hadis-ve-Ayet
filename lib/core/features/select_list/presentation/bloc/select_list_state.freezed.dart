// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectListState {
  List<SelectableListViewModel> get items => throw _privateConstructorUsedError;
  int get itemId => throw _privateConstructorUsedError;
  SourceTypeEnum get sourceType => throw _privateConstructorUsedError;
  int? get listIdControl => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  bool? get listAffected => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectListStateCopyWith<SelectListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectListStateCopyWith<$Res> {
  factory $SelectListStateCopyWith(
          SelectListState value, $Res Function(SelectListState) then) =
      _$SelectListStateCopyWithImpl<$Res, SelectListState>;
  @useResult
  $Res call(
      {List<SelectableListViewModel> items,
      int itemId,
      SourceTypeEnum sourceType,
      int? listIdControl,
      String? message,
      bool? listAffected});
}

/// @nodoc
class _$SelectListStateCopyWithImpl<$Res, $Val extends SelectListState>
    implements $SelectListStateCopyWith<$Res> {
  _$SelectListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? itemId = null,
    Object? sourceType = null,
    Object? listIdControl = freezed,
    Object? message = freezed,
    Object? listAffected = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SelectableListViewModel>,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as SourceTypeEnum,
      listIdControl: freezed == listIdControl
          ? _value.listIdControl
          : listIdControl // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      listAffected: freezed == listAffected
          ? _value.listAffected
          : listAffected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectListStateImplCopyWith<$Res>
    implements $SelectListStateCopyWith<$Res> {
  factory _$$SelectListStateImplCopyWith(_$SelectListStateImpl value,
          $Res Function(_$SelectListStateImpl) then) =
      __$$SelectListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SelectableListViewModel> items,
      int itemId,
      SourceTypeEnum sourceType,
      int? listIdControl,
      String? message,
      bool? listAffected});
}

/// @nodoc
class __$$SelectListStateImplCopyWithImpl<$Res>
    extends _$SelectListStateCopyWithImpl<$Res, _$SelectListStateImpl>
    implements _$$SelectListStateImplCopyWith<$Res> {
  __$$SelectListStateImplCopyWithImpl(
      _$SelectListStateImpl _value, $Res Function(_$SelectListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? itemId = null,
    Object? sourceType = null,
    Object? listIdControl = freezed,
    Object? message = freezed,
    Object? listAffected = freezed,
  }) {
    return _then(_$SelectListStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SelectableListViewModel>,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as SourceTypeEnum,
      listIdControl: freezed == listIdControl
          ? _value.listIdControl
          : listIdControl // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      listAffected: freezed == listAffected
          ? _value.listAffected
          : listAffected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$SelectListStateImpl
    with DiagnosticableTreeMixin
    implements _SelectListState {
  const _$SelectListStateImpl(
      {required final List<SelectableListViewModel> items,
      required this.itemId,
      required this.sourceType,
      this.listIdControl,
      this.message,
      this.listAffected})
      : _items = items;

  final List<SelectableListViewModel> _items;
  @override
  List<SelectableListViewModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int itemId;
  @override
  final SourceTypeEnum sourceType;
  @override
  final int? listIdControl;
  @override
  final String? message;
  @override
  final bool? listAffected;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectListState(items: $items, itemId: $itemId, sourceType: $sourceType, listIdControl: $listIdControl, message: $message, listAffected: $listAffected)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectListState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('itemId', itemId))
      ..add(DiagnosticsProperty('sourceType', sourceType))
      ..add(DiagnosticsProperty('listIdControl', listIdControl))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('listAffected', listAffected));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectListStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.listIdControl, listIdControl) ||
                other.listIdControl == listIdControl) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.listAffected, listAffected) ||
                other.listAffected == listAffected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      itemId,
      sourceType,
      listIdControl,
      message,
      listAffected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectListStateImplCopyWith<_$SelectListStateImpl> get copyWith =>
      __$$SelectListStateImplCopyWithImpl<_$SelectListStateImpl>(
          this, _$identity);
}

abstract class _SelectListState implements SelectListState {
  const factory _SelectListState(
      {required final List<SelectableListViewModel> items,
      required final int itemId,
      required final SourceTypeEnum sourceType,
      final int? listIdControl,
      final String? message,
      final bool? listAffected}) = _$SelectListStateImpl;

  @override
  List<SelectableListViewModel> get items;
  @override
  int get itemId;
  @override
  SourceTypeEnum get sourceType;
  @override
  int? get listIdControl;
  @override
  String? get message;
  @override
  bool? get listAffected;
  @override
  @JsonKey(ignore: true)
  _$$SelectListStateImplCopyWith<_$SelectListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
