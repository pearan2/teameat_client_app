// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemSimple _$ItemSimpleFromJson(Map<String, dynamic> json) {
  return _ItemSimple.fromJson(json);
}

/// @nodoc
mixin _$ItemSimple {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get originalPrice => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get sellType => throw _privateConstructorUsedError;
  DateTime get salesWillBeEndedAt => throw _privateConstructorUsedError;
  DateTime? get currentGroupBuyingWillBeEndedAt =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemSimpleCopyWith<ItemSimple> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemSimpleCopyWith<$Res> {
  factory $ItemSimpleCopyWith(
          ItemSimple value, $Res Function(ItemSimple) then) =
      _$ItemSimpleCopyWithImpl<$Res, ItemSimple>;
  @useResult
  $Res call(
      {int id,
      String name,
      String imageUrl,
      int originalPrice,
      int price,
      String sellType,
      DateTime salesWillBeEndedAt,
      DateTime? currentGroupBuyingWillBeEndedAt});
}

/// @nodoc
class _$ItemSimpleCopyWithImpl<$Res, $Val extends ItemSimple>
    implements $ItemSimpleCopyWith<$Res> {
  _$ItemSimpleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? originalPrice = null,
    Object? price = null,
    Object? sellType = null,
    Object? salesWillBeEndedAt = null,
    Object? currentGroupBuyingWillBeEndedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sellType: null == sellType
          ? _value.sellType
          : sellType // ignore: cast_nullable_to_non_nullable
              as String,
      salesWillBeEndedAt: null == salesWillBeEndedAt
          ? _value.salesWillBeEndedAt
          : salesWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentGroupBuyingWillBeEndedAt: freezed ==
              currentGroupBuyingWillBeEndedAt
          ? _value.currentGroupBuyingWillBeEndedAt
          : currentGroupBuyingWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemSimpleImplCopyWith<$Res>
    implements $ItemSimpleCopyWith<$Res> {
  factory _$$ItemSimpleImplCopyWith(
          _$ItemSimpleImpl value, $Res Function(_$ItemSimpleImpl) then) =
      __$$ItemSimpleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String imageUrl,
      int originalPrice,
      int price,
      String sellType,
      DateTime salesWillBeEndedAt,
      DateTime? currentGroupBuyingWillBeEndedAt});
}

