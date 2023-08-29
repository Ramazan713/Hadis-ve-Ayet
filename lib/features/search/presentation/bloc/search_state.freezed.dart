// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  SearchCriteriaEnum get searchCriteria => throw _privateConstructorUsedError;
  List<History> get histories => throw _privateConstructorUsedError;
  List<SearchResult> get searchResults => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {bool isLoading,
      String searchQuery,
      SearchCriteriaEnum searchCriteria,
      List<History> histories,
      List<SearchResult> searchResults,
      String? message});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? searchQuery = null,
    Object? searchCriteria = null,
    Object? histories = null,
    Object? searchResults = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      searchCriteria: null == searchCriteria
          ? _value.searchCriteria
          : searchCriteria // ignore: cast_nullable_to_non_nullable
              as SearchCriteriaEnum,
      histories: null == histories
          ? _value.histories
          : histories // ignore: cast_nullable_to_non_nullable
              as List<History>,
      searchResults: null == searchResults
          ? _value.searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<SearchResult>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchStateCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$_SearchStateCopyWith(
          _$_SearchState value, $Res Function(_$_SearchState) then) =
      __$$_SearchStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String searchQuery,
      SearchCriteriaEnum searchCriteria,
      List<History> histories,
      List<SearchResult> searchResults,
      String? message});
}

/// @nodoc
class __$$_SearchStateCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$_SearchState>
    implements _$$_SearchStateCopyWith<$Res> {
  __$$_SearchStateCopyWithImpl(
      _$_SearchState _value, $Res Function(_$_SearchState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? searchQuery = null,
    Object? searchCriteria = null,
    Object? histories = null,
    Object? searchResults = null,
    Object? message = freezed,
  }) {
    return _then(_$_SearchState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      searchCriteria: null == searchCriteria
          ? _value.searchCriteria
          : searchCriteria // ignore: cast_nullable_to_non_nullable
              as SearchCriteriaEnum,
      histories: null == histories
          ? _value._histories
          : histories // ignore: cast_nullable_to_non_nullable
              as List<History>,
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<SearchResult>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SearchState extends _SearchState with DiagnosticableTreeMixin {
  const _$_SearchState(
      {required this.isLoading,
      required this.searchQuery,
      required this.searchCriteria,
      required final List<History> histories,
      required final List<SearchResult> searchResults,
      this.message})
      : _histories = histories,
        _searchResults = searchResults,
        super._();

  @override
  final bool isLoading;
  @override
  final String searchQuery;
  @override
  final SearchCriteriaEnum searchCriteria;
  final List<History> _histories;
  @override
  List<History> get histories {
    if (_histories is EqualUnmodifiableListView) return _histories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_histories);
  }

  final List<SearchResult> _searchResults;
  @override
  List<SearchResult> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchState(isLoading: $isLoading, searchQuery: $searchQuery, searchCriteria: $searchCriteria, histories: $histories, searchResults: $searchResults, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('searchQuery', searchQuery))
      ..add(DiagnosticsProperty('searchCriteria', searchCriteria))
      ..add(DiagnosticsProperty('histories', histories))
      ..add(DiagnosticsProperty('searchResults', searchResults))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.searchCriteria, searchCriteria) ||
                other.searchCriteria == searchCriteria) &&
            const DeepCollectionEquality()
                .equals(other._histories, _histories) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      searchQuery,
      searchCriteria,
      const DeepCollectionEquality().hash(_histories),
      const DeepCollectionEquality().hash(_searchResults),
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchStateCopyWith<_$_SearchState> get copyWith =>
      __$$_SearchStateCopyWithImpl<_$_SearchState>(this, _$identity);
}

abstract class _SearchState extends SearchState {
  const factory _SearchState(
      {required final bool isLoading,
      required final String searchQuery,
      required final SearchCriteriaEnum searchCriteria,
      required final List<History> histories,
      required final List<SearchResult> searchResults,
      final String? message}) = _$_SearchState;
  const _SearchState._() : super._();

  @override
  bool get isLoading;
  @override
  String get searchQuery;
  @override
  SearchCriteriaEnum get searchCriteria;
  @override
  List<History> get histories;
  @override
  List<SearchResult> get searchResults;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_SearchStateCopyWith<_$_SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}
