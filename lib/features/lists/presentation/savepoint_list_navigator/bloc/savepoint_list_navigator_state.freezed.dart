// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'savepoint_list_navigator_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SavePointListNavigatorState {
  bool get hasError => throw _privateConstructorUsedError;
  ListModel? get navigateToList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SavePointListNavigatorStateCopyWith<SavePointListNavigatorState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavePointListNavigatorStateCopyWith<$Res> {
  factory $SavePointListNavigatorStateCopyWith(
          SavePointListNavigatorState value,
          $Res Function(SavePointListNavigatorState) then) =
      _$SavePointListNavigatorStateCopyWithImpl<$Res,
          SavePointListNavigatorState>;
  @useResult
  $Res call({bool hasError, ListModel? navigateToList});
}

/// @nodoc
class _$SavePointListNavigatorStateCopyWithImpl<$Res,
        $Val extends SavePointListNavigatorState>
    implements $SavePointListNavigatorStateCopyWith<$Res> {
  _$SavePointListNavigatorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasError = null,
    Object? navigateToList = freezed,
  }) {
    return _then(_value.copyWith(
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      navigateToList: freezed == navigateToList
          ? _value.navigateToList
          : navigateToList // ignore: cast_nullable_to_non_nullable
              as ListModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SavePointListNavigatorStateCopyWith<$Res>
    implements $SavePointListNavigatorStateCopyWith<$Res> {
  factory _$$_SavePointListNavigatorStateCopyWith(
          _$_SavePointListNavigatorState value,
          $Res Function(_$_SavePointListNavigatorState) then) =
      __$$_SavePointListNavigatorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasError, ListModel? navigateToList});
}

/// @nodoc
class __$$_SavePointListNavigatorStateCopyWithImpl<$Res>
    extends _$SavePointListNavigatorStateCopyWithImpl<$Res,
        _$_SavePointListNavigatorState>
    implements _$$_SavePointListNavigatorStateCopyWith<$Res> {
  __$$_SavePointListNavigatorStateCopyWithImpl(
      _$_SavePointListNavigatorState _value,
      $Res Function(_$_SavePointListNavigatorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasError = null,
    Object? navigateToList = freezed,
  }) {
    return _then(_$_SavePointListNavigatorState(
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      navigateToList: freezed == navigateToList
          ? _value.navigateToList
          : navigateToList // ignore: cast_nullable_to_non_nullable
              as ListModel?,
    ));
  }
}

/// @nodoc

class _$_SavePointListNavigatorState implements _SavePointListNavigatorState {
  const _$_SavePointListNavigatorState(
      {required this.hasError, this.navigateToList});

  @override
  final bool hasError;
  @override
  final ListModel? navigateToList;

  @override
  String toString() {
    return 'SavePointListNavigatorState(hasError: $hasError, navigateToList: $navigateToList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SavePointListNavigatorState &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.navigateToList, navigateToList) ||
                other.navigateToList == navigateToList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasError, navigateToList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SavePointListNavigatorStateCopyWith<_$_SavePointListNavigatorState>
      get copyWith => __$$_SavePointListNavigatorStateCopyWithImpl<
          _$_SavePointListNavigatorState>(this, _$identity);
}

abstract class _SavePointListNavigatorState
    implements SavePointListNavigatorState {
  const factory _SavePointListNavigatorState(
      {required final bool hasError,
      final ListModel? navigateToList}) = _$_SavePointListNavigatorState;

  @override
  bool get hasError;
  @override
  ListModel? get navigateToList;
  @override
  @JsonKey(ignore: true)
  _$$_SavePointListNavigatorStateCopyWith<_$_SavePointListNavigatorState>
      get copyWith => throw _privateConstructorUsedError;
}