/// @nodoc
class __$$ItemSimpleImplCopyWithImpl<$Res>
    extends _$ItemSimpleCopyWithImpl<$Res, _$ItemSimpleImpl>
    implements _$$ItemSimpleImplCopyWith<$Res> {
  __$$ItemSimpleImplCopyWithImpl(
      _$ItemSimpleImpl _value, $Res Function(_$ItemSimpleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? originalPrice = null,
    Object? price = null,
    Object? sellType = null,
    Object? salesWillBeEndedAt = null,
    Object? currentGroupBuyingWillBeEndedAt = freezed,
  }) {
    return _then(_$ItemSimpleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sellType: null == sellType
          ? _value.sellType
          : sellType // ignore: cast_nullable_to_non_nullable
              as String,
      salesWillBeEndedAt: null == salesWillBeEndedAt
          ? _value.salesWillBeEndedAt
          : salesWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentGroupBuyingWillBeEndedAt: freezed ==
              currentGroupBuyingWillBeEndedAt
          ? _value.currentGroupBuyingWillBeEndedAt
          : currentGroupBuyingWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemSimpleImpl implements _ItemSimple {
  const _$ItemSimpleImpl(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.originalPrice,
      required this.price,
      required this.sellType,
      required this.salesWillBeEndedAt,
      this.currentGroupBuyingWillBeEndedAt});

  factory _$ItemSimpleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemSimpleImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final int originalPrice;
  @override
  final int price;
  @override
  final String sellType;
  @override
  final DateTime salesWillBeEndedAt;
  @override
  final DateTime? currentGroupBuyingWillBeEndedAt;

  @override
  String toString() {
    return 'ItemSimple(id: $id, name: $name, imageUrl: $imageUrl, originalPrice: $originalPrice, price: $price, sellType: $sellType, salesWillBeEndedAt: $salesWillBeEndedAt, currentGroupBuyingWillBeEndedAt: $currentGroupBuyingWillBeEndedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemSimpleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.sellType, sellType) ||
                other.sellType == sellType) &&
            (identical(other.salesWillBeEndedAt, salesWillBeEndedAt) ||
                other.salesWillBeEndedAt == salesWillBeEndedAt) &&
            (identical(other.currentGroupBuyingWillBeEndedAt,
                    currentGroupBuyingWillBeEndedAt) ||
                other.currentGroupBuyingWillBeEndedAt ==
                    currentGroupBuyingWillBeEndedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      imageUrl,
      originalPrice,
      price,
      sellType,
      salesWillBeEndedAt,
      currentGroupBuyingWillBeEndedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemSimpleImplCopyWith<_$ItemSimpleImpl> get copyWith =>
      __$$ItemSimpleImplCopyWithImpl<_$ItemSimpleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemSimpleImplToJson(
      this,
    );
  }
}

abstract class _ItemSimple implements ItemSimple {
  const factory _ItemSimple(
      {required final int id,
      required final String name,
      required final String imageUrl,
      required final int originalPrice,
      required final int price,
      required final String sellType,
      required final DateTime salesWillBeEndedAt,
      final DateTime? currentGroupBuyingWillBeEndedAt}) = _$ItemSimpleImpl;

  factory _ItemSimple.fromJson(Map<String, dynamic> json) =
      _$ItemSimpleImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get imageUrl;
  @override
  int get originalPrice;
  @override
  int get price;
  @override
  String get sellType;
  @override
  DateTime get salesWillBeEndedAt;
  @override
  DateTime? get currentGroupBuyingWillBeEndedAt;
  @override
  @JsonKey(ignore: true)
  _$$ItemSimpleImplCopyWith<_$ItemSimpleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemDetail _$ItemDetailFromJson(Map<String, dynamic> json) {
  return _ItemDetail.fromJson(json);
}

/// @nodoc
mixin _$ItemDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get originalPrice => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get sellType => throw _privateConstructorUsedError;
  DateTime get salesWillBeEndedAt => throw _privateConstructorUsedError;
  DateTime? get currentGroupBuyingWillBeEndedAt =>
      throw _privateConstructorUsedError;
  StoreDetail get store => throw _privateConstructorUsedError;
  String get introduce => throw _privateConstructorUsedError;
  int get numberOfLikes => throw _privateConstructorUsedError;
  DateTime get willBeExpiredAt => throw _privateConstructorUsedError;
  String get originInformation => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemDetailCopyWith<ItemDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemDetailCopyWith<$Res> {
  factory $ItemDetailCopyWith(
          ItemDetail value, $Res Function(ItemDetail) then) =
      _$ItemDetailCopyWithImpl<$Res, ItemDetail>;
  @useResult
  $Res call(
      {int id,
      String name,
      String imageUrl,
      int originalPrice,
      int price,
      String sellType,
      DateTime salesWillBeEndedAt,
      DateTime? currentGroupBuyingWillBeEndedAt,
      StoreDetail store,
      String introduce,
      int numberOfLikes,
      DateTime willBeExpiredAt,
      String originInformation,
      List<String> imageUrls});

  $StoreDetailCopyWith<$Res> get store;
}

/// @nodoc
class _$ItemDetailCopyWithImpl<$Res, $Val extends ItemDetail>
    implements $ItemDetailCopyWith<$Res> {
  _$ItemDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? originalPrice = null,
    Object? price = null,
    Object? sellType = null,
    Object? salesWillBeEndedAt = null,
    Object? currentGroupBuyingWillBeEndedAt = freezed,
    Object? store = null,
    Object? introduce = null,
    Object? numberOfLikes = null,
    Object? willBeExpiredAt = null,
    Object? originInformation = null,
    Object? imageUrls = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sellType: null == sellType
          ? _value.sellType
          : sellType // ignore: cast_nullable_to_non_nullable
              as String,
      salesWillBeEndedAt: null == salesWillBeEndedAt
          ? _value.salesWillBeEndedAt
          : salesWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentGroupBuyingWillBeEndedAt: freezed ==
              currentGroupBuyingWillBeEndedAt
          ? _value.currentGroupBuyingWillBeEndedAt
          : currentGroupBuyingWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      store: null == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as StoreDetail,
      introduce: null == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfLikes: null == numberOfLikes
          ? _value.numberOfLikes
          : numberOfLikes // ignore: cast_nullable_to_non_nullable
              as int,
      willBeExpiredAt: null == willBeExpiredAt
          ? _value.willBeExpiredAt
          : willBeExpiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originInformation: null == originInformation
          ? _value.originInformation
          : originInformation // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoreDetailCopyWith<$Res> get store {
    return $StoreDetailCopyWith<$Res>(_value.store, (value) {
      return _then(_value.copyWith(store: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ItemDetailImplCopyWith<$Res>
    implements $ItemDetailCopyWith<$Res> {
  factory _$$ItemDetailImplCopyWith(
          _$ItemDetailImpl value, $Res Function(_$ItemDetailImpl) then) =
      __$$ItemDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String imageUrl,
      int originalPrice,
      int price,
      String sellType,
      DateTime salesWillBeEndedAt,
      DateTime? currentGroupBuyingWillBeEndedAt,
      StoreDetail store,
      String introduce,
      int numberOfLikes,
      DateTime willBeExpiredAt,
      String originInformation,
      List<String> imageUrls});

  @override
  $StoreDetailCopyWith<$Res> get store;
}

/// @nodoc
class __$$ItemDetailImplCopyWithImpl<$Res>
    extends _$ItemDetailCopyWithImpl<$Res, _$ItemDetailImpl>
    implements _$$ItemDetailImplCopyWith<$Res> {
  __$$ItemDetailImplCopyWithImpl(
      _$ItemDetailImpl _value, $Res Function(_$ItemDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? originalPrice = null,
    Object? price = null,
    Object? sellType = null,
    Object? salesWillBeEndedAt = null,
    Object? currentGroupBuyingWillBeEndedAt = freezed,
    Object? store = null,
    Object? introduce = null,
    Object? numberOfLikes = null,
    Object? willBeExpiredAt = null,
    Object? originInformation = null,
    Object? imageUrls = null,
  }) {
    return _then(_$ItemDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sellType: null == sellType
          ? _value.sellType
          : sellType // ignore: cast_nullable_to_non_nullable
              as String,
      salesWillBeEndedAt: null == salesWillBeEndedAt
          ? _value.salesWillBeEndedAt
          : salesWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentGroupBuyingWillBeEndedAt: freezed ==
              currentGroupBuyingWillBeEndedAt
          ? _value.currentGroupBuyingWillBeEndedAt
          : currentGroupBuyingWillBeEndedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      store: null == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as StoreDetail,
      introduce: null == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfLikes: null == numberOfLikes
          ? _value.numberOfLikes
          : numberOfLikes // ignore: cast_nullable_to_non_nullable
              as int,
      willBeExpiredAt: null == willBeExpiredAt
          ? _value.willBeExpiredAt
          : willBeExpiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originInformation: null == originInformation
          ? _value.originInformation
          : originInformation // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemDetailImpl implements _ItemDetail {
  const _$ItemDetailImpl(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.originalPrice,
      required this.price,
      required this.sellType,
      required this.salesWillBeEndedAt,
      this.currentGroupBuyingWillBeEndedAt,
      required this.store,
      required this.introduce,
      required this.numberOfLikes,
      required this.willBeExpiredAt,
      required this.originInformation,
      required final List<String> imageUrls})
      : _imageUrls = imageUrls;

  factory _$ItemDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final int originalPrice;
  @override
  final int price;
  @override
  final String sellType;
  @override
  final DateTime salesWillBeEndedAt;
  @override
  final DateTime? currentGroupBuyingWillBeEndedAt;
  @override
  final StoreDetail store;
  @override
  final String introduce;
  @override
  final int numberOfLikes;
  @override
  final DateTime willBeExpiredAt;
  @override
  final String originInformation;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString() {
    return 'ItemDetail(id: $id, name: $name, imageUrl: $imageUrl, originalPrice: $originalPrice, price: $price, sellType: $sellType, salesWillBeEndedAt: $salesWillBeEndedAt, currentGroupBuyingWillBeEndedAt: $currentGroupBuyingWillBeEndedAt, store: $store, introduce: $introduce, numberOfLikes: $numberOfLikes, willBeExpiredAt: $willBeExpiredAt, originInformation: $originInformation, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.sellType, sellType) ||
                other.sellType == sellType) &&
            (identical(other.salesWillBeEndedAt, salesWillBeEndedAt) ||
                other.salesWillBeEndedAt == salesWillBeEndedAt) &&
            (identical(other.currentGroupBuyingWillBeEndedAt,
                    currentGroupBuyingWillBeEndedAt) ||
                other.currentGroupBuyingWillBeEndedAt ==
                    currentGroupBuyingWillBeEndedAt) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.introduce, introduce) ||
                other.introduce == introduce) &&
            (identical(other.numberOfLikes, numberOfLikes) ||
                other.numberOfLikes == numberOfLikes) &&
            (identical(other.willBeExpiredAt, willBeExpiredAt) ||
                other.willBeExpiredAt == willBeExpiredAt) &&
            (identical(other.originInformation, originInformation) ||
                other.originInformation == originInformation) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      imageUrl,
      originalPrice,
      price,
      sellType,
      salesWillBeEndedAt,
      currentGroupBuyingWillBeEndedAt,
      store,
      introduce,
      numberOfLikes,
      willBeExpiredAt,
      originInformation,
      const DeepCollectionEquality().hash(_imageUrls));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemDetailImplCopyWith<_$ItemDetailImpl> get copyWith =>
      __$$ItemDetailImplCopyWithImpl<_$ItemDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemDetailImplToJson(
      this,
    );
  }
}

abstract class _ItemDetail implements ItemDetail {
  const factory _ItemDetail(
      {required final int id,
      required final String name,
      required final String imageUrl,
      required final int originalPrice,
      required final int price,
      required final String sellType,
      required final DateTime salesWillBeEndedAt,
      final DateTime? currentGroupBuyingWillBeEndedAt,
      required final StoreDetail store,
      required final String introduce,
      required final int numberOfLikes,
      required final DateTime willBeExpiredAt,
      required final String originInformation,
      required final List<String> imageUrls}) = _$ItemDetailImpl;

  factory _ItemDetail.fromJson(Map<String, dynamic> json) =
      _$ItemDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get imageUrl;
  @override
  int get originalPrice;
  @override
  int get price;
  @override
  String get sellType;
  @override
  DateTime get salesWillBeEndedAt;
  @override
  DateTime? get currentGroupBuyingWillBeEndedAt;
  @override
  StoreDetail get store;
  @override
  String get introduce;
  @override
  int get numberOfLikes;
  @override
  DateTime get willBeExpiredAt;
  @override
  String get originInformation;
  @override
  List<String> get imageUrls;
  @override
  @JsonKey(ignore: true)
  _$$ItemDetailImplCopyWith<_$ItemDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
