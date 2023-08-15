// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_counter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ManageCounterState {
  bool get navigateBack => throw _privateConstructorUsedError;
  CounterType get selectedType => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Counter? get currentCounter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManageCounterStateCopyWith<ManageCounterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageCounterStateCopyWith<$Res> {
  factory $ManageCounterStateCopyWith(
          ManageCounterState value, $Res Function(ManageCounterState) then) =
      _$ManageCounterStateCopyWithImpl<$Res, ManageCounterState>;
  @useResult
  $Res call(
      {bool navigateBack,
      CounterType selectedType,
      bool isLoading,
      String? message,
      Counter? currentCounter});

  $CounterCopyWith<$Res>? get currentCounter;
}

/// @nodoc
class _$ManageCounterStateCopyWithImpl<$Res, $Val extends ManageCounterState>
    implements $ManageCounterStateCopyWith<$Res> {
  _$ManageCounterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? navigateBack = null,
    Object? selectedType = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? currentCounter = freezed,
  }) {
    return _then(_value.copyWith(
      navigateBack: null == navigateBack
          ? _value.navigateBack
          : navigateBack // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedType: null == selectedType
          ? _value.selectedType
          : selectedType // ignore: cast_nullable_to_non_nullable
              as CounterType,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      currentCounter: freezed == currentCounter
          ? _value.currentCounter
          : currentCounter // ignore: cast_nullable_to_non_nullable
              as Counter?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CounterCopyWith<$Res>? get currentCounter {
    if (_value.currentCounter == null) {
      return null;
    }

    return $CounterCopyWith<$Res>(_value.currentCounter!, (value) {
      return _then(_value.copyWith(currentCounter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ManageCounterStateCopyWith<$Res>
    implements $ManageCounterStateCopyWith<$Res> {
  factory _$$_ManageCounterStateCopyWith(_$_ManageCounterState value,
          $Res Function(_$_ManageCounterState) then) =
      __$$_ManageCounterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool navigateBack,
      CounterType selectedType,
      bool isLoading,
      String? message,
      Counter? currentCounter});

  @override
  $CounterCopyWith<$Res>? get currentCounter;
}

/// @nodoc
class __$$_ManageCounterStateCopyWithImpl<$Res>
    extends _$ManageCounterStateCopyWithImpl<$Res, _$_ManageCounterState>
    implements _$$_ManageCounterStateCopyWith<$Res> {
  __$$_ManageCounterStateCopyWithImpl(
      _$_ManageCounterState _value, $Res Function(_$_ManageCounterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? navigateBack = null,
    Object? selectedType = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? currentCounter = freezed,
  }) {
    return _then(_$_ManageCounterState(
      navigateBack: null == navigateBack
          ? _value.navigateBack
          : navigateBack // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedType: null == selectedType
          ? _value.selectedType
          : selectedType // ignore: cast_nullable_to_non_nullable
              as CounterType,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      currentCounter: freezed == currentCounter
          ? _value.currentCounter
          : currentCounter // ignore: cast_nullable_to_non_nullable
              as Counter?,
    ));
  }
}

/// @nodoc

class _$_ManageCounterState
    with DiagnosticableTreeMixin
    implements _ManageCounterState {
  const _$_ManageCounterState(
      {required this.navigateBack,
      required this.selectedType,
      required this.isLoading,
      this.message,
      this.currentCounter});

  @override
  final bool navigateBack;
  @override
  final CounterType selectedType;
  @override
  final bool isLoading;
  @override
  final String? message;
  @override
  final Counter? currentCounter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ManageCounterState(navigateBack: $navigateBack, selectedType: $selectedType, isLoading: $isLoading, message: $message, currentCounter: $currentCounter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ManageCounterState'))
      ..add(DiagnosticsProperty('navigateBack', navigateBack))
      ..add(DiagnosticsProperty('selectedType', selectedType))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('currentCounter', currentCounter));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ManageCounterState &&
            (identical(other.navigateBack, navigateBack) ||
                other.navigateBack == navigateBack) &&
            (identical(other.selectedType, selectedType) ||
                other.selectedType == selectedType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentCounter, currentCounter) ||
                other.currentCounter == currentCounter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, navigateBack, selectedType,
      isLoading, message, currentCounter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ManageCounterStateCopyWith<_$_ManageCounterState> get copyWith =>
      __$$_ManageCounterStateCopyWithImpl<_$_ManageCounterState>(
          this, _$identity);
}

abstract class _ManageCounterState implements ManageCounterState {
  const factory _ManageCounterState(
      {required final bool navigateBack,
      required final CounterType selectedType,
      required final bool isLoading,
      final String? message,
      final Counter? currentCounter}) = _$_ManageCounterState;

  @override
  bool get navigateBack;
  @override
  CounterType get selectedType;
  @override
  bool get isLoading;
  @override
  String? get message;
  @override
  Counter? get currentCounter;
  @override
  @JsonKey(ignore: true)
  _$$_ManageCounterStateCopyWith<_$_ManageCounterState> get copyWith =>
      throw _privateConstructorUsedError;
}
