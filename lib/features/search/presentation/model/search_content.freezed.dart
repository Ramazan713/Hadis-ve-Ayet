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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchContent {
  String get content => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;

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
  $Res call({String content, String source});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchContentCopyWith<$Res>
    implements $SearchContentCopyWith<$Res> {
  factory _$$_SearchContentCopyWith(
          _$_SearchContent value, $Res Function(_$_SearchContent) then) =
      __$$_SearchContentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, String source});
}

/// @nodoc
class __$$_SearchContentCopyWithImpl<$Res>
    extends _$SearchContentCopyWithImpl<$Res, _$_SearchContent>
    implements _$$_SearchContentCopyWith<$Res> {
  __$$_SearchContentCopyWithImpl(
      _$_SearchContent _value, $Res Function(_$_SearchContent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? source = null,
  }) {
    return _then(_$_SearchContent(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SearchContent with DiagnosticableTreeMixin implements _SearchContent {
  const _$_SearchContent({required this.content, required this.source});

  @override
  final String content;
  @override
  final String source;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchContent(content: $content, source: $source)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchContent'))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('source', source));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchContent &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchContentCopyWith<_$_SearchContent> get copyWith =>
      __$$_SearchContentCopyWithImpl<_$_SearchContent>(this, _$identity);
}

abstract class _SearchContent implements SearchContent {
  const factory _SearchContent(
      {required final String content,
      required final String source}) = _$_SearchContent;

  @override
  String get content;
  @override
  String get source;
  @override
  @JsonKey(ignore: true)
  _$$_SearchContentCopyWith<_$_SearchContent> get copyWith =>
      throw _privateConstructorUsedError;
}
