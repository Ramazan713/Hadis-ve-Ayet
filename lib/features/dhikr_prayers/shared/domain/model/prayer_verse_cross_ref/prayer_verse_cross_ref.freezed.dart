// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_verse_cross_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrayerVerseCrossRef {
  int get verseId => throw _privateConstructorUsedError;
  int get prayerId => throw _privateConstructorUsedError;
  int get orderItem => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerVerseCrossRefCopyWith<PrayerVerseCrossRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerVerseCrossRefCopyWith<$Res> {
  factory $PrayerVerseCrossRefCopyWith(
          PrayerVerseCrossRef value, $Res Function(PrayerVerseCrossRef) then) =
      _$PrayerVerseCrossRefCopyWithImpl<$Res, PrayerVerseCrossRef>;
  @useResult
  $Res call({int verseId, int prayerId, int orderItem, int? id});
}

/// @nodoc
class _$PrayerVerseCrossRefCopyWithImpl<$Res, $Val extends PrayerVerseCrossRef>
    implements $PrayerVerseCrossRefCopyWith<$Res> {
  _$PrayerVerseCrossRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verseId = null,
    Object? prayerId = null,
    Object? orderItem = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      verseId: null == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int,
      prayerId: null == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrayerVerseCrossRefCopyWith<$Res>
    implements $PrayerVerseCrossRefCopyWith<$Res> {
  factory _$$_PrayerVerseCrossRefCopyWith(_$_PrayerVerseCrossRef value,
          $Res Function(_$_PrayerVerseCrossRef) then) =
      __$$_PrayerVerseCrossRefCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int verseId, int prayerId, int orderItem, int? id});
}

/// @nodoc
class __$$_PrayerVerseCrossRefCopyWithImpl<$Res>
    extends _$PrayerVerseCrossRefCopyWithImpl<$Res, _$_PrayerVerseCrossRef>
    implements _$$_PrayerVerseCrossRefCopyWith<$Res> {
  __$$_PrayerVerseCrossRefCopyWithImpl(_$_PrayerVerseCrossRef _value,
      $Res Function(_$_PrayerVerseCrossRef) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verseId = null,
    Object? prayerId = null,
    Object? orderItem = null,
    Object? id = freezed,
  }) {
    return _then(_$_PrayerVerseCrossRef(
      verseId: null == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int,
      prayerId: null == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as int,
      orderItem: null == orderItem
          ? _value.orderItem
          : orderItem // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_PrayerVerseCrossRef
    with DiagnosticableTreeMixin
    implements _PrayerVerseCrossRef {
  const _$_PrayerVerseCrossRef(
      {required this.verseId,
      required this.prayerId,
      required this.orderItem,
      this.id});

  @override
  final int verseId;
  @override
  final int prayerId;
  @override
  final int orderItem;
  @override
  final int? id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrayerVerseCrossRef(verseId: $verseId, prayerId: $prayerId, orderItem: $orderItem, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrayerVerseCrossRef'))
      ..add(DiagnosticsProperty('verseId', verseId))
      ..add(DiagnosticsProperty('prayerId', prayerId))
      ..add(DiagnosticsProperty('orderItem', orderItem))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrayerVerseCrossRef &&
            (identical(other.verseId, verseId) || other.verseId == verseId) &&
            (identical(other.prayerId, prayerId) ||
                other.prayerId == prayerId) &&
            (identical(other.orderItem, orderItem) ||
                other.orderItem == orderItem) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, verseId, prayerId, orderItem, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrayerVerseCrossRefCopyWith<_$_PrayerVerseCrossRef> get copyWith =>
      __$$_PrayerVerseCrossRefCopyWithImpl<_$_PrayerVerseCrossRef>(
          this, _$identity);
}

abstract class _PrayerVerseCrossRef implements PrayerVerseCrossRef {
  const factory _PrayerVerseCrossRef(
      {required final int verseId,
      required final int prayerId,
      required final int orderItem,
      final int? id}) = _$_PrayerVerseCrossRef;

  @override
  int get verseId;
  @override
  int get prayerId;
  @override
  int get orderItem;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$_PrayerVerseCrossRefCopyWith<_$_PrayerVerseCrossRef> get copyWith =>
      throw _privateConstructorUsedError;
}
