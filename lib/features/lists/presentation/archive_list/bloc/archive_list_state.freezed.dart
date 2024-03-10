// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'archive_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ArchiveListState {
  List<ListViewModel> get listModels => throw _privateConstructorUsedError;
  bool get isDetailOpen => throw _privateConstructorUsedError;
  ListViewModel? get selectedItem => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get jumpToPos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArchiveListStateCopyWith<ArchiveListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArchiveListStateCopyWith<$Res> {
  factory $ArchiveListStateCopyWith(
          ArchiveListState value, $Res Function(ArchiveListState) then) =
      _$ArchiveListStateCopyWithImpl<$Res, ArchiveListState>;
  @useResult
  $Res call(
      {List<ListViewModel> listModels,
      bool isDetailOpen,
      ListViewModel? selectedItem,
      String? message,
      int? jumpToPos});
}

/// @nodoc
class _$ArchiveListStateCopyWithImpl<$Res, $Val extends ArchiveListState>
    implements $ArchiveListStateCopyWith<$Res> {
  _$ArchiveListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listModels = null,
    Object? isDetailOpen = null,
    Object? selectedItem = freezed,
    Object? message = freezed,
    Object? jumpToPos = freezed,
  }) {
    return _then(_value.copyWith(
      listModels: null == listModels
          ? _value.listModels
          : listModels // ignore: cast_nullable_to_non_nullable
              as List<ListViewModel>,
      isDetailOpen: null == isDetailOpen
          ? _value.isDetailOpen
          : isDetailOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as ListViewModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      jumpToPos: freezed == jumpToPos
          ? _value.jumpToPos
          : jumpToPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArchiveListStateImplCopyWith<$Res>
    implements $ArchiveListStateCopyWith<$Res> {
  factory _$$ArchiveListStateImplCopyWith(_$ArchiveListStateImpl value,
          $Res Function(_$ArchiveListStateImpl) then) =
      __$$ArchiveListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ListViewModel> listModels,
      bool isDetailOpen,
      ListViewModel? selectedItem,
      String? message,
      int? jumpToPos});
}

/// @nodoc
class __$$ArchiveListStateImplCopyWithImpl<$Res>
    extends _$ArchiveListStateCopyWithImpl<$Res, _$ArchiveListStateImpl>
    implements _$$ArchiveListStateImplCopyWith<$Res> {
  __$$ArchiveListStateImplCopyWithImpl(_$ArchiveListStateImpl _value,
      $Res Function(_$ArchiveListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listModels = null,
    Object? isDetailOpen = null,
    Object? selectedItem = freezed,
    Object? message = freezed,
    Object? jumpToPos = freezed,
  }) {
    return _then(_$ArchiveListStateImpl(
      listModels: null == listModels
          ? _value._listModels
          : listModels // ignore: cast_nullable_to_non_nullable
              as List<ListViewModel>,
      isDetailOpen: null == isDetailOpen
          ? _value.isDetailOpen
          : isDetailOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedItem: freezed == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as ListViewModel?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      jumpToPos: freezed == jumpToPos
          ? _value.jumpToPos
          : jumpToPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ArchiveListStateImpl implements _ArchiveListState {
  const _$ArchiveListStateImpl(
      {required final List<ListViewModel> listModels,
      required this.isDetailOpen,
      this.selectedItem,
      this.message,
      this.jumpToPos})
      : _listModels = listModels;

  final List<ListViewModel> _listModels;
  @override
  List<ListViewModel> get listModels {
    if (_listModels is EqualUnmodifiableListView) return _listModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listModels);
  }

  @override
  final bool isDetailOpen;
  @override
  final ListViewModel? selectedItem;
  @override
  final String? message;
  @override
  final int? jumpToPos;

  @override
  String toString() {
    return 'ArchiveListState(listModels: $listModels, isDetailOpen: $isDetailOpen, selectedItem: $selectedItem, message: $message, jumpToPos: $jumpToPos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArchiveListStateImpl &&
            const DeepCollectionEquality()
                .equals(other._listModels, _listModels) &&
            (identical(other.isDetailOpen, isDetailOpen) ||
                other.isDetailOpen == isDetailOpen) &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.jumpToPos, jumpToPos) ||
                other.jumpToPos == jumpToPos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_listModels),
      isDetailOpen,
      selectedItem,
      message,
      jumpToPos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArchiveListStateImplCopyWith<_$ArchiveListStateImpl> get copyWith =>
      __$$ArchiveListStateImplCopyWithImpl<_$ArchiveListStateImpl>(
          this, _$identity);
}

abstract class _ArchiveListState implements ArchiveListState {
  const factory _ArchiveListState(
      {required final List<ListViewModel> listModels,
      required final bool isDetailOpen,
      final ListViewModel? selectedItem,
      final String? message,
      final int? jumpToPos}) = _$ArchiveListStateImpl;

  @override
  List<ListViewModel> get listModels;
  @override
  bool get isDetailOpen;
  @override
  ListViewModel? get selectedItem;
  @override
  String? get message;
  @override
  int? get jumpToPos;
  @override
  @JsonKey(ignore: true)
  _$$ArchiveListStateImplCopyWith<_$ArchiveListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
