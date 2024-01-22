// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthUser {
  String get uid => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthUserCopyWith<AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserCopyWith<$Res> {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) then) =
      _$AuthUserCopyWithImpl<$Res, AuthUser>;
  @useResult
  $Res call({String uid, String? email, String? displayName, String? photoUrl});
}

/// @nodoc
class _$AuthUserCopyWithImpl<$Res, $Val extends AuthUser>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthUserCopyWith<$Res> implements $AuthUserCopyWith<$Res> {
  factory _$$_AuthUserCopyWith(
          _$_AuthUser value, $Res Function(_$_AuthUser) then) =
      __$$_AuthUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String? email, String? displayName, String? photoUrl});
}

/// @nodoc
class __$$_AuthUserCopyWithImpl<$Res>
    extends _$AuthUserCopyWithImpl<$Res, _$_AuthUser>
    implements _$$_AuthUserCopyWith<$Res> {
  __$$_AuthUserCopyWithImpl(
      _$_AuthUser _value, $Res Function(_$_AuthUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_$_AuthUser(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthUser with DiagnosticableTreeMixin implements _AuthUser {
  const _$_AuthUser(
      {required this.uid, this.email, this.displayName, this.photoUrl});

  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthUser(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthUser'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('photoUrl', photoUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthUser &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, email, displayName, photoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthUserCopyWith<_$_AuthUser> get copyWith =>
      __$$_AuthUserCopyWithImpl<_$_AuthUser>(this, _$identity);
}

abstract class _AuthUser implements AuthUser {
  const factory _AuthUser(
      {required final String uid,
      final String? email,
      final String? displayName,
      final String? photoUrl}) = _$_AuthUser;

  @override
  String get uid;
  @override
  String? get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$$_AuthUserCopyWith<_$_AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}
