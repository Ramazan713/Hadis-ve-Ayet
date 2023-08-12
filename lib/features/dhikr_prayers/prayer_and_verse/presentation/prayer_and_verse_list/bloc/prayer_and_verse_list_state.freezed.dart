// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_and_verse_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrayerAndVerseListState {
  List<PrayerAndVerse> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerAndVerseListStateCopyWith<PrayerAndVerseListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerAndVerseListStateCopyWith<$Res> {
  factory $PrayerAndVerseListStateCopyWith(PrayerAndVerseListState value,
          $Res Function(PrayerAndVerseListState) then) =
      _$PrayerAndVerseListStateCopyWithImpl<$Res, PrayerAndVerseListState>;
  @useResult
  $Res call({List<PrayerAndVerse> items, bool isLoading});
}

/// @nodoc
class _$PrayerAndVerseListStateCopyWithImpl<$Res,
        $Val extends PrayerAndVerseListState>
    implements $PrayerAndVerseListStateCopyWith<$Res> {
  _$PrayerAndVerseListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PrayerAndVerse>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrayerAndVerseListStateCopyWith<$Res>
    implements $PrayerAndVerseListStateCopyWith<$Res> {
  factory _$$_PrayerAndVerseListStateCopyWith(_$_PrayerAndVerseListState value,
          $Res Function(_$_PrayerAndVerseListState) then) =
      __$$_PrayerAndVerseListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PrayerAndVerse> items, bool isLoading});
}

/// @nodoc
class __$$_PrayerAndVerseListStateCopyWithImpl<$Res>
    extends _$PrayerAndVerseListStateCopyWithImpl<$Res,
        _$_PrayerAndVerseListState>
    implements _$$_PrayerAndVerseListStateCopyWith<$Res> {
  __$$_PrayerAndVerseListStateCopyWithImpl(_$_PrayerAndVerseListState _value,
      $Res Function(_$_PrayerAndVerseListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
  }) {
    return _then(_$_PrayerAndVerseListState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PrayerAndVerse>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PrayerAndVerseListState
    with DiagnosticableTreeMixin
    implements _PrayerAndVerseListState {
  const _$_PrayerAndVerseListState(
      {required final List<PrayerAndVerse> items, this.isLoading = false})
      : _items = items;

  final List<PrayerAndVerse> _items;
  @override
  List<PrayerAndVerse> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerAndVerseListState(items: $items, isLoading: $isLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrayerAndVerseListState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isLoading', isLoading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrayerAndVerseListState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrayerAndVerseListStateCopyWith<_$_PrayerAndVerseListState>
      get copyWith =>
          __$$_PrayerAndVerseListStateCopyWithImpl<_$_PrayerAndVerseListState>(
              this, _$identity);
}

abstract class _PrayerAndVerseListState implements PrayerAndVerseListState {
  const factory _PrayerAndVerseListState(
      {required final List<PrayerAndVerse> items,
      final bool isLoading}) = _$_PrayerAndVerseListState;

  @override
  List<PrayerAndVerse> get items;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_PrayerAndVerseListStateCopyWith<_$_PrayerAndVerseListState>
      get copyWith => throw _privateConstructorUsedError;
}
