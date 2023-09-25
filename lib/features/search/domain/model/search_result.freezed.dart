// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchResult {
  String get title => throw _privateConstructorUsedError;
  List<SearchContent> get searchContents => throw _privateConstructorUsedError;
  int get resultCount => throw _privateConstructorUsedError;
  BookScopeEnum get bookScope => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
          SearchResult value, $Res Function(SearchResult) then) =
      _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call(
      {String title,
      List<SearchContent> searchContents,
      int resultCount,
      BookScopeEnum bookScope});
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? searchContents = null,
    Object? resultCount = null,
    Object? bookScope = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      searchContents: null == searchContents
          ? _value.searchContents
          : searchContents // ignore: cast_nullable_to_non_nullable
              as List<SearchContent>,
      resultCount: null == resultCount
          ? _value.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int,
      bookScope: null == bookScope
          ? _value.bookScope
          : bookScope // ignore: cast_nullable_to_non_nullable
              as BookScopeEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchResultCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$_SearchResultCopyWith(
          _$_SearchResult value, $Res Function(_$_SearchResult) then) =
      __$$_SearchResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<SearchContent> searchContents,
      int resultCount,
      BookScopeEnum bookScope});
}

/// @nodoc
class __$$_SearchResultCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$_SearchResult>
    implements _$$_SearchResultCopyWith<$Res> {
  __$$_SearchResultCopyWithImpl(
      _$_SearchResult _value, $Res Function(_$_SearchResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? searchContents = null,
    Object? resultCount = null,
    Object? bookScope = null,
  }) {
    return _then(_$_SearchResult(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      searchContents: null == searchContents
          ? _value._searchContents
          : searchContents // ignore: cast_nullable_to_non_nullable
              as List<SearchContent>,
      resultCount: null == resultCount
          ? _value.resultCount
          : resultCount // ignore: cast_nullable_to_non_nullable
              as int,
      bookScope: null == bookScope
          ? _value.bookScope
          : bookScope // ignore: cast_nullable_to_non_nullable
              as BookScopeEnum,
    ));
  }
}

/// @nodoc

class _$_SearchResult with DiagnosticableTreeMixin implements _SearchResult {
  const _$_SearchResult(
      {required this.title,
      required final List<SearchContent> searchContents,
      required this.resultCount,
      required this.bookScope})
      : _searchContents = searchContents;

  @override
  final String title;
  final List<SearchContent> _searchContents;
  @override
  List<SearchContent> get searchContents {
    if (_searchContents is EqualUnmodifiableListView) return _searchContents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchContents);
  }

  @override
  final int resultCount;
  @override
  final BookScopeEnum bookScope;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchResult(title: $title, searchContents: $searchContents, resultCount: $resultCount, bookScope: $bookScope)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchResult'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('searchContents', searchContents))
      ..add(DiagnosticsProperty('resultCount', resultCount))
      ..add(DiagnosticsProperty('bookScope', bookScope));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchResult &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._searchContents, _searchContents) &&
            (identical(other.resultCount, resultCount) ||
                other.resultCount == resultCount) &&
            (identical(other.bookScope, bookScope) ||
                other.bookScope == bookScope));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_searchContents),
      resultCount,
      bookScope);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchResultCopyWith<_$_SearchResult> get copyWith =>
      __$$_SearchResultCopyWithImpl<_$_SearchResult>(this, _$identity);
}

abstract class _SearchResult implements SearchResult {
  const factory _SearchResult(
      {required final String title,
      required final List<SearchContent> searchContents,
      required final int resultCount,
      required final BookScopeEnum bookScope}) = _$_SearchResult;

  @override
  String get title;
  @override
  List<SearchContent> get searchContents;
  @override
  int get resultCount;
  @override
  BookScopeEnum get bookScope;
  @override
  @JsonKey(ignore: true)
  _$$_SearchResultCopyWith<_$_SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}
