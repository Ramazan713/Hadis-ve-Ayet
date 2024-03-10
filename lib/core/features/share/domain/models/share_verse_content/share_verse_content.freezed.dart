// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_verse_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShareVerseContent {
  String? get title => throw _privateConstructorUsedError;
  String? get arabicContent => throw _privateConstructorUsedError;
  String? get meaningContent => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  Map<String, String?>? get others => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShareVerseContentCopyWith<ShareVerseContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareVerseContentCopyWith<$Res> {
  factory $ShareVerseContentCopyWith(
          ShareVerseContent value, $Res Function(ShareVerseContent) then) =
      _$ShareVerseContentCopyWithImpl<$Res, ShareVerseContent>;
  @useResult
  $Res call(
      {String? title,
      String? arabicContent,
      String? meaningContent,
      String? content,
      Map<String, String?>? others});
}

/// @nodoc
class _$ShareVerseContentCopyWithImpl<$Res, $Val extends ShareVerseContent>
    implements $ShareVerseContentCopyWith<$Res> {
  _$ShareVerseContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? arabicContent = freezed,
    Object? meaningContent = freezed,
    Object? content = freezed,
    Object? others = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicContent: freezed == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String?,
      meaningContent: freezed == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      others: freezed == others
          ? _value.others
          : others // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShareVerseContentImplCopyWith<$Res>
    implements $ShareVerseContentCopyWith<$Res> {
  factory _$$ShareVerseContentImplCopyWith(_$ShareVerseContentImpl value,
          $Res Function(_$ShareVerseContentImpl) then) =
      __$$ShareVerseContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? arabicContent,
      String? meaningContent,
      String? content,
      Map<String, String?>? others});
}

/// @nodoc
class __$$ShareVerseContentImplCopyWithImpl<$Res>
    extends _$ShareVerseContentCopyWithImpl<$Res, _$ShareVerseContentImpl>
    implements _$$ShareVerseContentImplCopyWith<$Res> {
  __$$ShareVerseContentImplCopyWithImpl(_$ShareVerseContentImpl _value,
      $Res Function(_$ShareVerseContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? arabicContent = freezed,
    Object? meaningContent = freezed,
    Object? content = freezed,
    Object? others = freezed,
  }) {
    return _then(_$ShareVerseContentImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicContent: freezed == arabicContent
          ? _value.arabicContent
          : arabicContent // ignore: cast_nullable_to_non_nullable
              as String?,
      meaningContent: freezed == meaningContent
          ? _value.meaningContent
          : meaningContent // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      others: freezed == others
          ? _value._others
          : others // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>?,
    ));
  }
}

/// @nodoc

class _$ShareVerseContentImpl extends _ShareVerseContent
    with DiagnosticableTreeMixin {
  const _$ShareVerseContentImpl(
      {this.title,
      this.arabicContent,
      this.meaningContent,
      this.content,
      final Map<String, String?>? others})
      : _others = others,
        super._();

  @override
  final String? title;
  @override
  final String? arabicContent;
  @override
  final String? meaningContent;
  @override
  final String? content;
  final Map<String, String?>? _others;
  @override
  Map<String, String?>? get others {
    final value = _others;
    if (value == null) return null;
    if (_others is EqualUnmodifiableMapView) return _others;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ShareVerseContent(title: $title, arabicContent: $arabicContent, meaningContent: $meaningContent, content: $content, others: $others)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ShareVerseContent'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('arabicContent', arabicContent))
      ..add(DiagnosticsProperty('meaningContent', meaningContent))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('others', others));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareVerseContentImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabicContent, arabicContent) ||
                other.arabicContent == arabicContent) &&
            (identical(other.meaningContent, meaningContent) ||
                other.meaningContent == meaningContent) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._others, _others));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, arabicContent,
      meaningContent, content, const DeepCollectionEquality().hash(_others));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareVerseContentImplCopyWith<_$ShareVerseContentImpl> get copyWith =>
      __$$ShareVerseContentImplCopyWithImpl<_$ShareVerseContentImpl>(
          this, _$identity);
}

abstract class _ShareVerseContent extends ShareVerseContent {
  const factory _ShareVerseContent(
      {final String? title,
      final String? arabicContent,
      final String? meaningContent,
      final String? content,
      final Map<String, String?>? others}) = _$ShareVerseContentImpl;
  const _ShareVerseContent._() : super._();

  @override
  String? get title;
  @override
  String? get arabicContent;
  @override
  String? get meaningContent;
  @override
  String? get content;
  @override
  Map<String, String?>? get others;
  @override
  @JsonKey(ignore: true)
  _$$ShareVerseContentImplCopyWith<_$ShareVerseContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
