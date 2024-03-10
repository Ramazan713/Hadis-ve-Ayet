// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_quran_section_load_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectQuranSectionLoadConfig {
  int? get page => throw _privateConstructorUsedError;
  int? get surahId => throw _privateConstructorUsedError;
  String? get firstVerseNumber => throw _privateConstructorUsedError;
  String? get lastVerseNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectQuranSectionLoadConfigCopyWith<SelectQuranSectionLoadConfig>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectQuranSectionLoadConfigCopyWith<$Res> {
  factory $SelectQuranSectionLoadConfigCopyWith(
          SelectQuranSectionLoadConfig value,
          $Res Function(SelectQuranSectionLoadConfig) then) =
      _$SelectQuranSectionLoadConfigCopyWithImpl<$Res,
          SelectQuranSectionLoadConfig>;
  @useResult
  $Res call(
      {int? page,
      int? surahId,
      String? firstVerseNumber,
      String? lastVerseNumber});
}

/// @nodoc
class _$SelectQuranSectionLoadConfigCopyWithImpl<$Res,
        $Val extends SelectQuranSectionLoadConfig>
    implements $SelectQuranSectionLoadConfigCopyWith<$Res> {
  _$SelectQuranSectionLoadConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? surahId = freezed,
    Object? firstVerseNumber = freezed,
    Object? lastVerseNumber = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      surahId: freezed == surahId
          ? _value.surahId
          : surahId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstVerseNumber: freezed == firstVerseNumber
          ? _value.firstVerseNumber
          : firstVerseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      lastVerseNumber: freezed == lastVerseNumber
          ? _value.lastVerseNumber
          : lastVerseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectQuranSectionLoadConfigImplCopyWith<$Res>
    implements $SelectQuranSectionLoadConfigCopyWith<$Res> {
  factory _$$SelectQuranSectionLoadConfigImplCopyWith(
          _$SelectQuranSectionLoadConfigImpl value,
          $Res Function(_$SelectQuranSectionLoadConfigImpl) then) =
      __$$SelectQuranSectionLoadConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? page,
      int? surahId,
      String? firstVerseNumber,
      String? lastVerseNumber});
}

/// @nodoc
class __$$SelectQuranSectionLoadConfigImplCopyWithImpl<$Res>
    extends _$SelectQuranSectionLoadConfigCopyWithImpl<$Res,
        _$SelectQuranSectionLoadConfigImpl>
    implements _$$SelectQuranSectionLoadConfigImplCopyWith<$Res> {
  __$$SelectQuranSectionLoadConfigImplCopyWithImpl(
      _$SelectQuranSectionLoadConfigImpl _value,
      $Res Function(_$SelectQuranSectionLoadConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? surahId = freezed,
    Object? firstVerseNumber = freezed,
    Object? lastVerseNumber = freezed,
  }) {
    return _then(_$SelectQuranSectionLoadConfigImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      surahId: freezed == surahId
          ? _value.surahId
          : surahId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstVerseNumber: freezed == firstVerseNumber
          ? _value.firstVerseNumber
          : firstVerseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      lastVerseNumber: freezed == lastVerseNumber
          ? _value.lastVerseNumber
          : lastVerseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SelectQuranSectionLoadConfigImpl
    with DiagnosticableTreeMixin
    implements _SelectQuranSectionLoadConfig {
  const _$SelectQuranSectionLoadConfigImpl(
      {this.page, this.surahId, this.firstVerseNumber, this.lastVerseNumber});

  @override
  final int? page;
  @override
  final int? surahId;
  @override
  final String? firstVerseNumber;
  @override
  final String? lastVerseNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectQuranSectionLoadConfig(page: $page, surahId: $surahId, firstVerseNumber: $firstVerseNumber, lastVerseNumber: $lastVerseNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectQuranSectionLoadConfig'))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('surahId', surahId))
      ..add(DiagnosticsProperty('firstVerseNumber', firstVerseNumber))
      ..add(DiagnosticsProperty('lastVerseNumber', lastVerseNumber));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectQuranSectionLoadConfigImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.surahId, surahId) || other.surahId == surahId) &&
            (identical(other.firstVerseNumber, firstVerseNumber) ||
                other.firstVerseNumber == firstVerseNumber) &&
            (identical(other.lastVerseNumber, lastVerseNumber) ||
                other.lastVerseNumber == lastVerseNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, page, surahId, firstVerseNumber, lastVerseNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectQuranSectionLoadConfigImplCopyWith<
          _$SelectQuranSectionLoadConfigImpl>
      get copyWith => __$$SelectQuranSectionLoadConfigImplCopyWithImpl<
          _$SelectQuranSectionLoadConfigImpl>(this, _$identity);
}

abstract class _SelectQuranSectionLoadConfig
    implements SelectQuranSectionLoadConfig {
  const factory _SelectQuranSectionLoadConfig(
      {final int? page,
      final int? surahId,
      final String? firstVerseNumber,
      final String? lastVerseNumber}) = _$SelectQuranSectionLoadConfigImpl;

  @override
  int? get page;
  @override
  int? get surahId;
  @override
  String? get firstVerseNumber;
  @override
  String? get lastVerseNumber;
  @override
  @JsonKey(ignore: true)
  _$$SelectQuranSectionLoadConfigImplCopyWith<
          _$SelectQuranSectionLoadConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
