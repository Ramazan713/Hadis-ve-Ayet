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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_GetTitleStateCopyWith<$Res>
    implements $GetTitleStateCopyWith<$Res> {
  factory _$$_GetTitleStateCopyWith(
          _$_GetTitleState value, $Res Function(_$_GetTitleState) then) =
      __$$_GetTitleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title});
}

/// @nodoc
class __$$_GetTitleStateCopyWithImpl<$Res>
    extends _$GetTitleStateCopyWithImpl<$Res, _$_GetTitleState>
    implements _$$_GetTitleStateCopyWith<$Res> {
  __$$_GetTitleStateCopyWithImpl(
      _$_GetTitleState _value, $Res Function(_$_GetTitleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_$_GetTitleState(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_GetTitleState with DiagnosticableTreeMixin implements _GetTitleState {
  const _$_GetTitleState({this.title});

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetTitleState &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetTitleStateCopyWith<_$_GetTitleState> get copyWith =>
      __$$_GetTitleStateCopyWithImpl<_$_GetTitleState>(this, _$identity);
}

abstract class _GetTitleState implements GetTitleState {
  const factory _GetTitleState({final String? title}) = _$_GetTitleState;

  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$_GetTitleStateCopyWith<_$_GetTitleState> get copyWith =>
      throw _privateConstructorUsedError;
}
