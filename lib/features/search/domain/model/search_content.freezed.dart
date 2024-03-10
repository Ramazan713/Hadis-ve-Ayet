// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchContent {
  String get content => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  List<SearchPart> get searchParts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchContentCopyWith<SearchContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchContentCopyWith<$Res> {
  factory $SearchContentCopyWith(
          SearchContent value, $Res Function(SearchContent) then) =
      _$SearchContentCopyWithImpl<$Res, SearchContent>;
  @useResult
  $Res call({String content, String source, List<SearchPart> searchParts});
}

/// @nodoc
class _$SearchContentCopyWithImpl<$Res, $Val extends SearchContent>
    implements $SearchContentCopyWith<$Res> {
  _$SearchContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? source = null,
    Object? searchParts = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      searchParts: null == searchParts
          ? _value.searchParts
          : searchParts // ignore: cast_nullable_to_non_nullable
              as List<SearchPart>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchContentImplCopyWith<$Res>
    implements $SearchContentCopyWith<$Res> {
  factory _$$SearchContentImplCopyWith(
          _$SearchContentImpl value, $Res Function(_$SearchContentImpl) then) =
      __$$SearchContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, String source, List<SearchPart> searchParts});
}

/// @nodoc
class __$$SearchContentImplCopyWithImpl<$Res>
    extends _$SearchContentCopyWithImpl<$Res, _$SearchContentImpl>
    implements _$$SearchContentImplCopyWith<$Res> {
  __$$SearchContentImplCopyWithImpl(
      _$SearchContentImpl _value, $Res Function(_$SearchContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? source = null,
    Object? searchParts = null,
  }) {
    return _then(_$SearchContentImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      searchParts: null == searchParts
          ? _value._searchParts
          : searchParts // ignore: cast_nullable_to_non_nullable
              as List<SearchPart>,
    ));
  }
}

/// @nodoc

class _$SearchContentImpl
    with DiagnosticableTreeMixin
    implements _SearchContent {
  const _$SearchContentImpl(
      {required this.content,
      required this.source,
      required final List<SearchPart> searchParts})
      : _searchParts = searchParts;

  @override
  final String content;
  @override
  final String source;
  final List<SearchPart> _searchParts;
  @override
  List<SearchPart> get searchParts {
    if (_searchParts is EqualUnmodifiableListView) return _searchParts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchParts);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchContent(content: $content, source: $source, searchParts: $searchParts)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchContent'))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('searchParts', searchParts));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchContentImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality()
                .equals(other._searchParts, _searchParts));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, source,
      const DeepCollectionEquality().hash(_searchParts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchContentImplCopyWith<_$SearchContentImpl> get copyWith =>
      __$$SearchContentImplCopyWithImpl<_$SearchContentImpl>(this, _$identity);
}

abstract class _SearchContent implements SearchContent {
  const factory _SearchContent(
      {required final String content,
      required final String source,
      required final List<SearchPart> searchParts}) = _$SearchContentImpl;

  @override
  String get content;
  @override
  String get source;
  @override
  List<SearchPart> get searchParts;
  @override
  @JsonKey(ignore: true)
  _$$SearchContentImplCopyWith<_$SearchContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
