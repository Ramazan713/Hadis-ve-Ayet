// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PremiumState {
  bool get isPremium => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<SubscriptionModel> get items => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PremiumStateCopyWith<PremiumState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumStateCopyWith<$Res> {
  factory $PremiumStateCopyWith(
          PremiumState value, $Res Function(PremiumState) then) =
      _$PremiumStateCopyWithImpl<$Res, PremiumState>;
  @useResult
  $Res call(
      {bool isPremium,
      bool isLoading,
      List<SubscriptionModel> items,
      List<String> features,
      String? error});
}

/// @nodoc
class _$PremiumStateCopyWithImpl<$Res, $Val extends PremiumState>
    implements $PremiumStateCopyWith<$Res> {
  _$PremiumStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPremium = null,
    Object? isLoading = null,
    Object? items = null,
    Object? features = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionModel>,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PremiumStateCopyWith<$Res>
    implements $PremiumStateCopyWith<$Res> {
  factory _$$_PremiumStateCopyWith(
          _$_PremiumState value, $Res Function(_$_PremiumState) then) =
      __$$_PremiumStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPremium,
      bool isLoading,
      List<SubscriptionModel> items,
      List<String> features,
      String? error});
}

/// @nodoc
class __$$_PremiumStateCopyWithImpl<$Res>
    extends _$PremiumStateCopyWithImpl<$Res, _$_PremiumState>
    implements _$$_PremiumStateCopyWith<$Res> {
  __$$_PremiumStateCopyWithImpl(
      _$_PremiumState _value, $Res Function(_$_PremiumState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPremium = null,
    Object? isLoading = null,
    Object? items = null,
    Object? features = null,
    Object? error = freezed,
  }) {
    return _then(_$_PremiumState(
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionModel>,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_PremiumState with DiagnosticableTreeMixin implements _PremiumState {
  const _$_PremiumState(
      {required this.isPremium,
      required this.isLoading,
      required final List<SubscriptionModel> items,
      required final List<String> features,
      this.error})
      : _items = items,
        _features = features;

  @override
  final bool isPremium;
  @override
  final bool isLoading;
  final List<SubscriptionModel> _items;
  @override
  List<SubscriptionModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _features;
  @override
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  final String? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PremiumState(isPremium: $isPremium, isLoading: $isLoading, items: $items, features: $features, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PremiumState'))
      ..add(DiagnosticsProperty('isPremium', isPremium))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('features', features))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PremiumState &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isPremium,
      isLoading,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_features),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PremiumStateCopyWith<_$_PremiumState> get copyWith =>
      __$$_PremiumStateCopyWithImpl<_$_PremiumState>(this, _$identity);
}

abstract class _PremiumState implements PremiumState {
  const factory _PremiumState(
      {required final bool isPremium,
      required final bool isLoading,
      required final List<SubscriptionModel> items,
      required final List<String> features,
      final String? error}) = _$_PremiumState;

  @override
  bool get isPremium;
  @override
  bool get isLoading;
  @override
  List<SubscriptionModel> get items;
  @override
  List<String> get features;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$_PremiumStateCopyWith<_$_PremiumState> get copyWith =>
      throw _privateConstructorUsedError;
}
