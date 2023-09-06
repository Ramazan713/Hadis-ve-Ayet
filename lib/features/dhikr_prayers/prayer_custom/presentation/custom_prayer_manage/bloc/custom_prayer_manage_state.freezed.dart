// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_prayer_manage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomPrayerManageState {
  bool get navigateBack => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  PrayerCustom? get currentPrayer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomPrayerManageStateCopyWith<CustomPrayerManageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomPrayerManageStateCopyWith<$Res> {
  factory $CustomPrayerManageStateCopyWith(CustomPrayerManageState value,
          $Res Function(CustomPrayerManageState) then) =
      _$CustomPrayerManageStateCopyWithImpl<$Res, CustomPrayerManageState>;
  @useResult
  $Res call(
      {bool navigateBack,
      bool isLoading,
      String? message,
      PrayerCustom? currentPrayer});

  $PrayerCustomCopyWith<$Res>? get currentPrayer;
}

/// @nodoc
class _$CustomPrayerManageStateCopyWithImpl<$Res,
        $Val extends CustomPrayerManageState>
    implements $CustomPrayerManageStateCopyWith<$Res> {
  _$CustomPrayerManageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? navigateBack = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? currentPrayer = freezed,
  }) {
    return _then(_value.copyWith(
      navigateBack: null == navigateBack
          ? _value.navigateBack
          : navigateBack // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPrayer: freezed == currentPrayer
          ? _value.currentPrayer
          : currentPrayer // ignore: cast_nullable_to_non_nullable
              as PrayerCustom?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PrayerCustomCopyWith<$Res>? get currentPrayer {
    if (_value.currentPrayer == null) {
      return null;
    }

    return $PrayerCustomCopyWith<$Res>(_value.currentPrayer!, (value) {
      return _then(_value.copyWith(currentPrayer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CustomPrayerManageStateCopyWith<$Res>
    implements $CustomPrayerManageStateCopyWith<$Res> {
  factory _$$_CustomPrayerManageStateCopyWith(_$_CustomPrayerManageState value,
          $Res Function(_$_CustomPrayerManageState) then) =
      __$$_CustomPrayerManageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool navigateBack,
      bool isLoading,
      String? message,
      PrayerCustom? currentPrayer});

  @override
  $PrayerCustomCopyWith<$Res>? get currentPrayer;
}

/// @nodoc
class __$$_CustomPrayerManageStateCopyWithImpl<$Res>
    extends _$CustomPrayerManageStateCopyWithImpl<$Res,
        _$_CustomPrayerManageState>
    implements _$$_CustomPrayerManageStateCopyWith<$Res> {
  __$$_CustomPrayerManageStateCopyWithImpl(_$_CustomPrayerManageState _value,
      $Res Function(_$_CustomPrayerManageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? navigateBack = null,
    Object? isLoading = null,
    Object? message = freezed,
    Object? currentPrayer = freezed,
  }) {
    return _then(_$_CustomPrayerManageState(
      navigateBack: null == navigateBack
          ? _value.navigateBack
          : navigateBack // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPrayer: freezed == currentPrayer
          ? _value.currentPrayer
          : currentPrayer // ignore: cast_nullable_to_non_nullable
              as PrayerCustom?,
    ));
  }
}

/// @nodoc

class _$_CustomPrayerManageState implements _CustomPrayerManageState {
  const _$_CustomPrayerManageState(
      {required this.navigateBack,
      required this.isLoading,
      this.message,
      this.currentPrayer});

  @override
  final bool navigateBack;
  @override
  final bool isLoading;
  @override
  final String? message;
  @override
  final PrayerCustom? currentPrayer;

  @override
  String toString() {
    return 'CustomPrayerManageState(navigateBack: $navigateBack, isLoading: $isLoading, message: $message, currentPrayer: $currentPrayer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomPrayerManageState &&
            (identical(other.navigateBack, navigateBack) ||
                other.navigateBack == navigateBack) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentPrayer, currentPrayer) ||
                other.currentPrayer == currentPrayer));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, navigateBack, isLoading, message, currentPrayer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomPrayerManageStateCopyWith<_$_CustomPrayerManageState>
      get copyWith =>
          __$$_CustomPrayerManageStateCopyWithImpl<_$_CustomPrayerManageState>(
              this, _$identity);
}

abstract class _CustomPrayerManageState implements CustomPrayerManageState {
  const factory _CustomPrayerManageState(
      {required final bool navigateBack,
      required final bool isLoading,
      final String? message,
      final PrayerCustom? currentPrayer}) = _$_CustomPrayerManageState;

  @override
  bool get navigateBack;
  @override
  bool get isLoading;
  @override
  String? get message;
  @override
  PrayerCustom? get currentPrayer;
  @override
  @JsonKey(ignore: true)
  _$$_CustomPrayerManageStateCopyWith<_$_CustomPrayerManageState>
      get copyWith => throw _privateConstructorUsedError;
}
