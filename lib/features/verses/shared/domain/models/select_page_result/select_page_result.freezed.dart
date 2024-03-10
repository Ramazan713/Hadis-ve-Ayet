// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_page_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectPageResult {
  int get pageNo => throw _privateConstructorUsedError;
  int get pagePos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectPageResultCopyWith<SelectPageResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectPageResultCopyWith<$Res> {
  factory $SelectPageResultCopyWith(
          SelectPageResult value, $Res Function(SelectPageResult) then) =
      _$SelectPageResultCopyWithImpl<$Res, SelectPageResult>;
  @useResult
  $Res call({int pageNo, int pagePos});
}

/// @nodoc
class _$SelectPageResultCopyWithImpl<$Res, $Val extends SelectPageResult>
    implements $SelectPageResultCopyWith<$Res> {
  _$SelectPageResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNo = null,
    Object? pagePos = null,
  }) {
    return _then(_value.copyWith(
      pageNo: null == pageNo
          ? _value.pageNo
          : pageNo // ignore: cast_nullable_to_non_nullable
              as int,
      pagePos: null == pagePos
          ? _value.pagePos
          : pagePos // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectPageResultImplCopyWith<$Res>
    implements $SelectPageResultCopyWith<$Res> {
  factory _$$SelectPageResultImplCopyWith(_$SelectPageResultImpl value,
          $Res Function(_$SelectPageResultImpl) then) =
      __$$SelectPageResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pageNo, int pagePos});
}

/// @nodoc
class __$$SelectPageResultImplCopyWithImpl<$Res>
    extends _$SelectPageResultCopyWithImpl<$Res, _$SelectPageResultImpl>
    implements _$$SelectPageResultImplCopyWith<$Res> {
  __$$SelectPageResultImplCopyWithImpl(_$SelectPageResultImpl _value,
      $Res Function(_$SelectPageResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageNo = null,
    Object? pagePos = null,
  }) {
    return _then(_$SelectPageResultImpl(
      pageNo: null == pageNo
          ? _value.pageNo
          : pageNo // ignore: cast_nullable_to_non_nullable
              as int,
      pagePos: null == pagePos
          ? _value.pagePos
          : pagePos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SelectPageResultImpl
    with DiagnosticableTreeMixin
    implements _SelectPageResult {
  const _$SelectPageResultImpl({required this.pageNo, required this.pagePos});

  @override
  final int pageNo;
  @override
  final int pagePos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectPageResult(pageNo: $pageNo, pagePos: $pagePos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectPageResult'))
      ..add(DiagnosticsProperty('pageNo', pageNo))
      ..add(DiagnosticsProperty('pagePos', pagePos));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectPageResultImpl &&
            (identical(other.pageNo, pageNo) || other.pageNo == pageNo) &&
            (identical(other.pagePos, pagePos) || other.pagePos == pagePos));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageNo, pagePos);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectPageResultImplCopyWith<_$SelectPageResultImpl> get copyWith =>
      __$$SelectPageResultImplCopyWithImpl<_$SelectPageResultImpl>(
          this, _$identity);
}

abstract class _SelectPageResult implements SelectPageResult {
  const factory _SelectPageResult(
      {required final int pageNo,
      required final int pagePos}) = _$SelectPageResultImpl;

  @override
  int get pageNo;
  @override
  int get pagePos;
  @override
  @JsonKey(ignore: true)
  _$$SelectPageResultImplCopyWith<_$SelectPageResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
