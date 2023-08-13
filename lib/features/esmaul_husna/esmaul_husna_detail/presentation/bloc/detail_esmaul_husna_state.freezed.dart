// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_esmaul_husna_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DetailEsmaulHusnaState {
  List<EsmaulHusna> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  FontModel get fontModel => throw _privateConstructorUsedError;
  EsmaulHusna? get currentItem => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetailEsmaulHusnaStateCopyWith<DetailEsmaulHusnaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailEsmaulHusnaStateCopyWith<$Res> {
  factory $DetailEsmaulHusnaStateCopyWith(DetailEsmaulHusnaState value,
          $Res Function(DetailEsmaulHusnaState) then) =
      _$DetailEsmaulHusnaStateCopyWithImpl<$Res, DetailEsmaulHusnaState>;
  @useResult
  $Res call(
      {List<EsmaulHusna> items,
      bool isLoading,
      FontModel fontModel,
      EsmaulHusna? currentItem,
      String? message});

  $EsmaulHusnaCopyWith<$Res>? get currentItem;
}

/// @nodoc
class _$DetailEsmaulHusnaStateCopyWithImpl<$Res,
        $Val extends DetailEsmaulHusnaState>
    implements $DetailEsmaulHusnaStateCopyWith<$Res> {
  _$DetailEsmaulHusnaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? fontModel = null,
    Object? currentItem = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<EsmaulHusna>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      fontModel: null == fontModel
          ? _value.fontModel
          : fontModel // ignore: cast_nullable_to_non_nullable
              as FontModel,
      currentItem: freezed == currentItem
          ? _value.currentItem
          : currentItem // ignore: cast_nullable_to_non_nullable
              as EsmaulHusna?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EsmaulHusnaCopyWith<$Res>? get currentItem {
    if (_value.currentItem == null) {
      return null;
    }

    return $EsmaulHusnaCopyWith<$Res>(_value.currentItem!, (value) {
      return _then(_value.copyWith(currentItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DetailEsmaulHusnaStateCopyWith<$Res>
    implements $DetailEsmaulHusnaStateCopyWith<$Res> {
  factory _$$_DetailEsmaulHusnaStateCopyWith(_$_DetailEsmaulHusnaState value,
          $Res Function(_$_DetailEsmaulHusnaState) then) =
      __$$_DetailEsmaulHusnaStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<EsmaulHusna> items,
      bool isLoading,
      FontModel fontModel,
      EsmaulHusna? currentItem,
      String? message});

  @override
  $EsmaulHusnaCopyWith<$Res>? get currentItem;
}

/// @nodoc
class __$$_DetailEsmaulHusnaStateCopyWithImpl<$Res>
    extends _$DetailEsmaulHusnaStateCopyWithImpl<$Res,
        _$_DetailEsmaulHusnaState>
    implements _$$_DetailEsmaulHusnaStateCopyWith<$Res> {
  __$$_DetailEsmaulHusnaStateCopyWithImpl(_$_DetailEsmaulHusnaState _value,
      $Res Function(_$_DetailEsmaulHusnaState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? fontModel = null,
    Object? currentItem = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_DetailEsmaulHusnaState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<EsmaulHusna>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      fontModel: null == fontModel
          ? _value.fontModel
          : fontModel // ignore: cast_nullable_to_non_nullable
              as FontModel,
      currentItem: freezed == currentItem
          ? _value.currentItem
          : currentItem // ignore: cast_nullable_to_non_nullable
              as EsmaulHusna?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DetailEsmaulHusnaState
    with DiagnosticableTreeMixin
    implements _DetailEsmaulHusnaState {
  const _$_DetailEsmaulHusnaState(
      {required final List<EsmaulHusna> items,
      required this.isLoading,
      required this.fontModel,
      this.currentItem,
      this.message})
      : _items = items;

  final List<EsmaulHusna> _items;
  @override
  List<EsmaulHusna> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isLoading;
  @override
  final FontModel fontModel;
  @override
  final EsmaulHusna? currentItem;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DetailEsmaulHusnaState(items: $items, isLoading: $isLoading, fontModel: $fontModel, currentItem: $currentItem, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DetailEsmaulHusnaState'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('fontModel', fontModel))
      ..add(DiagnosticsProperty('currentItem', currentItem))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailEsmaulHusnaState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.fontModel, fontModel) ||
                other.fontModel == fontModel) &&
            (identical(other.currentItem, currentItem) ||
                other.currentItem == currentItem) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      fontModel,
      currentItem,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailEsmaulHusnaStateCopyWith<_$_DetailEsmaulHusnaState> get copyWith =>
      __$$_DetailEsmaulHusnaStateCopyWithImpl<_$_DetailEsmaulHusnaState>(
          this, _$identity);
}

abstract class _DetailEsmaulHusnaState implements DetailEsmaulHusnaState {
  const factory _DetailEsmaulHusnaState(
      {required final List<EsmaulHusna> items,
      required final bool isLoading,
      required final FontModel fontModel,
      final EsmaulHusna? currentItem,
      final String? message}) = _$_DetailEsmaulHusnaState;

  @override
  List<EsmaulHusna> get items;
  @override
  bool get isLoading;
  @override
  FontModel get fontModel;
  @override
  EsmaulHusna? get currentItem;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_DetailEsmaulHusnaStateCopyWith<_$_DetailEsmaulHusnaState> get copyWith =>
      throw _privateConstructorUsedError;
}
