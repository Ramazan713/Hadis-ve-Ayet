// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'islamic_info_collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IslamicInfoCollection {
  IslamicInfoTitle get infoTitle => throw _privateConstructorUsedError;
  List<IslamicInfoItem> get infoItems => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IslamicInfoCollectionCopyWith<IslamicInfoCollection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IslamicInfoCollectionCopyWith<$Res> {
  factory $IslamicInfoCollectionCopyWith(IslamicInfoCollection value,
          $Res Function(IslamicInfoCollection) then) =
      _$IslamicInfoCollectionCopyWithImpl<$Res, IslamicInfoCollection>;
  @useResult
  $Res call({IslamicInfoTitle infoTitle, List<IslamicInfoItem> infoItems});

  $IslamicInfoTitleCopyWith<$Res> get infoTitle;
}

/// @nodoc
class _$IslamicInfoCollectionCopyWithImpl<$Res,
        $Val extends IslamicInfoCollection>
    implements $IslamicInfoCollectionCopyWith<$Res> {
  _$IslamicInfoCollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? infoTitle = null,
    Object? infoItems = null,
  }) {
    return _then(_value.copyWith(
      infoTitle: null == infoTitle
          ? _value.infoTitle
          : infoTitle // ignore: cast_nullable_to_non_nullable
              as IslamicInfoTitle,
      infoItems: null == infoItems
          ? _value.infoItems
          : infoItems // ignore: cast_nullable_to_non_nullable
              as List<IslamicInfoItem>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IslamicInfoTitleCopyWith<$Res> get infoTitle {
    return $IslamicInfoTitleCopyWith<$Res>(_value.infoTitle, (value) {
      return _then(_value.copyWith(infoTitle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_IslamicInfoCollectionCopyWith<$Res>
    implements $IslamicInfoCollectionCopyWith<$Res> {
  factory _$$_IslamicInfoCollectionCopyWith(_$_IslamicInfoCollection value,
          $Res Function(_$_IslamicInfoCollection) then) =
      __$$_IslamicInfoCollectionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IslamicInfoTitle infoTitle, List<IslamicInfoItem> infoItems});

  @override
  $IslamicInfoTitleCopyWith<$Res> get infoTitle;
}

/// @nodoc
class __$$_IslamicInfoCollectionCopyWithImpl<$Res>
    extends _$IslamicInfoCollectionCopyWithImpl<$Res, _$_IslamicInfoCollection>
    implements _$$_IslamicInfoCollectionCopyWith<$Res> {
  __$$_IslamicInfoCollectionCopyWithImpl(_$_IslamicInfoCollection _value,
      $Res Function(_$_IslamicInfoCollection) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? infoTitle = null,
    Object? infoItems = null,
  }) {
    return _then(_$_IslamicInfoCollection(
      infoTitle: null == infoTitle
          ? _value.infoTitle
          : infoTitle // ignore: cast_nullable_to_non_nullable
              as IslamicInfoTitle,
      infoItems: null == infoItems
          ? _value._infoItems
          : infoItems // ignore: cast_nullable_to_non_nullable
              as List<IslamicInfoItem>,
    ));
  }
}

/// @nodoc

class _$_IslamicInfoCollection
    with DiagnosticableTreeMixin
    implements _IslamicInfoCollection {
  const _$_IslamicInfoCollection(
      {required this.infoTitle, required final List<IslamicInfoItem> infoItems})
      : _infoItems = infoItems;

  @override
  final IslamicInfoTitle infoTitle;
  final List<IslamicInfoItem> _infoItems;
  @override
  List<IslamicInfoItem> get infoItems {
    if (_infoItems is EqualUnmodifiableListView) return _infoItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_infoItems);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IslamicInfoCollection(infoTitle: $infoTitle, infoItems: $infoItems)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IslamicInfoCollection'))
      ..add(DiagnosticsProperty('infoTitle', infoTitle))
      ..add(DiagnosticsProperty('infoItems', infoItems));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IslamicInfoCollection &&
            (identical(other.infoTitle, infoTitle) ||
                other.infoTitle == infoTitle) &&
            const DeepCollectionEquality()
                .equals(other._infoItems, _infoItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, infoTitle, const DeepCollectionEquality().hash(_infoItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IslamicInfoCollectionCopyWith<_$_IslamicInfoCollection> get copyWith =>
      __$$_IslamicInfoCollectionCopyWithImpl<_$_IslamicInfoCollection>(
          this, _$identity);
}

abstract class _IslamicInfoCollection implements IslamicInfoCollection {
  const factory _IslamicInfoCollection(
          {required final IslamicInfoTitle infoTitle,
          required final List<IslamicInfoItem> infoItems}) =
      _$_IslamicInfoCollection;

  @override
  IslamicInfoTitle get infoTitle;
  @override
  List<IslamicInfoItem> get infoItems;
  @override
  @JsonKey(ignore: true)
  _$$_IslamicInfoCollectionCopyWith<_$_IslamicInfoCollection> get copyWith =>
      throw _privateConstructorUsedError;
}
