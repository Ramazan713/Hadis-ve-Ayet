// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PaginationState<T extends IPagingItem> {
  int get currentPage => throw _privateConstructorUsedError;
  int get prevPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get totalStaticPages => throw _privateConstructorUsedError;
  List<T> get items => throw _privateConstructorUsedError;
  HashMap<int, List<T>> get itemsByPage => throw _privateConstructorUsedError;
  PagingStatus get status => throw _privateConstructorUsedError;
  int get preFetchDistance => throw _privateConstructorUsedError;
  double get jumpToAlignment => throw _privateConstructorUsedError;
  int get visibleMinPos => throw _privateConstructorUsedError;
  int get visibleMaxPos => throw _privateConstructorUsedError;
  PagingModifiedItem<IPagingItem>? get lastModifiedItem =>
      throw _privateConstructorUsedError;
  int? get jumpToPos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginationStateCopyWith<T, PaginationState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationStateCopyWith<T extends IPagingItem, $Res> {
  factory $PaginationStateCopyWith(
          PaginationState<T> value, $Res Function(PaginationState<T>) then) =
      _$PaginationStateCopyWithImpl<T, $Res, PaginationState<T>>;
  @useResult
  $Res call(
      {int currentPage,
      int prevPage,
      int pageSize,
      int totalItems,
      int totalStaticPages,
      List<T> items,
      HashMap<int, List<T>> itemsByPage,
      PagingStatus status,
      int preFetchDistance,
      double jumpToAlignment,
      int visibleMinPos,
      int visibleMaxPos,
      PagingModifiedItem<IPagingItem>? lastModifiedItem,
      int? jumpToPos});
}

/// @nodoc
class _$PaginationStateCopyWithImpl<T extends IPagingItem, $Res,
        $Val extends PaginationState<T>>
    implements $PaginationStateCopyWith<T, $Res> {
  _$PaginationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? prevPage = null,
    Object? pageSize = null,
    Object? totalItems = null,
    Object? totalStaticPages = null,
    Object? items = null,
    Object? itemsByPage = null,
    Object? status = null,
    Object? preFetchDistance = null,
    Object? jumpToAlignment = null,
    Object? visibleMinPos = null,
    Object? visibleMaxPos = null,
    Object? lastModifiedItem = freezed,
    Object? jumpToPos = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      prevPage: null == prevPage
          ? _value.prevPage
          : prevPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalStaticPages: null == totalStaticPages
          ? _value.totalStaticPages
          : totalStaticPages // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      itemsByPage: null == itemsByPage
          ? _value.itemsByPage
          : itemsByPage // ignore: cast_nullable_to_non_nullable
              as HashMap<int, List<T>>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PagingStatus,
      preFetchDistance: null == preFetchDistance
          ? _value.preFetchDistance
          : preFetchDistance // ignore: cast_nullable_to_non_nullable
              as int,
      jumpToAlignment: null == jumpToAlignment
          ? _value.jumpToAlignment
          : jumpToAlignment // ignore: cast_nullable_to_non_nullable
              as double,
      visibleMinPos: null == visibleMinPos
          ? _value.visibleMinPos
          : visibleMinPos // ignore: cast_nullable_to_non_nullable
              as int,
      visibleMaxPos: null == visibleMaxPos
          ? _value.visibleMaxPos
          : visibleMaxPos // ignore: cast_nullable_to_non_nullable
              as int,
      lastModifiedItem: freezed == lastModifiedItem
          ? _value.lastModifiedItem
          : lastModifiedItem // ignore: cast_nullable_to_non_nullable
              as PagingModifiedItem<IPagingItem>?,
      jumpToPos: freezed == jumpToPos
          ? _value.jumpToPos
          : jumpToPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaginationStateCopyWith<T extends IPagingItem, $Res>
    implements $PaginationStateCopyWith<T, $Res> {
  factory _$$_PaginationStateCopyWith(_$_PaginationState<T> value,
          $Res Function(_$_PaginationState<T>) then) =
      __$$_PaginationStateCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {int currentPage,
      int prevPage,
      int pageSize,
      int totalItems,
      int totalStaticPages,
      List<T> items,
      HashMap<int, List<T>> itemsByPage,
      PagingStatus status,
      int preFetchDistance,
      double jumpToAlignment,
      int visibleMinPos,
      int visibleMaxPos,
      PagingModifiedItem<IPagingItem>? lastModifiedItem,
      int? jumpToPos});
}

