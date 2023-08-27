// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_meta_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BackupMetaModel {
  int? get id => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get updatedDate => throw _privateConstructorUsedError;
  bool get isAuto => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BackupMetaModelCopyWith<BackupMetaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupMetaModelCopyWith<$Res> {
  factory $BackupMetaModelCopyWith(
          BackupMetaModel value, $Res Function(BackupMetaModel) then) =
      _$BackupMetaModelCopyWithImpl<$Res, BackupMetaModel>;
  @useResult
  $Res call({int? id, String fileName, String updatedDate, bool isAuto});
}

/// @nodoc
class _$BackupMetaModelCopyWithImpl<$Res, $Val extends BackupMetaModel>
    implements $BackupMetaModelCopyWith<$Res> {
  _$BackupMetaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = null,
    Object? updatedDate = null,
    Object? isAuto = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      updatedDate: null == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      isAuto: null == isAuto
          ? _value.isAuto
          : isAuto // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BackupMetaModelCopyWith<$Res>
    implements $BackupMetaModelCopyWith<$Res> {
  factory _$$_BackupMetaModelCopyWith(
          _$_BackupMetaModel value, $Res Function(_$_BackupMetaModel) then) =
      __$$_BackupMetaModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String fileName, String updatedDate, bool isAuto});
}

/// @nodoc
class __$$_BackupMetaModelCopyWithImpl<$Res>
    extends _$BackupMetaModelCopyWithImpl<$Res, _$_BackupMetaModel>
    implements _$$_BackupMetaModelCopyWith<$Res> {
  __$$_BackupMetaModelCopyWithImpl(
      _$_BackupMetaModel _value, $Res Function(_$_BackupMetaModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = null,
    Object? updatedDate = null,
    Object? isAuto = null,
  }) {
    return _then(_$_BackupMetaModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      updatedDate: null == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      isAuto: null == isAuto
          ? _value.isAuto
          : isAuto // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BackupMetaModel
    with DiagnosticableTreeMixin
    implements _BackupMetaModel {
  const _$_BackupMetaModel(
      {this.id,
      required this.fileName,
      required this.updatedDate,
      required this.isAuto});

  @override
  final int? id;
  @override
  final String fileName;
  @override
  final String updatedDate;
  @override
  final bool isAuto;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BackupMetaModel(id: $id, fileName: $fileName, updatedDate: $updatedDate, isAuto: $isAuto)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BackupMetaModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('fileName', fileName))
      ..add(DiagnosticsProperty('updatedDate', updatedDate))
      ..add(DiagnosticsProperty('isAuto', isAuto));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BackupMetaModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.isAuto, isAuto) || other.isAuto == isAuto));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fileName, updatedDate, isAuto);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BackupMetaModelCopyWith<_$_BackupMetaModel> get copyWith =>
      __$$_BackupMetaModelCopyWithImpl<_$_BackupMetaModel>(this, _$identity);
}

abstract class _BackupMetaModel implements BackupMetaModel {
  const factory _BackupMetaModel(
      {final int? id,
      required final String fileName,
      required final String updatedDate,
      required final bool isAuto}) = _$_BackupMetaModel;

  @override
  int? get id;
  @override
  String get fileName;
  @override
  String get updatedDate;
  @override
  bool get isAuto;
  @override
  @JsonKey(ignore: true)
  _$$_BackupMetaModelCopyWith<_$_BackupMetaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
