// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdState {
  bool get showAd => throw _privateConstructorUsedError;
  bool get loadAd => throw _privateConstructorUsedError;
  int get counterOpening => throw _privateConstructorUsedError;
  int get totalConsumeSeconds => throw _privateConstructorUsedError;
  InterstitialAd? get ad => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdStateCopyWith<AdState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdStateCopyWith<$Res> {
  factory $AdStateCopyWith(AdState value, $Res Function(AdState) then) =
      _$AdStateCopyWithImpl<$Res, AdState>;
  @useResult
  $Res call(
      {bool showAd,
      bool loadAd,
      int counterOpening,
      int totalConsumeSeconds,
      InterstitialAd? ad});
}

/// @nodoc
class _$AdStateCopyWithImpl<$Res, $Val extends AdState>
    implements $AdStateCopyWith<$Res> {
  _$AdStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showAd = null,
    Object? loadAd = null,
    Object? counterOpening = null,
    Object? totalConsumeSeconds = null,
    Object? ad = freezed,
  }) {
    return _then(_value.copyWith(
      showAd: null == showAd
          ? _value.showAd
          : showAd // ignore: cast_nullable_to_non_nullable
              as bool,
      loadAd: null == loadAd
          ? _value.loadAd
          : loadAd // ignore: cast_nullable_to_non_nullable
              as bool,
      counterOpening: null == counterOpening
          ? _value.counterOpening
          : counterOpening // ignore: cast_nullable_to_non_nullable
              as int,
      totalConsumeSeconds: null == totalConsumeSeconds
          ? _value.totalConsumeSeconds
          : totalConsumeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      ad: freezed == ad
          ? _value.ad
          : ad // ignore: cast_nullable_to_non_nullable
              as InterstitialAd?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdStateImplCopyWith<$Res> implements $AdStateCopyWith<$Res> {
  factory _$$AdStateImplCopyWith(
          _$AdStateImpl value, $Res Function(_$AdStateImpl) then) =
      __$$AdStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool showAd,
      bool loadAd,
      int counterOpening,
      int totalConsumeSeconds,
      InterstitialAd? ad});
}

/// @nodoc
class __$$AdStateImplCopyWithImpl<$Res>
    extends _$AdStateCopyWithImpl<$Res, _$AdStateImpl>
    implements _$$AdStateImplCopyWith<$Res> {
  __$$AdStateImplCopyWithImpl(
      _$AdStateImpl _value, $Res Function(_$AdStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showAd = null,
    Object? loadAd = null,
    Object? counterOpening = null,
    Object? totalConsumeSeconds = null,
    Object? ad = freezed,
  }) {
    return _then(_$AdStateImpl(
      showAd: null == showAd
          ? _value.showAd
          : showAd // ignore: cast_nullable_to_non_nullable
              as bool,
      loadAd: null == loadAd
          ? _value.loadAd
          : loadAd // ignore: cast_nullable_to_non_nullable
              as bool,
      counterOpening: null == counterOpening
          ? _value.counterOpening
          : counterOpening // ignore: cast_nullable_to_non_nullable
              as int,
      totalConsumeSeconds: null == totalConsumeSeconds
          ? _value.totalConsumeSeconds
          : totalConsumeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      ad: freezed == ad
          ? _value.ad
          : ad // ignore: cast_nullable_to_non_nullable
              as InterstitialAd?,
    ));
  }
}

/// @nodoc

class _$AdStateImpl extends _AdState with DiagnosticableTreeMixin {
  const _$AdStateImpl(
      {required this.showAd,
      required this.loadAd,
      required this.counterOpening,
      required this.totalConsumeSeconds,
      this.ad})
      : super._();

  @override
  final bool showAd;
  @override
  final bool loadAd;
  @override
  final int counterOpening;
  @override
  final int totalConsumeSeconds;
  @override
  final InterstitialAd? ad;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AdState(showAd: $showAd, loadAd: $loadAd, counterOpening: $counterOpening, totalConsumeSeconds: $totalConsumeSeconds, ad: $ad)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AdState'))
      ..add(DiagnosticsProperty('showAd', showAd))
      ..add(DiagnosticsProperty('loadAd', loadAd))
      ..add(DiagnosticsProperty('counterOpening', counterOpening))
      ..add(DiagnosticsProperty('totalConsumeSeconds', totalConsumeSeconds))
      ..add(DiagnosticsProperty('ad', ad));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdStateImpl &&
            (identical(other.showAd, showAd) || other.showAd == showAd) &&
            (identical(other.loadAd, loadAd) || other.loadAd == loadAd) &&
            (identical(other.counterOpening, counterOpening) ||
                other.counterOpening == counterOpening) &&
            (identical(other.totalConsumeSeconds, totalConsumeSeconds) ||
                other.totalConsumeSeconds == totalConsumeSeconds) &&
            (identical(other.ad, ad) || other.ad == ad));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, showAd, loadAd, counterOpening, totalConsumeSeconds, ad);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdStateImplCopyWith<_$AdStateImpl> get copyWith =>
      __$$AdStateImplCopyWithImpl<_$AdStateImpl>(this, _$identity);
}

abstract class _AdState extends AdState {
  const factory _AdState(
      {required final bool showAd,
      required final bool loadAd,
      required final int counterOpening,
      required final int totalConsumeSeconds,
      final InterstitialAd? ad}) = _$AdStateImpl;
  const _AdState._() : super._();

  @override
  bool get showAd;
  @override
  bool get loadAd;
  @override
  int get counterOpening;
  @override
  int get totalConsumeSeconds;
  @override
  InterstitialAd? get ad;
  @override
  @JsonKey(ignore: true)
  _$$AdStateImplCopyWith<_$AdStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
