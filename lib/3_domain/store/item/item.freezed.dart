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
  final DateTime? currentGroupBuyingWillBeEndedAt;

  @override
  String toString() {
    return 'ItemSimple(id: $id, name: $name, imageUrl: $imageUrl, originalPrice: $originalPrice, price: $price, sellType: $sellType, currentGroupBuyingWillBeEndedAt: $currentGroupBuyingWillBeEndedAt)';
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
            (identical(other.currentGroupBuyingWillBeEndedAt,
                    currentGroupBuyingWillBeEndedAt) ||
                other.currentGroupBuyingWillBeEndedAt ==
                    currentGroupBuyingWillBeEndedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, imageUrl,
      originalPrice, price, sellType, currentGroupBuyingWillBeEndedAt);

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
  DateTime? get currentGroupBuyingWillBeEndedAt;
  @override
  @JsonKey(ignore: true)
  _$$ItemSimpleImplCopyWith<_$ItemSimpleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
