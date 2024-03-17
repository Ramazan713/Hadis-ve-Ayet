// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_audio_edition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectAudioEdition {
  AudioEdition get audioEdition => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;
  AudioQualityEnum get qualityEnum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectAudioEditionCopyWith<SelectAudioEdition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectAudioEditionCopyWith<$Res> {
  factory $SelectAudioEditionCopyWith(
          SelectAudioEdition value, $Res Function(SelectAudioEdition) then) =
      _$SelectAudioEditionCopyWithImpl<$Res, SelectAudioEdition>;
  @useResult
  $Res call(
      {AudioEdition audioEdition,
      bool isSelected,
      AudioQualityEnum qualityEnum});
}

/// @nodoc
class _$SelectAudioEditionCopyWithImpl<$Res, $Val extends SelectAudioEdition>
    implements $SelectAudioEditionCopyWith<$Res> {
  _$SelectAudioEditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioEdition = null,
    Object? isSelected = null,
    Object? qualityEnum = null,
  }) {
    return _then(_value.copyWith(
      audioEdition: null == audioEdition
          ? _value.audioEdition
          : audioEdition // ignore: cast_nullable_to_non_nullable
              as AudioEdition,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      qualityEnum: null == qualityEnum
          ? _value.qualityEnum
          : qualityEnum // ignore: cast_nullable_to_non_nullable
              as AudioQualityEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectAudioEditionImplCopyWith<$Res>
    implements $SelectAudioEditionCopyWith<$Res> {
  factory _$$SelectAudioEditionImplCopyWith(_$SelectAudioEditionImpl value,
          $Res Function(_$SelectAudioEditionImpl) then) =
      __$$SelectAudioEditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AudioEdition audioEdition,
      bool isSelected,
      AudioQualityEnum qualityEnum});
}

/// @nodoc
class __$$SelectAudioEditionImplCopyWithImpl<$Res>
    extends _$SelectAudioEditionCopyWithImpl<$Res, _$SelectAudioEditionImpl>
    implements _$$SelectAudioEditionImplCopyWith<$Res> {
  __$$SelectAudioEditionImplCopyWithImpl(_$SelectAudioEditionImpl _value,
      $Res Function(_$SelectAudioEditionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioEdition = null,
    Object? isSelected = null,
    Object? qualityEnum = null,
  }) {
    return _then(_$SelectAudioEditionImpl(
      audioEdition: null == audioEdition
          ? _value.audioEdition
          : audioEdition // ignore: cast_nullable_to_non_nullable
              as AudioEdition,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      qualityEnum: null == qualityEnum
          ? _value.qualityEnum
          : qualityEnum // ignore: cast_nullable_to_non_nullable
              as AudioQualityEnum,
    ));
  }
}

/// @nodoc

class _$SelectAudioEditionImpl
    with DiagnosticableTreeMixin
    implements _SelectAudioEdition {
  const _$SelectAudioEditionImpl(
      {required this.audioEdition,
      required this.isSelected,
      required this.qualityEnum});

  @override
  final AudioEdition audioEdition;
  @override
  final bool isSelected;
  @override
  final AudioQualityEnum qualityEnum;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectAudioEdition(audioEdition: $audioEdition, isSelected: $isSelected, qualityEnum: $qualityEnum)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectAudioEdition'))
      ..add(DiagnosticsProperty('audioEdition', audioEdition))
      ..add(DiagnosticsProperty('isSelected', isSelected))
      ..add(DiagnosticsProperty('qualityEnum', qualityEnum));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectAudioEditionImpl &&
            (identical(other.audioEdition, audioEdition) ||
                other.audioEdition == audioEdition) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected) &&
            (identical(other.qualityEnum, qualityEnum) ||
                other.qualityEnum == qualityEnum));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, audioEdition, isSelected, qualityEnum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectAudioEditionImplCopyWith<_$SelectAudioEditionImpl> get copyWith =>
      __$$SelectAudioEditionImplCopyWithImpl<_$SelectAudioEditionImpl>(
          this, _$identity);
}

abstract class _SelectAudioEdition implements SelectAudioEdition {
  const factory _SelectAudioEdition(
      {required final AudioEdition audioEdition,
      required final bool isSelected,
      required final AudioQualityEnum qualityEnum}) = _$SelectAudioEditionImpl;

  @override
  AudioEdition get audioEdition;
  @override
  bool get isSelected;
  @override
  AudioQualityEnum get qualityEnum;
  @override
  @JsonKey(ignore: true)
  _$$SelectAudioEditionImplCopyWith<_$SelectAudioEditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
