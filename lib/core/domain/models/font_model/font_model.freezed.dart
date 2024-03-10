// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'font_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FontModel {
  FontFamilyArabicEnum get arabicFontFamilyEnum =>
      throw _privateConstructorUsedError;
  FontSizeEnum get contentFontSizeEnum => throw _privateConstructorUsedError;
  FontSizeEnum get arabicFontSizeEnum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FontModelCopyWith<FontModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontModelCopyWith<$Res> {
  factory $FontModelCopyWith(FontModel value, $Res Function(FontModel) then) =
      _$FontModelCopyWithImpl<$Res, FontModel>;
  @useResult
  $Res call(
      {FontFamilyArabicEnum arabicFontFamilyEnum,
      FontSizeEnum contentFontSizeEnum,
      FontSizeEnum arabicFontSizeEnum});
}

/// @nodoc
class _$FontModelCopyWithImpl<$Res, $Val extends FontModel>
    implements $FontModelCopyWith<$Res> {
  _$FontModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arabicFontFamilyEnum = null,
    Object? contentFontSizeEnum = null,
    Object? arabicFontSizeEnum = null,
  }) {
    return _then(_value.copyWith(
      arabicFontFamilyEnum: null == arabicFontFamilyEnum
          ? _value.arabicFontFamilyEnum
          : arabicFontFamilyEnum // ignore: cast_nullable_to_non_nullable
              as FontFamilyArabicEnum,
      contentFontSizeEnum: null == contentFontSizeEnum
          ? _value.contentFontSizeEnum
          : contentFontSizeEnum // ignore: cast_nullable_to_non_nullable
              as FontSizeEnum,
      arabicFontSizeEnum: null == arabicFontSizeEnum
          ? _value.arabicFontSizeEnum
          : arabicFontSizeEnum // ignore: cast_nullable_to_non_nullable
              as FontSizeEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FontModelImplCopyWith<$Res>
    implements $FontModelCopyWith<$Res> {
  factory _$$FontModelImplCopyWith(
          _$FontModelImpl value, $Res Function(_$FontModelImpl) then) =
      __$$FontModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FontFamilyArabicEnum arabicFontFamilyEnum,
      FontSizeEnum contentFontSizeEnum,
      FontSizeEnum arabicFontSizeEnum});
}

/// @nodoc
class __$$FontModelImplCopyWithImpl<$Res>
    extends _$FontModelCopyWithImpl<$Res, _$FontModelImpl>
    implements _$$FontModelImplCopyWith<$Res> {
  __$$FontModelImplCopyWithImpl(
      _$FontModelImpl _value, $Res Function(_$FontModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arabicFontFamilyEnum = null,
    Object? contentFontSizeEnum = null,
    Object? arabicFontSizeEnum = null,
  }) {
    return _then(_$FontModelImpl(
      arabicFontFamilyEnum: null == arabicFontFamilyEnum
          ? _value.arabicFontFamilyEnum
          : arabicFontFamilyEnum // ignore: cast_nullable_to_non_nullable
              as FontFamilyArabicEnum,
      contentFontSizeEnum: null == contentFontSizeEnum
          ? _value.contentFontSizeEnum
          : contentFontSizeEnum // ignore: cast_nullable_to_non_nullable
              as FontSizeEnum,
      arabicFontSizeEnum: null == arabicFontSizeEnum
          ? _value.arabicFontSizeEnum
          : arabicFontSizeEnum // ignore: cast_nullable_to_non_nullable
              as FontSizeEnum,
    ));
  }
}

/// @nodoc

class _$FontModelImpl extends _FontModel with DiagnosticableTreeMixin {
  const _$FontModelImpl(
      {required this.arabicFontFamilyEnum,
      required this.contentFontSizeEnum,
      required this.arabicFontSizeEnum})
      : super._();

  @override
  final FontFamilyArabicEnum arabicFontFamilyEnum;
  @override
  final FontSizeEnum contentFontSizeEnum;
  @override
  final FontSizeEnum arabicFontSizeEnum;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FontModel(arabicFontFamilyEnum: $arabicFontFamilyEnum, contentFontSizeEnum: $contentFontSizeEnum, arabicFontSizeEnum: $arabicFontSizeEnum)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FontModel'))
      ..add(DiagnosticsProperty('arabicFontFamilyEnum', arabicFontFamilyEnum))
      ..add(DiagnosticsProperty('contentFontSizeEnum', contentFontSizeEnum))
      ..add(DiagnosticsProperty('arabicFontSizeEnum', arabicFontSizeEnum));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontModelImpl &&
            (identical(other.arabicFontFamilyEnum, arabicFontFamilyEnum) ||
                other.arabicFontFamilyEnum == arabicFontFamilyEnum) &&
            (identical(other.contentFontSizeEnum, contentFontSizeEnum) ||
                other.contentFontSizeEnum == contentFontSizeEnum) &&
            (identical(other.arabicFontSizeEnum, arabicFontSizeEnum) ||
                other.arabicFontSizeEnum == arabicFontSizeEnum));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arabicFontFamilyEnum,
      contentFontSizeEnum, arabicFontSizeEnum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FontModelImplCopyWith<_$FontModelImpl> get copyWith =>
      __$$FontModelImplCopyWithImpl<_$FontModelImpl>(this, _$identity);
}

abstract class _FontModel extends FontModel {
  const factory _FontModel(
      {required final FontFamilyArabicEnum arabicFontFamilyEnum,
      required final FontSizeEnum contentFontSizeEnum,
      required final FontSizeEnum arabicFontSizeEnum}) = _$FontModelImpl;
  const _FontModel._() : super._();

  @override
  FontFamilyArabicEnum get arabicFontFamilyEnum;
  @override
  FontSizeEnum get contentFontSizeEnum;
  @override
  FontSizeEnum get arabicFontSizeEnum;
  @override
  @JsonKey(ignore: true)
  _$$FontModelImplCopyWith<_$FontModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
