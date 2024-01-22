// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SubscriptionModel {
  String get title => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  ProductDetails get productDetails => throw _privateConstructorUsedError;
  String? get trialContent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SubscriptionModelCopyWith<SubscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionModelCopyWith<$Res> {
  factory $SubscriptionModelCopyWith(
          SubscriptionModel value, $Res Function(SubscriptionModel) then) =
      _$SubscriptionModelCopyWithImpl<$Res, SubscriptionModel>;
  @useResult
  $Res call(
      {String title,
      String price,
      ProductDetails productDetails,
      String? trialContent});
}

/// @nodoc
class _$SubscriptionModelCopyWithImpl<$Res, $Val extends SubscriptionModel>
    implements $SubscriptionModelCopyWith<$Res> {
  _$SubscriptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? price = null,
    Object? productDetails = null,
    Object? trialContent = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      productDetails: null == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductDetails,
      trialContent: freezed == trialContent
          ? _value.trialContent
          : trialContent // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubscriptionModelCopyWith<$Res>
    implements $SubscriptionModelCopyWith<$Res> {
  factory _$$_SubscriptionModelCopyWith(_$_SubscriptionModel value,
          $Res Function(_$_SubscriptionModel) then) =
      __$$_SubscriptionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String price,
      ProductDetails productDetails,
      String? trialContent});
}

/// @nodoc
class __$$_SubscriptionModelCopyWithImpl<$Res>
    extends _$SubscriptionModelCopyWithImpl<$Res, _$_SubscriptionModel>
    implements _$$_SubscriptionModelCopyWith<$Res> {
  __$$_SubscriptionModelCopyWithImpl(
      _$_SubscriptionModel _value, $Res Function(_$_SubscriptionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? price = null,
    Object? productDetails = null,
    Object? trialContent = freezed,
  }) {
    return _then(_$_SubscriptionModel(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      productDetails: null == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductDetails,
      trialContent: freezed == trialContent
          ? _value.trialContent
          : trialContent // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SubscriptionModel
    with DiagnosticableTreeMixin
    implements _SubscriptionModel {
  const _$_SubscriptionModel(
      {required this.title,
      required this.price,
      required this.productDetails,
      this.trialContent});

  @override
  final String title;
  @override
  final String price;
  @override
  final ProductDetails productDetails;
  @override
  final String? trialContent;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubscriptionModel(title: $title, price: $price, productDetails: $productDetails, trialContent: $trialContent)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubscriptionModel'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('productDetails', productDetails))
      ..add(DiagnosticsProperty('trialContent', trialContent));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SubscriptionModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.productDetails, productDetails) ||
                other.productDetails == productDetails) &&
            (identical(other.trialContent, trialContent) ||
                other.trialContent == trialContent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, price, productDetails, trialContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubscriptionModelCopyWith<_$_SubscriptionModel> get copyWith =>
      __$$_SubscriptionModelCopyWithImpl<_$_SubscriptionModel>(
          this, _$identity);
}

abstract class _SubscriptionModel implements SubscriptionModel {
  const factory _SubscriptionModel(
      {required final String title,
      required final String price,
      required final ProductDetails productDetails,
      final String? trialContent}) = _$_SubscriptionModel;

  @override
  String get title;
  @override
  String get price;
  @override
  ProductDetails get productDetails;
  @override
  String? get trialContent;
  @override
  @JsonKey(ignore: true)
  _$$_SubscriptionModelCopyWith<_$_SubscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
