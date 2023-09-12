// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_prayer_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomPrayerDetailState {
  FontModel get fontModel => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  PrayerUnit<PrayerCustom>? get prayerUnit =>
      throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomPrayerDetailStateCopyWith<CustomPrayerDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomPrayerDetailStateCopyWith<$Res> {
  factory $CustomPrayerDetailStateCopyWith(CustomPrayerDetailState value,
          $Res Function(CustomPrayerDetailState) then) =
      _$CustomPrayerDetailStateCopyWithImpl<$Res, CustomPrayerDetailState>;
  @useResult
  $Res call(
      {FontModel fontModel,
      bool isLoading,
      PrayerUnit<PrayerCustom>? prayerUnit,
      String? message});

  $FontModelCopyWith<$Res> get fontModel;
}

/// @nodoc
class _$CustomPrayerDetailStateCopyWithImpl<$Res,
        $Val extends CustomPrayerDetailState>
    implements $CustomPrayerDetailStateCopyWith<$Res> {
  _$CustomPrayerDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontModel = null,
    Object? isLoading = null,
    Object? prayerUnit = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      fontModel: null == fontModel
          ? _value.fontModel
          : fontModel // ignore: cast_nullable_to_non_nullable
              as FontModel,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      prayerUnit: freezed == prayerUnit
          ? _value.prayerUnit
          : prayerUnit // ignore: cast_nullable_to_non_nullable
              as PrayerUnit<PrayerCustom>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FontModelCopyWith<$Res> get fontModel {
    return $FontModelCopyWith<$Res>(_value.fontModel, (value) {
      return _then(_value.copyWith(fontModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CustomPrayerDetailStateCopyWith<$Res>
    implements $CustomPrayerDetailStateCopyWith<$Res> {
  factory _$$_CustomPrayerDetailStateCopyWith(_$_CustomPrayerDetailState value,
          $Res Function(_$_CustomPrayerDetailState) then) =
      __$$_CustomPrayerDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FontModel fontModel,
      bool isLoading,
      PrayerUnit<PrayerCustom>? prayerUnit,
      String? message});

  @override
  $FontModelCopyWith<$Res> get fontModel;
}

/// @nodoc
class __$$_CustomPrayerDetailStateCopyWithImpl<$Res>
    extends _$CustomPrayerDetailStateCopyWithImpl<$Res,
        _$_CustomPrayerDetailState>
    implements _$$_CustomPrayerDetailStateCopyWith<$Res> {
  __$$_CustomPrayerDetailStateCopyWithImpl(_$_CustomPrayerDetailState _value,
      $Res Function(_$_CustomPrayerDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontModel = null,
    Object? isLoading = null,
    Object? prayerUnit = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_CustomPrayerDetailState(
      fontModel: null == fontModel
          ? _value.fontModel
          : fontModel // ignore: cast_nullable_to_non_nullable
              as FontModel,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      prayerUnit: freezed == prayerUnit
          ? _value.prayerUnit
          : prayerUnit // ignore: cast_nullable_to_non_nullable
              as PrayerUnit<PrayerCustom>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_CustomPrayerDetailState extends _CustomPrayerDetailState
    with DiagnosticableTreeMixin {
  const _$_CustomPrayerDetailState(
      {required this.fontModel,
      required this.isLoading,
      this.prayerUnit,
      this.message})
      : super._();

  @override
  final FontModel fontModel;
  @override
  final bool isLoading;
  @override
  final PrayerUnit<PrayerCustom>? prayerUnit;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomPrayerDetailState(fontModel: $fontModel, isLoading: $isLoading, prayerUnit: $prayerUnit, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomPrayerDetailState'))
      ..add(DiagnosticsProperty('fontModel', fontModel))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('prayerUnit', prayerUnit))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomPrayerDetailState &&
            (identical(other.fontModel, fontModel) ||
                other.fontModel == fontModel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.prayerUnit, prayerUnit) ||
                other.prayerUnit == prayerUnit) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fontModel, isLoading, prayerUnit, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomPrayerDetailStateCopyWith<_$_CustomPrayerDetailState>
      get copyWith =>
          __$$_CustomPrayerDetailStateCopyWithImpl<_$_CustomPrayerDetailState>(
              this, _$identity);
}

abstract class _CustomPrayerDetailState extends CustomPrayerDetailState {
  const factory _CustomPrayerDetailState(
      {required final FontModel fontModel,
      required final bool isLoading,
      final PrayerUnit<PrayerCustom>? prayerUnit,
      final String? message}) = _$_CustomPrayerDetailState;
  const _CustomPrayerDetailState._() : super._();

  @override
  FontModel get fontModel;
  @override
  bool get isLoading;
  @override
  PrayerUnit<PrayerCustom>? get prayerUnit;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_CustomPrayerDetailStateCopyWith<_$_CustomPrayerDetailState>
      get copyWith => throw _privateConstructorUsedError;
}
