// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_part.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchPart {
  String get text => throw _privateConstructorUsedError;
  bool get isSearchField => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchPartCopyWith<SearchPart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPartCopyWith<$Res> {
  factory $SearchPartCopyWith(
          SearchPart value, $Res Function(SearchPart) then) =
      _$SearchPartCopyWithImpl<$Res, SearchPart>;
  @useResult
  $Res call({String text, bool isSearchField});
}

/// @nodoc
class _$SearchPartCopyWithImpl<$Res, $Val extends SearchPart>
    implements $SearchPartCopyWith<$Res> {
  _$SearchPartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isSearchField = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isSearchField: null == isSearchField
          ? _value.isSearchField
          : isSearchField // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchPartImplCopyWith<$Res>
    implements $SearchPartCopyWith<$Res> {
  factory _$$SearchPartImplCopyWith(
          _$SearchPartImpl value, $Res Function(_$SearchPartImpl) then) =
      __$$SearchPartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, bool isSearchField});
}

/// @nodoc
class __$$SearchPartImplCopyWithImpl<$Res>
    extends _$SearchPartCopyWithImpl<$Res, _$SearchPartImpl>
    implements _$$SearchPartImplCopyWith<$Res> {
  __$$SearchPartImplCopyWithImpl(
      _$SearchPartImpl _value, $Res Function(_$SearchPartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isSearchField = null,
  }) {
    return _then(_$SearchPartImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isSearchField: null == isSearchField
          ? _value.isSearchField
          : isSearchField // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SearchPartImpl with DiagnosticableTreeMixin implements _SearchPart {
  const _$SearchPartImpl({required this.text, required this.isSearchField});

  @override
  final String text;
  @override
  final bool isSearchField;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchPart(text: $text, isSearchField: $isSearchField)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchPart'))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('isSearchField', isSearchField));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchPartImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isSearchField, isSearchField) ||
                other.isSearchField == isSearchField));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, isSearchField);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchPartImplCopyWith<_$SearchPartImpl> get copyWith =>
      __$$SearchPartImplCopyWithImpl<_$SearchPartImpl>(this, _$identity);
}

abstract class _SearchPart implements SearchPart {
  const factory _SearchPart(
      {required final String text,
      required final bool isSearchField}) = _$SearchPartImpl;

  @override
  String get text;
  @override
  bool get isSearchField;
  @override
  @JsonKey(ignore: true)
  _$$SearchPartImplCopyWith<_$SearchPartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
