// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserInfoModel {
  String get userId => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  Uint8List? get img => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserInfoModelCopyWith<UserInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoModelCopyWith<$Res> {
  factory $UserInfoModelCopyWith(
          UserInfoModel value, $Res Function(UserInfoModel) then) =
      _$UserInfoModelCopyWithImpl<$Res, UserInfoModel>;
  @useResult
  $Res call({String userId, int? id, Uint8List? img});
}

/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res, $Val extends UserInfoModel>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = freezed,
    Object? img = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoModelImplCopyWith<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  factory _$$UserInfoModelImplCopyWith(
          _$UserInfoModelImpl value, $Res Function(_$UserInfoModelImpl) then) =
      __$$UserInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, int? id, Uint8List? img});
}

/// @nodoc
class __$$UserInfoModelImplCopyWithImpl<$Res>
    extends _$UserInfoModelCopyWithImpl<$Res, _$UserInfoModelImpl>
    implements _$$UserInfoModelImplCopyWith<$Res> {
  __$$UserInfoModelImplCopyWithImpl(
      _$UserInfoModelImpl _value, $Res Function(_$UserInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = freezed,
    Object? img = freezed,
  }) {
    return _then(_$UserInfoModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$UserInfoModelImpl
    with DiagnosticableTreeMixin
    implements _UserInfoModel {
  const _$UserInfoModelImpl({required this.userId, this.id, this.img});

  @override
  final String userId;
  @override
  final int? id;
  @override
  final Uint8List? img;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserInfoModel(userId: $userId, id: $id, img: $img)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserInfoModel'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('img', img));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.img, img));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userId, id, const DeepCollectionEquality().hash(img));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      __$$UserInfoModelImplCopyWithImpl<_$UserInfoModelImpl>(this, _$identity);
}

abstract class _UserInfoModel implements UserInfoModel {
  const factory _UserInfoModel(
      {required final String userId,
      final int? id,
      final Uint8List? img}) = _$UserInfoModelImpl;

  @override
  String get userId;
  @override
  int? get id;
  @override
  Uint8List? get img;
  @override
  @JsonKey(ignore: true)
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
