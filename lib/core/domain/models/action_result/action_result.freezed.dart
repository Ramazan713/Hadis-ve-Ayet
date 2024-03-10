// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActionResult {
  String get key => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActionResultCopyWith<ActionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionResultCopyWith<$Res> {
  factory $ActionResultCopyWith(
          ActionResult value, $Res Function(ActionResult) then) =
      _$ActionResultCopyWithImpl<$Res, ActionResult>;
  @useResult
  $Res call({String key, bool isSuccess});
}

/// @nodoc
class _$ActionResultCopyWithImpl<$Res, $Val extends ActionResult>
    implements $ActionResultCopyWith<$Res> {
  _$ActionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? isSuccess = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActionResultImplCopyWith<$Res>
    implements $ActionResultCopyWith<$Res> {
  factory _$$ActionResultImplCopyWith(
          _$ActionResultImpl value, $Res Function(_$ActionResultImpl) then) =
      __$$ActionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, bool isSuccess});
}

/// @nodoc
class __$$ActionResultImplCopyWithImpl<$Res>
    extends _$ActionResultCopyWithImpl<$Res, _$ActionResultImpl>
    implements _$$ActionResultImplCopyWith<$Res> {
  __$$ActionResultImplCopyWithImpl(
      _$ActionResultImpl _value, $Res Function(_$ActionResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? isSuccess = null,
  }) {
    return _then(_$ActionResultImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ActionResultImpl with DiagnosticableTreeMixin implements _ActionResult {
  const _$ActionResultImpl({required this.key, required this.isSuccess});

  @override
  final String key;
  @override
  final bool isSuccess;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ActionResult(key: $key, isSuccess: $isSuccess)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ActionResult'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('isSuccess', isSuccess));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionResultImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, isSuccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionResultImplCopyWith<_$ActionResultImpl> get copyWith =>
      __$$ActionResultImplCopyWithImpl<_$ActionResultImpl>(this, _$identity);
}

abstract class _ActionResult implements ActionResult {
  const factory _ActionResult(
      {required final String key,
      required final bool isSuccess}) = _$ActionResultImpl;

  @override
  String get key;
  @override
  bool get isSuccess;
  @override
  @JsonKey(ignore: true)
  _$$ActionResultImplCopyWith<_$ActionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