/// @nodoc
class __$$_PaginationStateCopyWithImpl<T extends IPagingItem, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$_PaginationState<T>>
    implements _$$_PaginationStateCopyWith<T, $Res> {
  __$$_PaginationStateCopyWithImpl(
      _$_PaginationState<T> _value, $Res Function(_$_PaginationState<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? prevPage = null,
    Object? pageSize = null,
    Object? totalItems = null,
    Object? totalStaticPages = null,
    Object? items = null,
    Object? itemsByPage = null,
    Object? status = null,
    Object? preFetchDistance = null,
    Object? jumpToAlignment = null,
    Object? visibleMinPos = null,
    Object? visibleMaxPos = null,
    Object? lastModifiedItem = freezed,
    Object? jumpToPos = freezed,
  }) {
    return _then(_$_PaginationState<T>(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      prevPage: null == prevPage
          ? _value.prevPage
          : prevPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalStaticPages: null == totalStaticPages
          ? _value.totalStaticPages
          : totalStaticPages // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      itemsByPage: null == itemsByPage
          ? _value.itemsByPage
          : itemsByPage // ignore: cast_nullable_to_non_nullable
              as HashMap<int, List<T>>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PagingStatus,
      preFetchDistance: null == preFetchDistance
          ? _value.preFetchDistance
          : preFetchDistance // ignore: cast_nullable_to_non_nullable
              as int,
      jumpToAlignment: null == jumpToAlignment
          ? _value.jumpToAlignment
          : jumpToAlignment // ignore: cast_nullable_to_non_nullable
              as double,
      visibleMinPos: null == visibleMinPos
          ? _value.visibleMinPos
          : visibleMinPos // ignore: cast_nullable_to_non_nullable
              as int,
      visibleMaxPos: null == visibleMaxPos
          ? _value.visibleMaxPos
          : visibleMaxPos // ignore: cast_nullable_to_non_nullable
              as int,
      lastModifiedItem: freezed == lastModifiedItem
          ? _value.lastModifiedItem
          : lastModifiedItem // ignore: cast_nullable_to_non_nullable
              as PagingModifiedItem<IPagingItem>?,
      jumpToPos: freezed == jumpToPos
          ? _value.jumpToPos
          : jumpToPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_PaginationState<T extends IPagingItem> extends _PaginationState<T>
    with DiagnosticableTreeMixin {
  const _$_PaginationState(
      {required this.currentPage,
      required this.prevPage,
      required this.pageSize,
      required this.totalItems,
      required this.totalStaticPages,
      required final List<T> items,
      required this.itemsByPage,
      required this.status,
      required this.preFetchDistance,
      required this.jumpToAlignment,
      required this.visibleMinPos,
      required this.visibleMaxPos,
      this.lastModifiedItem,
      this.jumpToPos})
      : _items = items,
        super._();

  @override
  final int currentPage;
  @override
  final int prevPage;
  @override
  final int pageSize;
  @override
  final int totalItems;
  @override
  final int totalStaticPages;
  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final HashMap<int, List<T>> itemsByPage;
  @override
  final PagingStatus status;
  @override
  final int preFetchDistance;
  @override
  final double jumpToAlignment;
  @override
  final int visibleMinPos;
  @override
  final int visibleMaxPos;
  @override
  final PagingModifiedItem<IPagingItem>? lastModifiedItem;
  @override
  final int? jumpToPos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaginationState<$T>(currentPage: $currentPage, prevPage: $prevPage, pageSize: $pageSize, totalItems: $totalItems, totalStaticPages: $totalStaticPages, items: $items, itemsByPage: $itemsByPage, status: $status, preFetchDistance: $preFetchDistance, jumpToAlignment: $jumpToAlignment, visibleMinPos: $visibleMinPos, visibleMaxPos: $visibleMaxPos, lastModifiedItem: $lastModifiedItem, jumpToPos: $jumpToPos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaginationState<$T>'))
      ..add(DiagnosticsProperty('currentPage', currentPage))
      ..add(DiagnosticsProperty('prevPage', prevPage))
      ..add(DiagnosticsProperty('pageSize', pageSize))
      ..add(DiagnosticsProperty('totalItems', totalItems))
      ..add(DiagnosticsProperty('totalStaticPages', totalStaticPages))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('itemsByPage', itemsByPage))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('preFetchDistance', preFetchDistance))
      ..add(DiagnosticsProperty('jumpToAlignment', jumpToAlignment))
      ..add(DiagnosticsProperty('visibleMinPos', visibleMinPos))
      ..add(DiagnosticsProperty('visibleMaxPos', visibleMaxPos))
      ..add(DiagnosticsProperty('lastModifiedItem', lastModifiedItem))
      ..add(DiagnosticsProperty('jumpToPos', jumpToPos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaginationState<T> &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.prevPage, prevPage) ||
                other.prevPage == prevPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalStaticPages, totalStaticPages) ||
                other.totalStaticPages == totalStaticPages) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other.itemsByPage, itemsByPage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.preFetchDistance, preFetchDistance) ||
                other.preFetchDistance == preFetchDistance) &&
            (identical(other.jumpToAlignment, jumpToAlignment) ||
                other.jumpToAlignment == jumpToAlignment) &&
            (identical(other.visibleMinPos, visibleMinPos) ||
                other.visibleMinPos == visibleMinPos) &&
            (identical(other.visibleMaxPos, visibleMaxPos) ||
                other.visibleMaxPos == visibleMaxPos) &&
            (identical(other.lastModifiedItem, lastModifiedItem) ||
                other.lastModifiedItem == lastModifiedItem) &&
            (identical(other.jumpToPos, jumpToPos) ||
                other.jumpToPos == jumpToPos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentPage,
      prevPage,
      pageSize,
      totalItems,
      totalStaticPages,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(itemsByPage),
      status,
      preFetchDistance,
      jumpToAlignment,
      visibleMinPos,
      visibleMaxPos,
      lastModifiedItem,
      jumpToPos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaginationStateCopyWith<T, _$_PaginationState<T>> get copyWith =>
      __$$_PaginationStateCopyWithImpl<T, _$_PaginationState<T>>(
          this, _$identity);
}

abstract class _PaginationState<T extends IPagingItem>
    extends PaginationState<T> {
  const factory _PaginationState(
      {required final int currentPage,
      required final int prevPage,
      required final int pageSize,
      required final int totalItems,
      required final int totalStaticPages,
      required final List<T> items,
      required final HashMap<int, List<T>> itemsByPage,
      required final PagingStatus status,
      required final int preFetchDistance,
      required final double jumpToAlignment,
      required final int visibleMinPos,
      required final int visibleMaxPos,
      final PagingModifiedItem<IPagingItem>? lastModifiedItem,
      final int? jumpToPos}) = _$_PaginationState<T>;
  const _PaginationState._() : super._();

  @override
  int get currentPage;
  @override
  int get prevPage;
  @override
  int get pageSize;
  @override
  int get totalItems;
  @override
  int get totalStaticPages;
  @override
  List<T> get items;
  @override
  HashMap<int, List<T>> get itemsByPage;
  @override
  PagingStatus get status;
  @override
  int get preFetchDistance;
  @override
  double get jumpToAlignment;
  @override
  int get visibleMinPos;
  @override
  int get visibleMaxPos;
  @override
  PagingModifiedItem<IPagingItem>? get lastModifiedItem;
  @override
  int? get jumpToPos;
  @override
  @JsonKey(ignore: true)
  _$$_PaginationStateCopyWith<T, _$_PaginationState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
