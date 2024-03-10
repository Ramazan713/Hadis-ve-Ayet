// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_audio_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BasicAudioRequest {
  int get surahId => throw _privateConstructorUsedError;
  String get startVerseId => throw _privateConstructorUsedError;
  String? get endVerseId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BasicAudioRequestCopyWith<BasicAudioRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasicAudioRequestCopyWith<$Res> {
  factory $BasicAudioRequestCopyWith(
          BasicAudioRequest value, $Res Function(BasicAudioRequest) then) =
      _$BasicAudioRequestCopyWithImpl<$Res, BasicAudioRequest>;
  @useResult
  $Res call({int surahId, String startVerseId, String? endVerseId});
}

/// @nodoc
class _$BasicAudioRequestCopyWithImpl<$Res, $Val extends BasicAudioRequest>
    implements $BasicAudioRequestCopyWith<$Res> {
  _$BasicAudioRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surahId = null,
    Object? startVerseId = null,
    Object? endVerseId = freezed,
  }) {
    return _then(_value.copyWith(
      surahId: null == surahId
          ? _value.surahId
          : surahId // ignore: cast_nullable_to_non_nullable
              as int,
      startVerseId: null == startVerseId
          ? _value.startVerseId
          : startVerseId // ignore: cast_nullable_to_non_nullable
              as String,
      endVerseId: freezed == endVerseId
          ? _value.endVerseId
          : endVerseId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BasicAudioRequestImplCopyWith<$Res>
    implements $BasicAudioRequestCopyWith<$Res> {
  factory _$$BasicAudioRequestImplCopyWith(_$BasicAudioRequestImpl value,
          $Res Function(_$BasicAudioRequestImpl) then) =
      __$$BasicAudioRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int surahId, String startVerseId, String? endVerseId});
}

/// @nodoc
class __$$BasicAudioRequestImplCopyWithImpl<$Res>
    extends _$BasicAudioRequestCopyWithImpl<$Res, _$BasicAudioRequestImpl>
    implements _$$BasicAudioRequestImplCopyWith<$Res> {
  __$$BasicAudioRequestImplCopyWithImpl(_$BasicAudioRequestImpl _value,
      $Res Function(_$BasicAudioRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surahId = null,
    Object? startVerseId = null,
    Object? endVerseId = freezed,
  }) {
    return _then(_$BasicAudioRequestImpl(
      surahId: null == surahId
          ? _value.surahId
          : surahId // ignore: cast_nullable_to_non_nullable
              as int,
      startVerseId: null == startVerseId
          ? _value.startVerseId
          : startVerseId // ignore: cast_nullable_to_non_nullable
              as String,
      endVerseId: freezed == endVerseId
          ? _value.endVerseId
          : endVerseId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BasicAudioRequestImpl
    with DiagnosticableTreeMixin
    implements _BasicAudioRequest {
  const _$BasicAudioRequestImpl(
      {required this.surahId, required this.startVerseId, this.endVerseId});

  @override
  final int surahId;
  @override
  final String startVerseId;
  @override
  final String? endVerseId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BasicAudioRequest(surahId: $surahId, startVerseId: $startVerseId, endVerseId: $endVerseId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BasicAudioRequest'))
      ..add(DiagnosticsProperty('surahId', surahId))
      ..add(DiagnosticsProperty('startVerseId', startVerseId))
      ..add(DiagnosticsProperty('endVerseId', endVerseId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasicAudioRequestImpl &&
            (identical(other.surahId, surahId) || other.surahId == surahId) &&
            (identical(other.startVerseId, startVerseId) ||
                other.startVerseId == startVerseId) &&
            (identical(other.endVerseId, endVerseId) ||
                other.endVerseId == endVerseId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, surahId, startVerseId, endVerseId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BasicAudioRequestImplCopyWith<_$BasicAudioRequestImpl> get copyWith =>
      __$$BasicAudioRequestImplCopyWithImpl<_$BasicAudioRequestImpl>(
          this, _$identity);
}

abstract class _BasicAudioRequest implements BasicAudioRequest {
  const factory _BasicAudioRequest(
      {required final int surahId,
      required final String startVerseId,
      final String? endVerseId}) = _$BasicAudioRequestImpl;

  @override
  int get surahId;
  @override
  String get startVerseId;
  @override
  String? get endVerseId;
  @override
  @JsonKey(ignore: true)
  _$$BasicAudioRequestImplCopyWith<_$BasicAudioRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
