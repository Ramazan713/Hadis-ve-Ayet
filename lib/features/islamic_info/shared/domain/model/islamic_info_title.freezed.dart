// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'islamic_info_title.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IslamicInfoTitle {
  String get title => throw _privateConstructorUsedError;
  IslamicInfoType get type => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IslamicInfoTitleCopyWith<IslamicInfoTitle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IslamicInfoTitleCopyWith<$Res> {
  factory $IslamicInfoTitleCopyWith(
          IslamicInfoTitle value, $Res Function(IslamicInfoTitle) then) =
      _$IslamicInfoTitleCopyWithImpl<$Res, IslamicInfoTitle>;
  @useResult
  $Res call({String title, IslamicInfoType type, int? id, String? description});
}

/// @nodoc
class _$IslamicInfoTitleCopyWithImpl<$Res, $Val extends IslamicInfoTitle>
    implements $IslamicInfoTitleCopyWith<$Res> {
  _$IslamicInfoTitleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? type = null,
    Object? id = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IslamicInfoType,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IslamicInfoTitleImplCopyWith<$Res>
    implements $IslamicInfoTitleCopyWith<$Res> {
  factory _$$IslamicInfoTitleImplCopyWith(_$IslamicInfoTitleImpl value,
          $Res Function(_$IslamicInfoTitleImpl) then) =
      __$$IslamicInfoTitleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, IslamicInfoType type, int? id, String? description});
}

/// @nodoc
class __$$IslamicInfoTitleImplCopyWithImpl<$Res>
    extends _$IslamicInfoTitleCopyWithImpl<$Res, _$IslamicInfoTitleImpl>
    implements _$$IslamicInfoTitleImplCopyWith<$Res> {
  __$$IslamicInfoTitleImplCopyWithImpl(_$IslamicInfoTitleImpl _value,
      $Res Function(_$IslamicInfoTitleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? type = null,
    Object? id = freezed,
    Object? description = freezed,
  }) {
    return _then(_$IslamicInfoTitleImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IslamicInfoType,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$IslamicInfoTitleImpl
    with DiagnosticableTreeMixin
    implements _IslamicInfoTitle {
  const _$IslamicInfoTitleImpl(
      {required this.title, required this.type, this.id, this.description});

  @override
  final String title;
  @override
  final IslamicInfoType type;
  @override
  final int? id;
  @override
  final String? description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IslamicInfoTitle(title: $title, type: $type, id: $id, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IslamicInfoTitle'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IslamicInfoTitleImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, type, id, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IslamicInfoTitleImplCopyWith<_$IslamicInfoTitleImpl> get copyWith =>
      __$$IslamicInfoTitleImplCopyWithImpl<_$IslamicInfoTitleImpl>(
          this, _$identity);
}

abstract class _IslamicInfoTitle implements IslamicInfoTitle {
  const factory _IslamicInfoTitle(
      {required final String title,
      required final IslamicInfoType type,
      final int? id,
      final String? description}) = _$IslamicInfoTitleImpl;

  @override
  String get title;
  @override
  IslamicInfoType get type;
  @override
  int? get id;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$IslamicInfoTitleImplCopyWith<_$IslamicInfoTitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
