// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_quran_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectQuranModel {
  Cuz? get cuz => throw _privateConstructorUsedError;
  Surah? get surah => throw _privateConstructorUsedError;
  VerseNumber? get firstVerseNumber => throw _privateConstructorUsedError;
  VerseNumber? get lastVerseNumber => throw _privateConstructorUsedError;
  List<VerseNumber> get validVerseNumbers => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectQuranModelCopyWith<SelectQuranModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectQuranModelCopyWith<$Res> {
  factory $SelectQuranModelCopyWith(
          SelectQuranModel value, $Res Function(SelectQuranModel) then) =
      _$SelectQuranModelCopyWithImpl<$Res, SelectQuranModel>;
  @useResult
  $Res call(
      {Cuz? cuz,
      Surah? surah,
      VerseNumber? firstVerseNumber,
      VerseNumber? lastVerseNumber,
      List<VerseNumber> validVerseNumbers,
      int page});
}

/// @nodoc
class _$SelectQuranModelCopyWithImpl<$Res, $Val extends SelectQuranModel>
    implements $SelectQuranModelCopyWith<$Res> {
  _$SelectQuranModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuz = freezed,
    Object? surah = freezed,
    Object? firstVerseNumber = freezed,
    Object? lastVerseNumber = freezed,
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
      firstVerseNumber: freezed == firstVerseNumber
          ? _value.firstVerseNumber
          : firstVerseNumber // ignore: cast_nullable_to_non_nullable
              as VerseNumber?,
      lastVerseNumber: freezed == lastVerseNumber
          ? _value.lastVerseNumber
          : lastVerseNumber // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SelectQuranModelImplCopyWith<$Res>
    implements $SelectQuranModelCopyWith<$Res> {
  factory _$$SelectQuranModelImplCopyWith(_$SelectQuranModelImpl value,
          $Res Function(_$SelectQuranModelImpl) then) =
      __$$SelectQuranModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Cuz? cuz,
      Surah? surah,
      VerseNumber? firstVerseNumber,
      VerseNumber? lastVerseNumber,
      List<VerseNumber> validVerseNumbers,
      int page});
}

/// @nodoc
class __$$SelectQuranModelImplCopyWithImpl<$Res>
    extends _$SelectQuranModelCopyWithImpl<$Res, _$SelectQuranModelImpl>
    implements _$$SelectQuranModelImplCopyWith<$Res> {
  __$$SelectQuranModelImplCopyWithImpl(_$SelectQuranModelImpl _value,
      $Res Function(_$SelectQuranModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuz = freezed,
    Object? surah = freezed,
    Object? firstVerseNumber = freezed,
    Object? lastVerseNumber = freezed,
    Object? validVerseNumbers = null,
    Object? page = null,
  }) {
    return _then(_$SelectQuranModelImpl(
      cuz: freezed == cuz
          ? _value.cuz
          : cuz // ignore: cast_nullable_to_non_nullable
              as Cuz?,
      surah: freezed == surah
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as Surah?,
      firstVerseNumber: freezed == firstVerseNumber
          ? _value.firstVerseNumber
          : firstVerseNumber // ignore: cast_nullable_to_non_nullable
              as VerseNumber?,
      lastVerseNumber: freezed == lastVerseNumber
          ? _value.lastVerseNumber
          : lastVerseNumber // ignore: cast_nullable_to_non_nullable
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

class _$SelectQuranModelImpl implements _SelectQuranModel {
  const _$SelectQuranModelImpl(
      {required this.cuz,
      required this.surah,
      required this.firstVerseNumber,
      required this.lastVerseNumber,
      required final List<VerseNumber> validVerseNumbers,
      required this.page})
      : _validVerseNumbers = validVerseNumbers;

  @override
  final Cuz? cuz;
  @override
  final Surah? surah;
  @override
  final VerseNumber? firstVerseNumber;
  @override
  final VerseNumber? lastVerseNumber;
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
  String toString() {
    return 'SelectQuranModel(cuz: $cuz, surah: $surah, firstVerseNumber: $firstVerseNumber, lastVerseNumber: $lastVerseNumber, validVerseNumbers: $validVerseNumbers, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectQuranModelImpl &&
            (identical(other.cuz, cuz) || other.cuz == cuz) &&
            (identical(other.surah, surah) || other.surah == surah) &&
            (identical(other.firstVerseNumber, firstVerseNumber) ||
                other.firstVerseNumber == firstVerseNumber) &&
            (identical(other.lastVerseNumber, lastVerseNumber) ||
                other.lastVerseNumber == lastVerseNumber) &&
            const DeepCollectionEquality()
                .equals(other._validVerseNumbers, _validVerseNumbers) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      cuz,
      surah,
      firstVerseNumber,
      lastVerseNumber,
      const DeepCollectionEquality().hash(_validVerseNumbers),
      page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectQuranModelImplCopyWith<_$SelectQuranModelImpl> get copyWith =>
      __$$SelectQuranModelImplCopyWithImpl<_$SelectQuranModelImpl>(
          this, _$identity);
}

abstract class _SelectQuranModel implements SelectQuranModel {
  const factory _SelectQuranModel(
      {required final Cuz? cuz,
      required final Surah? surah,
      required final VerseNumber? firstVerseNumber,
      required final VerseNumber? lastVerseNumber,
      required final List<VerseNumber> validVerseNumbers,
      required final int page}) = _$SelectQuranModelImpl;

  @override
  Cuz? get cuz;
  @override
  Surah? get surah;
  @override
  VerseNumber? get firstVerseNumber;
  @override
  VerseNumber? get lastVerseNumber;
  @override
  List<VerseNumber> get validVerseNumbers;
  @override
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$SelectQuranModelImplCopyWith<_$SelectQuranModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
