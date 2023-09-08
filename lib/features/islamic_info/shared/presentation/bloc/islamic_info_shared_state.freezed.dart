// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'islamic_info_shared_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IslamicInfoSharedState {
  List<IslamicInfoCollection> get items => throw _privateConstructorUsedError;
  IslamicInfoType get infoType => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  FontModel get fontModel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IslamicInfoSharedStateCopyWith<IslamicInfoSharedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IslamicInfoSharedStateCopyWith<$Res> {
  factory $IslamicInfoSharedStateCopyWith(IslamicInfoSharedState value,
          $Res Function(IslamicInfoSharedState) then) =
      _$IslamicInfoSharedStateCopyWithImpl<$Res, IslamicInfoSharedState>;
  @useResult
  $Res call(
      {List<IslamicInfoCollection> items,
      IslamicInfoType infoType,
      bool isLoading,
      FontModel fontModel});

  $FontModelCopyWith<$Res> get fontModel;
}

/// @nodoc
class _$IslamicInfoSharedStateCopyWithImpl<$Res,
        $Val extends IslamicInfoSharedState>
    implements $IslamicInfoSharedStateCopyWith<$Res> {
  _$IslamicInfoSharedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? infoType = null,
    Object? isLoading = null,
    Object? fontModel = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<IslamicInfoCollection>,
      infoType: null == infoType
          ? _value.infoType
          : infoType // ignore: cast_nullable_to_non_nullable
              as IslamicInfoType,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      fontModel: null == fontModel
          ? _value.fontModel
          : fontModel // ignore: cast_nullable_to_non_nullable
              as FontModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FontModelCopyWith<$Res> get fontModel {
    return $FontModelCopyWith<$Res>(_value.fontModel, (value) {
      return _then(_value.copyWith(fontModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_IslamicInfoSharedStateCopyWith<$Res>
    implements $IslamicInfoSharedStateCopyWith<$Res> {
  factory _$$_IslamicInfoSharedStateCopyWith(_$_IslamicInfoSharedState value,
          $Res Function(_$_IslamicInfoSharedState) then) =
      __$$_IslamicInfoSharedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<IslamicInfoCollection> items,
      IslamicInfoType infoType,
      bool isLoading,
      FontModel fontModel});

  @override
  $FontModelCopyWith<$Res> get fontModel;
}

/// @nodoc
class __$$_IslamicInfoSharedStateCopyWithImpl<$Res>
    extends _$IslamicInfoSharedStateCopyWithImpl<$Res,
        _$_IslamicInfoSharedState>
    implements _$$_IslamicInfoSharedStateCopyWith<$Res> {
  __$$_IslamicInfoSharedStateCopyWithImpl(_$_IslamicInfoSharedState _value,
      $Res Function(_$_IslamicInfoSharedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? infoType = null,
    Object? isLoading = null,
    Object? fontModel = null,
  }) {
    return _then(_$_IslamicInfoSharedState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<IslamicInfoCollection>,
      infoType: null == infoType
          ? _value.infoType
          : infoType // ignore: cast_nullable_to_non_nullable
              as IslamicInfoType,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      fontModel: null == fontModel
          ? _value.fontModel
          : fontModel // ignore: cast_nullable_to_non_nullable
              as FontModel,
    ));
  }
}

/// @nodoc

class _$_IslamicInfoSharedState
    with DiagnosticableTreeMixin
    implements _IslamicInfoSharedState {
  const _$_IslamicInfoSharedState(
      {required final List<IslamicInfoCollection> items,
      required this.infoType,
      required this.isLoading,
      required this.fontModel})
      : _items = items;

  final List<IslamicInfoCollection> _items;
  @override
  List<IslamicInfoCollection> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final IslamicInfoType infoType;
  @override
  final bool isLoading;
  @override
  final FontModel fontModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IslamicInfoSharedState(items: $items, infoType: $infoType, isLoading: $isLoading, fontModel: $fontModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IslamicInfoSharedState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('infoType', infoType))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('fontModel', fontModel));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IslamicInfoSharedState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.infoType, infoType) ||
                other.infoType == infoType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.fontModel, fontModel) ||
                other.fontModel == fontModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      infoType,
      isLoading,
      fontModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IslamicInfoSharedStateCopyWith<_$_IslamicInfoSharedState> get copyWith =>
      __$$_IslamicInfoSharedStateCopyWithImpl<_$_IslamicInfoSharedState>(
          this, _$identity);
}

abstract class _IslamicInfoSharedState implements IslamicInfoSharedState {
  const factory _IslamicInfoSharedState(
      {required final List<IslamicInfoCollection> items,
      required final IslamicInfoType infoType,
      required final bool isLoading,
      required final FontModel fontModel}) = _$_IslamicInfoSharedState;

  @override
  List<IslamicInfoCollection> get items;
  @override
  IslamicInfoType get infoType;
  @override
  bool get isLoading;
  @override
  FontModel get fontModel;
  @override
  @JsonKey(ignore: true)
  _$$_IslamicInfoSharedStateCopyWith<_$_IslamicInfoSharedState> get copyWith =>
      throw _privateConstructorUsedError;
}
