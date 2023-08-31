// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'show_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShowListState {
  ListTabEnum get currentTab => throw _privateConstructorUsedError;
  bool get searchBarVisible => throw _privateConstructorUsedError;
  List<ListViewModel> get listHadiths => throw _privateConstructorUsedError;
  List<ListViewModel> get listVerses => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShowListStateCopyWith<ShowListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowListStateCopyWith<$Res> {
  factory $ShowListStateCopyWith(
          ShowListState value, $Res Function(ShowListState) then) =
      _$ShowListStateCopyWithImpl<$Res, ShowListState>;
  @useResult
  $Res call(
      {ListTabEnum currentTab,
      bool searchBarVisible,
      List<ListViewModel> listHadiths,
      List<ListViewModel> listVerses,
      String? message});
}

/// @nodoc
class _$ShowListStateCopyWithImpl<$Res, $Val extends ShowListState>
    implements $ShowListStateCopyWith<$Res> {
  _$ShowListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTab = null,
    Object? searchBarVisible = null,
    Object? listHadiths = null,
    Object? listVerses = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as ListTabEnum,
      searchBarVisible: null == searchBarVisible
          ? _value.searchBarVisible
          : searchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      listHadiths: null == listHadiths
          ? _value.listHadiths
          : listHadiths // ignore: cast_nullable_to_non_nullable
              as List<ListViewModel>,
      listVerses: null == listVerses
          ? _value.listVerses
          : listVerses // ignore: cast_nullable_to_non_nullable
              as List<ListViewModel>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShowListStateCopyWith<$Res>
    implements $ShowListStateCopyWith<$Res> {
  factory _$$_ShowListStateCopyWith(
          _$_ShowListState value, $Res Function(_$_ShowListState) then) =
      __$$_ShowListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ListTabEnum currentTab,
      bool searchBarVisible,
      List<ListViewModel> listHadiths,
      List<ListViewModel> listVerses,
      String? message});
}

/// @nodoc
class __$$_ShowListStateCopyWithImpl<$Res>
    extends _$ShowListStateCopyWithImpl<$Res, _$_ShowListState>
    implements _$$_ShowListStateCopyWith<$Res> {
  __$$_ShowListStateCopyWithImpl(
      _$_ShowListState _value, $Res Function(_$_ShowListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTab = null,
    Object? searchBarVisible = null,
    Object? listHadiths = null,
    Object? listVerses = null,
    Object? message = freezed,
  }) {
    return _then(_$_ShowListState(
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as ListTabEnum,
      searchBarVisible: null == searchBarVisible
          ? _value.searchBarVisible
          : searchBarVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      listHadiths: null == listHadiths
          ? _value._listHadiths
          : listHadiths // ignore: cast_nullable_to_non_nullable
              as List<ListViewModel>,
      listVerses: null == listVerses
          ? _value._listVerses
          : listVerses // ignore: cast_nullable_to_non_nullable
              as List<ListViewModel>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ShowListState with DiagnosticableTreeMixin implements _ShowListState {
  const _$_ShowListState(
      {required this.currentTab,
      required this.searchBarVisible,
      required final List<ListViewModel> listHadiths,
      required final List<ListViewModel> listVerses,
      this.message})
      : _listHadiths = listHadiths,
        _listVerses = listVerses;

  @override
  final ListTabEnum currentTab;
  @override
  final bool searchBarVisible;
  final List<ListViewModel> _listHadiths;
  @override
  List<ListViewModel> get listHadiths {
    if (_listHadiths is EqualUnmodifiableListView) return _listHadiths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listHadiths);
  }

  final List<ListViewModel> _listVerses;
  @override
  List<ListViewModel> get listVerses {
    if (_listVerses is EqualUnmodifiableListView) return _listVerses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listVerses);
  }

  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ShowListState(currentTab: $currentTab, searchBarVisible: $searchBarVisible, listHadiths: $listHadiths, listVerses: $listVerses, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ShowListState'))
      ..add(DiagnosticsProperty('currentTab', currentTab))
      ..add(DiagnosticsProperty('searchBarVisible', searchBarVisible))
      ..add(DiagnosticsProperty('listHadiths', listHadiths))
      ..add(DiagnosticsProperty('listVerses', listVerses))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShowListState &&
            (identical(other.currentTab, currentTab) ||
                other.currentTab == currentTab) &&
            (identical(other.searchBarVisible, searchBarVisible) ||
                other.searchBarVisible == searchBarVisible) &&
            const DeepCollectionEquality()
                .equals(other._listHadiths, _listHadiths) &&
            const DeepCollectionEquality()
                .equals(other._listVerses, _listVerses) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentTab,
      searchBarVisible,
      const DeepCollectionEquality().hash(_listHadiths),
      const DeepCollectionEquality().hash(_listVerses),
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShowListStateCopyWith<_$_ShowListState> get copyWith =>
      __$$_ShowListStateCopyWithImpl<_$_ShowListState>(this, _$identity);
}

abstract class _ShowListState implements ShowListState {
  const factory _ShowListState(
      {required final ListTabEnum currentTab,
      required final bool searchBarVisible,
      required final List<ListViewModel> listHadiths,
      required final List<ListViewModel> listVerses,
      final String? message}) = _$_ShowListState;

  @override
  ListTabEnum get currentTab;
  @override
  bool get searchBarVisible;
  @override
  List<ListViewModel> get listHadiths;
  @override
  List<ListViewModel> get listVerses;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_ShowListStateCopyWith<_$_ShowListState> get copyWith =>
      throw _privateConstructorUsedError;
}
