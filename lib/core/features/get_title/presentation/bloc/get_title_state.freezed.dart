// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_title_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetTitleState {
  String? get title => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GetTitleStateCopyWith<GetTitleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetTitleStateCopyWith<$Res> {
  factory $GetTitleStateCopyWith(
          GetTitleState value, $Res Function(GetTitleState) then) =
      _$GetTitleStateCopyWithImpl<$Res, GetTitleState>;
  @useResult
  $Res call({String? title});
}

/// @nodoc
class _$GetTitleStateCopyWithImpl<$Res, $Val extends GetTitleState>
    implements $GetTitleStateCopyWith<$Res> {
  _$GetTitleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetTitleStateImplCopyWith<$Res>
    implements $GetTitleStateCopyWith<$Res> {
  factory _$$GetTitleStateImplCopyWith(
          _$GetTitleStateImpl value, $Res Function(_$GetTitleStateImpl) then) =
      __$$GetTitleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title});
}

/// @nodoc
class __$$GetTitleStateImplCopyWithImpl<$Res>
    extends _$GetTitleStateCopyWithImpl<$Res, _$GetTitleStateImpl>
    implements _$$GetTitleStateImplCopyWith<$Res> {
  __$$GetTitleStateImplCopyWithImpl(
      _$GetTitleStateImpl _value, $Res Function(_$GetTitleStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_$GetTitleStateImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GetTitleStateImpl
    with DiagnosticableTreeMixin
    implements _GetTitleState {
  const _$GetTitleStateImpl({this.title});

  @override
  final String? title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetTitleState(title: $title)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetTitleState'))
      ..add(DiagnosticsProperty('title', title));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetTitleStateImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetTitleStateImplCopyWith<_$GetTitleStateImpl> get copyWith =>
      __$$GetTitleStateImplCopyWithImpl<_$GetTitleStateImpl>(this, _$identity);
}

abstract class _GetTitleState implements GetTitleState {
  const factory _GetTitleState({final String? title}) = _$GetTitleStateImpl;

  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$GetTitleStateImplCopyWith<_$GetTitleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
