// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TopicState {
  bool get searchBarVisible => throw _privateConstructorUsedError;
  List<TopicViewModel> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isDetailOpen => throw _privateConstructorUsedError;
  TopicViewModel? get selectedItem => throw _privateConstructorUsedError;
  int? get jumpToPos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopicStateCopyWith<TopicState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicStateCopyWith<$Res> {
  factory $TopicStateCopyWith(
          TopicState value, $Res Function(TopicState) then) =
      _$TopicStateCopyWithImpl<$Res, TopicState>;
  @useResult
  $Res call(
      {bool searchBarVisible,
      List<TopicViewModel> items,
      bool isLoading,
      bool isDetailOpen,
      TopicViewModel? selectedItem,
      int? jumpToPos});
}

/// @nodoc
class _$TopicStateCopyWithImpl<$Res, $Val extends TopicState>
    implements $TopicStateCopyWith<$Res> {
  _$TopicStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchBarVisible = null,
    Object? items = null,
    Object? isLoading = null,
    Object? isDetailOpen = null,
    Object? selectedItem = freezed,
    Object? jumpToPos = freezed,
  }) {
    return _then(_value.copyWith(
      searchBarVisible: null == searchBarVisible
          ? _value.searchBarVisible
          : searchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TopicViewModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDetailOpen: null == isDetailOpen
          ? _value.isDetailOpen
          : isDetailOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as TopicViewModel?,
      jumpToPos: freezed == jumpToPos
          ? _value.jumpToPos
          : jumpToPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopicStateImplCopyWith<$Res>
    implements $TopicStateCopyWith<$Res> {
  factory _$$TopicStateImplCopyWith(
          _$TopicStateImpl value, $Res Function(_$TopicStateImpl) then) =
      __$$TopicStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool searchBarVisible,
      List<TopicViewModel> items,
      bool isLoading,
      bool isDetailOpen,
      TopicViewModel? selectedItem,
      int? jumpToPos});
}

/// @nodoc
class __$$TopicStateImplCopyWithImpl<$Res>
    extends _$TopicStateCopyWithImpl<$Res, _$TopicStateImpl>
    implements _$$TopicStateImplCopyWith<$Res> {
  __$$TopicStateImplCopyWithImpl(
      _$TopicStateImpl _value, $Res Function(_$TopicStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchBarVisible = null,
    Object? items = null,
    Object? isLoading = null,
    Object? isDetailOpen = null,
    Object? selectedItem = freezed,
    Object? jumpToPos = freezed,
  }) {
    return _then(_$TopicStateImpl(
      searchBarVisible: null == searchBarVisible
          ? _value.searchBarVisible
          : searchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TopicViewModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDetailOpen: null == isDetailOpen
          ? _value.isDetailOpen
          : isDetailOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as TopicViewModel?,
      jumpToPos: freezed == jumpToPos
          ? _value.jumpToPos
          : jumpToPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$TopicStateImpl extends _TopicState {
  const _$TopicStateImpl(
      {required this.searchBarVisible,
      required final List<TopicViewModel> items,
      required this.isLoading,
      required this.isDetailOpen,
      this.selectedItem,
      this.jumpToPos})
      : _items = items,
        super._();

  @override
  final bool searchBarVisible;
  final List<TopicViewModel> _items;
  @override
  List<TopicViewModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isLoading;
  @override
  final bool isDetailOpen;
  @override
  final TopicViewModel? selectedItem;
  @override
  final int? jumpToPos;

  @override
  String toString() {
    return 'TopicState(searchBarVisible: $searchBarVisible, items: $items, isLoading: $isLoading, isDetailOpen: $isDetailOpen, selectedItem: $selectedItem, jumpToPos: $jumpToPos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicStateImpl &&
            (identical(other.searchBarVisible, searchBarVisible) ||
                other.searchBarVisible == searchBarVisible) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isDetailOpen, isDetailOpen) ||
                other.isDetailOpen == isDetailOpen) &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem) &&
            (identical(other.jumpToPos, jumpToPos) ||
                other.jumpToPos == jumpToPos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchBarVisible,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      isDetailOpen,
      selectedItem,
      jumpToPos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicStateImplCopyWith<_$TopicStateImpl> get copyWith =>
      __$$TopicStateImplCopyWithImpl<_$TopicStateImpl>(this, _$identity);
}

abstract class _TopicState extends TopicState {
  const factory _TopicState(
      {required final bool searchBarVisible,
      required final List<TopicViewModel> items,
      required final bool isLoading,
      required final bool isDetailOpen,
      final TopicViewModel? selectedItem,
      final int? jumpToPos}) = _$TopicStateImpl;
  const _TopicState._() : super._();

  @override
  bool get searchBarVisible;
  @override
  List<TopicViewModel> get items;
  @override
  bool get isLoading;
  @override
  bool get isDetailOpen;
  @override
  TopicViewModel? get selectedItem;
  @override
  int? get jumpToPos;
  @override
  @JsonKey(ignore: true)
  _$$TopicStateImplCopyWith<_$TopicStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
