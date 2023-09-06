// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_and_verse_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrayerAndVerseDetailState {
  FontModel get fontModel => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  PrayerAndVerse? get prayer => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerAndVerseDetailStateCopyWith<PrayerAndVerseDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerAndVerseDetailStateCopyWith<$Res> {
  factory $PrayerAndVerseDetailStateCopyWith(PrayerAndVerseDetailState value,
          $Res Function(PrayerAndVerseDetailState) then) =
      _$PrayerAndVerseDetailStateCopyWithImpl<$Res, PrayerAndVerseDetailState>;
  @useResult
  $Res call(
      {FontModel fontModel,
      bool isLoading,
      PrayerAndVerse? prayer,
      String? message});

  $PrayerAndVerseCopyWith<$Res>? get prayer;
}

/// @nodoc
class _$PrayerAndVerseDetailStateCopyWithImpl<$Res,
        $Val extends PrayerAndVerseDetailState>
    implements $PrayerAndVerseDetailStateCopyWith<$Res> {
  _$PrayerAndVerseDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontModel = null,
    Object? isLoading = null,
    Object? prayer = freezed,
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
      prayer: freezed == prayer
          ? _value.prayer
          : prayer // ignore: cast_nullable_to_non_nullable
              as PrayerAndVerse?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PrayerAndVerseCopyWith<$Res>? get prayer {
    if (_value.prayer == null) {
      return null;
    }

    return $PrayerAndVerseCopyWith<$Res>(_value.prayer!, (value) {
      return _then(_value.copyWith(prayer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PrayerAndVerseDetailStateCopyWith<$Res>
    implements $PrayerAndVerseDetailStateCopyWith<$Res> {
  factory _$$_PrayerAndVerseDetailStateCopyWith(
          _$_PrayerAndVerseDetailState value,
          $Res Function(_$_PrayerAndVerseDetailState) then) =
      __$$_PrayerAndVerseDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FontModel fontModel,
      bool isLoading,
      PrayerAndVerse? prayer,
      String? message});

  @override
  $PrayerAndVerseCopyWith<$Res>? get prayer;
}

/// @nodoc
class __$$_PrayerAndVerseDetailStateCopyWithImpl<$Res>
    extends _$PrayerAndVerseDetailStateCopyWithImpl<$Res,
        _$_PrayerAndVerseDetailState>
    implements _$$_PrayerAndVerseDetailStateCopyWith<$Res> {
  __$$_PrayerAndVerseDetailStateCopyWithImpl(
      _$_PrayerAndVerseDetailState _value,
      $Res Function(_$_PrayerAndVerseDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontModel = null,
    Object? isLoading = null,
    Object? prayer = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_PrayerAndVerseDetailState(
      fontModel: null == fontModel
          ? _value.fontModel
          : fontModel // ignore: cast_nullable_to_non_nullable
              as FontModel,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      prayer: freezed == prayer
          ? _value.prayer
          : prayer // ignore: cast_nullable_to_non_nullable
              as PrayerAndVerse?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_PrayerAndVerseDetailState
    with DiagnosticableTreeMixin
    implements _PrayerAndVerseDetailState {
  const _$_PrayerAndVerseDetailState(
      {required this.fontModel,
      required this.isLoading,
      this.prayer,
      this.message});

  @override
  final FontModel fontModel;
  @override
  final bool isLoading;
  @override
  final PrayerAndVerse? prayer;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerAndVerseDetailState(fontModel: $fontModel, isLoading: $isLoading, prayer: $prayer, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrayerAndVerseDetailState'))
      ..add(DiagnosticsProperty('fontModel', fontModel))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('prayer', prayer))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrayerAndVerseDetailState &&
            (identical(other.fontModel, fontModel) ||
                other.fontModel == fontModel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.prayer, prayer) || other.prayer == prayer) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fontModel, isLoading, prayer, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrayerAndVerseDetailStateCopyWith<_$_PrayerAndVerseDetailState>
      get copyWith => __$$_PrayerAndVerseDetailStateCopyWithImpl<
          _$_PrayerAndVerseDetailState>(this, _$identity);
}

abstract class _PrayerAndVerseDetailState implements PrayerAndVerseDetailState {
  const factory _PrayerAndVerseDetailState(
      {required final FontModel fontModel,
      required final bool isLoading,
      final PrayerAndVerse? prayer,
      final String? message}) = _$_PrayerAndVerseDetailState;

  @override
  FontModel get fontModel;
  @override
  bool get isLoading;
  @override
  PrayerAndVerse? get prayer;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_PrayerAndVerseDetailStateCopyWith<_$_PrayerAndVerseDetailState>
      get copyWith => throw _privateConstructorUsedError;
}
