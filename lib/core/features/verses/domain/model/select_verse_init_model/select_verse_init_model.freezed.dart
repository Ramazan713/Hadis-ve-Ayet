// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_verse_init_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectVerseInitModel {
  List<Cuz> get cuzs => throw _privateConstructorUsedError;
  List<Surah> get surahes => throw _privateConstructorUsedError;
  List<VerseNumber> get currentVerseNumbers =>
      throw _privateConstructorUsedError;
  int get pageMaxPos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectVerseInitModelCopyWith<SelectVerseInitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectVerseInitModelCopyWith<$Res> {
  factory $SelectVerseInitModelCopyWith(SelectVerseInitModel value,
          $Res Function(SelectVerseInitModel) then) =
      _$SelectVerseInitModelCopyWithImpl<$Res, SelectVerseInitModel>;
  @useResult
  $Res call(
      {List<Cuz> cuzs,
      List<Surah> surahes,
      List<VerseNumber> currentVerseNumbers,
      int pageMaxPos});
}

/// @nodoc
class _$SelectVerseInitModelCopyWithImpl<$Res,
        $Val extends SelectVerseInitModel>
    implements $SelectVerseInitModelCopyWith<$Res> {
  _$SelectVerseInitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuzs = null,
    Object? surahes = null,
    Object? currentVerseNumbers = null,
    Object? pageMaxPos = null,
  }) {
    return _then(_value.copyWith(
      cuzs: null == cuzs
          ? _value.cuzs
          : cuzs // ignore: cast_nullable_to_non_nullable
              as List<Cuz>,
      surahes: null == surahes
          ? _value.surahes
          : surahes // ignore: cast_nullable_to_non_nullable
              as List<Surah>,
      currentVerseNumbers: null == currentVerseNumbers
          ? _value.currentVerseNumbers
          : currentVerseNumbers // ignore: cast_nullable_to_non_nullable
              as List<VerseNumber>,
      pageMaxPos: null == pageMaxPos
          ? _value.pageMaxPos
          : pageMaxPos // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectVerseInitModelCopyWith<$Res>
    implements $SelectVerseInitModelCopyWith<$Res> {
  factory _$$_SelectVerseInitModelCopyWith(_$_SelectVerseInitModel value,
          $Res Function(_$_SelectVerseInitModel) then) =
      __$$_SelectVerseInitModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Cuz> cuzs,
      List<Surah> surahes,
      List<VerseNumber> currentVerseNumbers,
      int pageMaxPos});
}

/// @nodoc
class __$$_SelectVerseInitModelCopyWithImpl<$Res>
    extends _$SelectVerseInitModelCopyWithImpl<$Res, _$_SelectVerseInitModel>
    implements _$$_SelectVerseInitModelCopyWith<$Res> {
  __$$_SelectVerseInitModelCopyWithImpl(_$_SelectVerseInitModel _value,
      $Res Function(_$_SelectVerseInitModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cuzs = null,
    Object? surahes = null,
    Object? currentVerseNumbers = null,
    Object? pageMaxPos = null,
  }) {
    return _then(_$_SelectVerseInitModel(
      cuzs: null == cuzs
          ? _value._cuzs
          : cuzs // ignore: cast_nullable_to_non_nullable
              as List<Cuz>,
      surahes: null == surahes
          ? _value._surahes
          : surahes // ignore: cast_nullable_to_non_nullable
              as List<Surah>,
      currentVerseNumbers: null == currentVerseNumbers
          ? _value._currentVerseNumbers
          : currentVerseNumbers // ignore: cast_nullable_to_non_nullable
              as List<VerseNumber>,
      pageMaxPos: null == pageMaxPos
          ? _value.pageMaxPos
          : pageMaxPos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SelectVerseInitModel
    with DiagnosticableTreeMixin
    implements _SelectVerseInitModel {
  const _$_SelectVerseInitModel(
      {required final List<Cuz> cuzs,
      required final List<Surah> surahes,
      required final List<VerseNumber> currentVerseNumbers,
      required this.pageMaxPos})
      : _cuzs = cuzs,
        _surahes = surahes,
        _currentVerseNumbers = currentVerseNumbers;

  final List<Cuz> _cuzs;
  @override
  List<Cuz> get cuzs {
    if (_cuzs is EqualUnmodifiableListView) return _cuzs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cuzs);
  }

  final List<Surah> _surahes;
  @override
  List<Surah> get surahes {
    if (_surahes is EqualUnmodifiableListView) return _surahes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_surahes);
  }

  final List<VerseNumber> _currentVerseNumbers;
  @override
  List<VerseNumber> get currentVerseNumbers {
    if (_currentVerseNumbers is EqualUnmodifiableListView)
      return _currentVerseNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentVerseNumbers);
  }

  @override
  final int pageMaxPos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectVerseInitModel(cuzs: $cuzs, surahes: $surahes, currentVerseNumbers: $currentVerseNumbers, pageMaxPos: $pageMaxPos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectVerseInitModel'))
      ..add(DiagnosticsProperty('cuzs', cuzs))
      ..add(DiagnosticsProperty('surahes', surahes))
      ..add(DiagnosticsProperty('currentVerseNumbers', currentVerseNumbers))
      ..add(DiagnosticsProperty('pageMaxPos', pageMaxPos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectVerseInitModel &&
            const DeepCollectionEquality().equals(other._cuzs, _cuzs) &&
            const DeepCollectionEquality().equals(other._surahes, _surahes) &&
            const DeepCollectionEquality()
                .equals(other._currentVerseNumbers, _currentVerseNumbers) &&
            (identical(other.pageMaxPos, pageMaxPos) ||
                other.pageMaxPos == pageMaxPos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cuzs),
      const DeepCollectionEquality().hash(_surahes),
      const DeepCollectionEquality().hash(_currentVerseNumbers),
      pageMaxPos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectVerseInitModelCopyWith<_$_SelectVerseInitModel> get copyWith =>
      __$$_SelectVerseInitModelCopyWithImpl<_$_SelectVerseInitModel>(
          this, _$identity);
}

abstract class _SelectVerseInitModel implements SelectVerseInitModel {
  const factory _SelectVerseInitModel(
      {required final List<Cuz> cuzs,
      required final List<Surah> surahes,
      required final List<VerseNumber> currentVerseNumbers,
      required final int pageMaxPos}) = _$_SelectVerseInitModel;

  @override
  List<Cuz> get cuzs;
  @override
  List<Surah> get surahes;
  @override
  List<VerseNumber> get currentVerseNumbers;
  @override
  int get pageMaxPos;
  @override
  @JsonKey(ignore: true)
  _$$_SelectVerseInitModelCopyWith<_$_SelectVerseInitModel> get copyWith =>
      throw _privateConstructorUsedError;
}
