// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'show_custom_prayers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShowCustomPrayersState {
  List<PrayerCustom> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get isSearchBarVisible => throw _privateConstructorUsedError;
  bool get showDetailContents => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShowCustomPrayersStateCopyWith<ShowCustomPrayersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowCustomPrayersStateCopyWith<$Res> {
  factory $ShowCustomPrayersStateCopyWith(ShowCustomPrayersState value,
          $Res Function(ShowCustomPrayersState) then) =
      _$ShowCustomPrayersStateCopyWithImpl<$Res, ShowCustomPrayersState>;
  @useResult
  $Res call(
      {List<PrayerCustom> items,
      bool isLoading,
      String searchQuery,
      bool isSearchBarVisible,
      bool showDetailContents,
      String? message});
}

/// @nodoc
class _$ShowCustomPrayersStateCopyWithImpl<$Res,
        $Val extends ShowCustomPrayersState>
    implements $ShowCustomPrayersStateCopyWith<$Res> {
  _$ShowCustomPrayersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? searchQuery = null,
    Object? isSearchBarVisible = null,
    Object? showDetailContents = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PrayerCustom>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      isSearchBarVisible: null == isSearchBarVisible
          ? _value.isSearchBarVisible
          : isSearchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      showDetailContents: null == showDetailContents
          ? _value.showDetailContents
          : showDetailContents // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShowCustomPrayersStateImplCopyWith<$Res>
    implements $ShowCustomPrayersStateCopyWith<$Res> {
  factory _$$ShowCustomPrayersStateImplCopyWith(
          _$ShowCustomPrayersStateImpl value,
          $Res Function(_$ShowCustomPrayersStateImpl) then) =
      __$$ShowCustomPrayersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PrayerCustom> items,
      bool isLoading,
      String searchQuery,
      bool isSearchBarVisible,
      bool showDetailContents,
      String? message});
}

/// @nodoc
class __$$ShowCustomPrayersStateImplCopyWithImpl<$Res>
    extends _$ShowCustomPrayersStateCopyWithImpl<$Res,
        _$ShowCustomPrayersStateImpl>
    implements _$$ShowCustomPrayersStateImplCopyWith<$Res> {
  __$$ShowCustomPrayersStateImplCopyWithImpl(
      _$ShowCustomPrayersStateImpl _value,
      $Res Function(_$ShowCustomPrayersStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? searchQuery = null,
    Object? isSearchBarVisible = null,
    Object? showDetailContents = null,
    Object? message = freezed,
  }) {
    return _then(_$ShowCustomPrayersStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PrayerCustom>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      isSearchBarVisible: null == isSearchBarVisible
          ? _value.isSearchBarVisible
          : isSearchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      showDetailContents: null == showDetailContents
          ? _value.showDetailContents
          : showDetailContents // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ShowCustomPrayersStateImpl
    with DiagnosticableTreeMixin
    implements _ShowCustomPrayersState {
  const _$ShowCustomPrayersStateImpl(
      {required final List<PrayerCustom> items,
      required this.isLoading,
      required this.searchQuery,
      required this.isSearchBarVisible,
      required this.showDetailContents,
      this.message})
      : _items = items;

  final List<PrayerCustom> _items;
  @override
  List<PrayerCustom> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isLoading;
  @override
  final String searchQuery;
  @override
  final bool isSearchBarVisible;
  @override
  final bool showDetailContents;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ShowCustomPrayersState(items: $items, isLoading: $isLoading, searchQuery: $searchQuery, isSearchBarVisible: $isSearchBarVisible, showDetailContents: $showDetailContents, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ShowCustomPrayersState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('searchQuery', searchQuery))
      ..add(DiagnosticsProperty('isSearchBarVisible', isSearchBarVisible))
      ..add(DiagnosticsProperty('showDetailContents', showDetailContents))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowCustomPrayersStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isSearchBarVisible, isSearchBarVisible) ||
                other.isSearchBarVisible == isSearchBarVisible) &&
            (identical(other.showDetailContents, showDetailContents) ||
                other.showDetailContents == showDetailContents) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      searchQuery,
      isSearchBarVisible,
      showDetailContents,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowCustomPrayersStateImplCopyWith<_$ShowCustomPrayersStateImpl>
      get copyWith => __$$ShowCustomPrayersStateImplCopyWithImpl<
          _$ShowCustomPrayersStateImpl>(this, _$identity);
}

abstract class _ShowCustomPrayersState implements ShowCustomPrayersState {
  const factory _ShowCustomPrayersState(
      {required final List<PrayerCustom> items,
      required final bool isLoading,
      required final String searchQuery,
      required final bool isSearchBarVisible,
      required final bool showDetailContents,
      final String? message}) = _$ShowCustomPrayersStateImpl;

  @override
  List<PrayerCustom> get items;
  @override
  bool get isLoading;
  @override
  String get searchQuery;
  @override
  bool get isSearchBarVisible;
  @override
  bool get showDetailContents;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ShowCustomPrayersStateImplCopyWith<_$ShowCustomPrayersStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
