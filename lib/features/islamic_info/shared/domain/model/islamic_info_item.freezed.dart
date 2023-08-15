// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'islamic_info_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IslamicInfoItem {
  int get titleId => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IslamicInfoItemCopyWith<IslamicInfoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IslamicInfoItemCopyWith<$Res> {
  factory $IslamicInfoItemCopyWith(
          IslamicInfoItem value, $Res Function(IslamicInfoItem) then) =
      _$IslamicInfoItemCopyWithImpl<$Res, IslamicInfoItem>;
  @useResult
  $Res call({int titleId, int? id, String? name, String? description});
}

/// @nodoc
class _$IslamicInfoItemCopyWithImpl<$Res, $Val extends IslamicInfoItem>
    implements $IslamicInfoItemCopyWith<$Res> {
  _$IslamicInfoItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleId = null,
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      titleId: null == titleId
          ? _value.titleId
          : titleId // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IslamicInfoItemCopyWith<$Res>
    implements $IslamicInfoItemCopyWith<$Res> {
  factory _$$_IslamicInfoItemCopyWith(
          _$_IslamicInfoItem value, $Res Function(_$_IslamicInfoItem) then) =
      __$$_IslamicInfoItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int titleId, int? id, String? name, String? description});
}

/// @nodoc
class __$$_IslamicInfoItemCopyWithImpl<$Res>
    extends _$IslamicInfoItemCopyWithImpl<$Res, _$_IslamicInfoItem>
    implements _$$_IslamicInfoItemCopyWith<$Res> {
  __$$_IslamicInfoItemCopyWithImpl(
      _$_IslamicInfoItem _value, $Res Function(_$_IslamicInfoItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleId = null,
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_IslamicInfoItem(
      titleId: null == titleId
          ? _value.titleId
          : titleId // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_IslamicInfoItem
    with DiagnosticableTreeMixin
    implements _IslamicInfoItem {
  const _$_IslamicInfoItem(
      {required this.titleId, this.id, this.name, this.description});

  @override
  final int titleId;
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IslamicInfoItem(titleId: $titleId, id: $id, name: $name, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IslamicInfoItem'))
      ..add(DiagnosticsProperty('titleId', titleId))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IslamicInfoItem &&
            (identical(other.titleId, titleId) || other.titleId == titleId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, titleId, id, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IslamicInfoItemCopyWith<_$_IslamicInfoItem> get copyWith =>
      __$$_IslamicInfoItemCopyWithImpl<_$_IslamicInfoItem>(this, _$identity);
}

abstract class _IslamicInfoItem implements IslamicInfoItem {
  const factory _IslamicInfoItem(
      {required final int titleId,
      final int? id,
      final String? name,
      final String? description}) = _$_IslamicInfoItem;

  @override
  int get titleId;
  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_IslamicInfoItemCopyWith<_$_IslamicInfoItem> get copyWith =>
      throw _privateConstructorUsedError;
}
