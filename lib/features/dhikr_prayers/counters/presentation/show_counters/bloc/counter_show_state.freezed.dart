// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counter_show_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CounterShowState {
  List<Counter> get counters => throw _privateConstructorUsedError;
  bool get showDetailContents => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CounterShowStateCopyWith<CounterShowState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterShowStateCopyWith<$Res> {
  factory $CounterShowStateCopyWith(
          CounterShowState value, $Res Function(CounterShowState) then) =
      _$CounterShowStateCopyWithImpl<$Res, CounterShowState>;
  @useResult
  $Res call({List<Counter> counters, bool showDetailContents});
}

/// @nodoc
class _$CounterShowStateCopyWithImpl<$Res, $Val extends CounterShowState>
    implements $CounterShowStateCopyWith<$Res> {
  _$CounterShowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counters = null,
    Object? showDetailContents = null,
  }) {
    return _then(_value.copyWith(
      counters: null == counters
          ? _value.counters
          : counters // ignore: cast_nullable_to_non_nullable
              as List<Counter>,
      showDetailContents: null == showDetailContents
          ? _value.showDetailContents
          : showDetailContents // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CounterShowStateCopyWith<$Res>
    implements $CounterShowStateCopyWith<$Res> {
  factory _$$_CounterShowStateCopyWith(
          _$_CounterShowState value, $Res Function(_$_CounterShowState) then) =
      __$$_CounterShowStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Counter> counters, bool showDetailContents});
}

/// @nodoc
class __$$_CounterShowStateCopyWithImpl<$Res>
    extends _$CounterShowStateCopyWithImpl<$Res, _$_CounterShowState>
    implements _$$_CounterShowStateCopyWith<$Res> {
  __$$_CounterShowStateCopyWithImpl(
      _$_CounterShowState _value, $Res Function(_$_CounterShowState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counters = null,
    Object? showDetailContents = null,
  }) {
    return _then(_$_CounterShowState(
      counters: null == counters
          ? _value._counters
          : counters // ignore: cast_nullable_to_non_nullable
              as List<Counter>,
      showDetailContents: null == showDetailContents
          ? _value.showDetailContents
          : showDetailContents // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CounterShowState
    with DiagnosticableTreeMixin
    implements _CounterShowState {
  const _$_CounterShowState(
      {required final List<Counter> counters, required this.showDetailContents})
      : _counters = counters;

  final List<Counter> _counters;
  @override
  List<Counter> get counters {
    if (_counters is EqualUnmodifiableListView) return _counters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_counters);
  }

  @override
  final bool showDetailContents;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CounterShowState(counters: $counters, showDetailContents: $showDetailContents)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CounterShowState'))
      ..add(DiagnosticsProperty('counters', counters))
      ..add(DiagnosticsProperty('showDetailContents', showDetailContents));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CounterShowState &&
            const DeepCollectionEquality().equals(other._counters, _counters) &&
            (identical(other.showDetailContents, showDetailContents) ||
                other.showDetailContents == showDetailContents));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_counters), showDetailContents);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CounterShowStateCopyWith<_$_CounterShowState> get copyWith =>
      __$$_CounterShowStateCopyWithImpl<_$_CounterShowState>(this, _$identity);
}

abstract class _CounterShowState implements CounterShowState {
  const factory _CounterShowState(
      {required final List<Counter> counters,
      required final bool showDetailContents}) = _$_CounterShowState;

  @override
  List<Counter> get counters;
  @override
  bool get showDetailContents;
  @override
  @JsonKey(ignore: true)
  _$$_CounterShowStateCopyWith<_$_CounterShowState> get copyWith =>
      throw _privateConstructorUsedError;
}
