// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_verse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectVerseModel {
  Cuz? get cuz => throw _privateConstructorUsedError;
  Surah? get surah => throw _privateConstructorUsedError;
  VerseNumber? get currentVerseNumber => throw _privateConstructorUsedError;
  List<VerseNumber> get validVerseNumbers => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectVerseModelCopyWith<SelectVerseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectVerseModelCopyWith<$Res> {
  factory $SelectVerseModelCopyWith(
          SelectVerseModel value, $Res Function(SelectVerseModel) then) =
      _$SelectVerseModelCopyWithImpl<$Res, SelectVerseModel>;
  @useResult
  $Res call(
      {Cuz? cuz,
      Surah? surah,
      VerseNumber? currentVerseNumber,
      List<VerseNumber> validVerseNumbers,
      int page});
}

/// @nodoc
class _$SelectVerseModelCopyWithImpl<$Res, $Val extends SelectVerseModel>
    implements $SelectVerseModelCopyWith<$Res> {
  _$SelectVerseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuz = freezed,
    Object? surah = freezed,
    Object? currentVerseNumber = freezed,
    Object? validVerseNumbers = null,
    Object? page = null,
  }) {
    return _then(_value.copyWith(
      cuz: freezed == cuz
          ? _value.cuz
          : cuz // ignore: cast_nullable_to_non_nullable
              as Cuz?,
      surah: freezed == surah
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as Surah?,
      currentVerseNumber: freezed == currentVerseNumber
          ? _value.currentVerseNumber
          : currentVerseNumber // ignore: cast_nullable_to_non_nullable
              as VerseNumber?,
      validVerseNumbers: null == validVerseNumbers
          ? _value.validVerseNumbers
          : validVerseNumbers // ignore: cast_nullable_to_non_nullable
              as List<VerseNumber>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectVerseModelCopyWith<$Res>
    implements $SelectVerseModelCopyWith<$Res> {
  factory _$$_SelectVerseModelCopyWith(
          _$_SelectVerseModel value, $Res Function(_$_SelectVerseModel) then) =
      __$$_SelectVerseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Cuz? cuz,
      Surah? surah,
      VerseNumber? currentVerseNumber,
      List<VerseNumber> validVerseNumbers,
      int page});
}

/// @nodoc
class __$$_SelectVerseModelCopyWithImpl<$Res>
    extends _$SelectVerseModelCopyWithImpl<$Res, _$_SelectVerseModel>
    implements _$$_SelectVerseModelCopyWith<$Res> {
  __$$_SelectVerseModelCopyWithImpl(
      _$_SelectVerseModel _value, $Res Function(_$_SelectVerseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuz = freezed,
    Object? surah = freezed,
    Object? currentVerseNumber = freezed,
    Object? validVerseNumbers = null,
    Object? page = null,
  }) {
    return _then(_$_SelectVerseModel(
      cuz: freezed == cuz
          ? _value.cuz
          : cuz // ignore: cast_nullable_to_non_nullable
              as Cuz?,
      surah: freezed == surah
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as Surah?,
      currentVerseNumber: freezed == currentVerseNumber
          ? _value.currentVerseNumber
          : currentVerseNumber // ignore: cast_nullable_to_non_nullable
              as VerseNumber?,
      validVerseNumbers: null == validVerseNumbers
          ? _value._validVerseNumbers
          : validVerseNumbers // ignore: cast_nullable_to_non_nullable
              as List<VerseNumber>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SelectVerseModel
    with DiagnosticableTreeMixin
    implements _SelectVerseModel {
  const _$_SelectVerseModel(
      {required this.cuz,
      required this.surah,
      required this.currentVerseNumber,
      required final List<VerseNumber> validVerseNumbers,
      required this.page})
      : _validVerseNumbers = validVerseNumbers;

  @override
  final Cuz? cuz;
  @override
  final Surah? surah;
  @override
  final VerseNumber? currentVerseNumber;
  final List<VerseNumber> _validVerseNumbers;
  @override
  List<VerseNumber> get validVerseNumbers {
    if (_validVerseNumbers is EqualUnmodifiableListView)
      return _validVerseNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validVerseNumbers);
  }

  @override
  final int page;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectVerseModel(cuz: $cuz, surah: $surah, currentVerseNumber: $currentVerseNumber, validVerseNumbers: $validVerseNumbers, page: $page)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectVerseModel'))
      ..add(DiagnosticsProperty('cuz', cuz))
      ..add(DiagnosticsProperty('surah', surah))
      ..add(DiagnosticsProperty('currentVerseNumber', currentVerseNumber))
      ..add(DiagnosticsProperty('validVerseNumbers', validVerseNumbers))
      ..add(DiagnosticsProperty('page', page));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectVerseModel &&
            (identical(other.cuz, cuz) || other.cuz == cuz) &&
            (identical(other.surah, surah) || other.surah == surah) &&
            (identical(other.currentVerseNumber, currentVerseNumber) ||
                other.currentVerseNumber == currentVerseNumber) &&
            const DeepCollectionEquality()
                .equals(other._validVerseNumbers, _validVerseNumbers) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cuz, surah, currentVerseNumber,
      const DeepCollectionEquality().hash(_validVerseNumbers), page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectVerseModelCopyWith<_$_SelectVerseModel> get copyWith =>
      __$$_SelectVerseModelCopyWithImpl<_$_SelectVerseModel>(this, _$identity);
}

abstract class _SelectVerseModel implements SelectVerseModel {
  const factory _SelectVerseModel(
      {required final Cuz? cuz,
      required final Surah? surah,
      required final VerseNumber? currentVerseNumber,
      required final List<VerseNumber> validVerseNumbers,
      required final int page}) = _$_SelectVerseModel;

  @override
  Cuz? get cuz;
  @override
  Surah? get surah;
  @override
  VerseNumber? get currentVerseNumber;
  @override
  List<VerseNumber> get validVerseNumbers;
  @override
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$_SelectVerseModelCopyWith<_$_SelectVerseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
