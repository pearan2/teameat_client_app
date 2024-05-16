// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String get orderId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get memberEmail => throw _privateConstructorUsedError;
  String get memberSocialId => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {String orderId,
      String name,
      String memberEmail,
      String memberSocialId,
      int totalAmount});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? name = null,
    Object? memberEmail = null,
    Object? memberSocialId = null,
    Object? totalAmount = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      memberEmail: null == memberEmail
          ? _value.memberEmail
          : memberEmail // ignore: cast_nullable_to_non_nullable
              as String,
      memberSocialId: null == memberSocialId
          ? _value.memberSocialId
          : memberSocialId // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String orderId,
      String name,
      String memberEmail,
      String memberSocialId,
      int totalAmount});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? name = null,
    Object? memberEmail = null,
    Object? memberSocialId = null,
    Object? totalAmount = null,
  }) {
    return _then(_$OrderImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      memberEmail: null == memberEmail
          ? _value.memberEmail
          : memberEmail // ignore: cast_nullable_to_non_nullable
              as String,
      memberSocialId: null == memberSocialId
          ? _value.memberSocialId
          : memberSocialId // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {required this.orderId,
      required this.name,
      required this.memberEmail,
      required this.memberSocialId,
      required this.totalAmount});

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String orderId;
  @override
  final String name;
  @override
  final String memberEmail;
  @override
  final String memberSocialId;
  @override
  final int totalAmount;

  @override
  String toString() {
    return 'Order(orderId: $orderId, name: $name, memberEmail: $memberEmail, memberSocialId: $memberSocialId, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.memberEmail, memberEmail) ||
                other.memberEmail == memberEmail) &&
            (identical(other.memberSocialId, memberSocialId) ||
                other.memberSocialId == memberSocialId) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, orderId, name, memberEmail, memberSocialId, totalAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {required final String orderId,
      required final String name,
      required final String memberEmail,
      required final String memberSocialId,
      required final int totalAmount}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String get orderId;
  @override
  String get name;
  @override
  String get memberEmail;
  @override
  String get memberSocialId;
  @override
  int get totalAmount;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemIdAndQuantity _$ItemIdAndQuantityFromJson(Map<String, dynamic> json) {
  return _ItemIdAndQuantity.fromJson(json);
}

/// @nodoc
mixin _$ItemIdAndQuantity {
  int get itemId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemIdAndQuantityCopyWith<ItemIdAndQuantity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemIdAndQuantityCopyWith<$Res> {
  factory $ItemIdAndQuantityCopyWith(
          ItemIdAndQuantity value, $Res Function(ItemIdAndQuantity) then) =
      _$ItemIdAndQuantityCopyWithImpl<$Res, ItemIdAndQuantity>;
  @useResult
  $Res call({int itemId, int quantity});
}

/// @nodoc
class _$ItemIdAndQuantityCopyWithImpl<$Res, $Val extends ItemIdAndQuantity>
    implements $ItemIdAndQuantityCopyWith<$Res> {
  _$ItemIdAndQuantityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemIdAndQuantityImplCopyWith<$Res>
    implements $ItemIdAndQuantityCopyWith<$Res> {
  factory _$$ItemIdAndQuantityImplCopyWith(_$ItemIdAndQuantityImpl value,
          $Res Function(_$ItemIdAndQuantityImpl) then) =
      __$$ItemIdAndQuantityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int itemId, int quantity});
}

/// @nodoc
class __$$ItemIdAndQuantityImplCopyWithImpl<$Res>
    extends _$ItemIdAndQuantityCopyWithImpl<$Res, _$ItemIdAndQuantityImpl>
    implements _$$ItemIdAndQuantityImplCopyWith<$Res> {
  __$$ItemIdAndQuantityImplCopyWithImpl(_$ItemIdAndQuantityImpl _value,
      $Res Function(_$ItemIdAndQuantityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? quantity = null,
  }) {
    return _then(_$ItemIdAndQuantityImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemIdAndQuantityImpl implements _ItemIdAndQuantity {
  const _$ItemIdAndQuantityImpl({required this.itemId, required this.quantity});

  factory _$ItemIdAndQuantityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemIdAndQuantityImplFromJson(json);

  @override
  final int itemId;
  @override
  final int quantity;

  @override
  String toString() {
    return 'ItemIdAndQuantity(itemId: $itemId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemIdAndQuantityImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, itemId, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemIdAndQuantityImplCopyWith<_$ItemIdAndQuantityImpl> get copyWith =>
      __$$ItemIdAndQuantityImplCopyWithImpl<_$ItemIdAndQuantityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemIdAndQuantityImplToJson(
      this,
    );
  }
}

abstract class _ItemIdAndQuantity implements ItemIdAndQuantity {
  const factory _ItemIdAndQuantity(
      {required final int itemId,
      required final int quantity}) = _$ItemIdAndQuantityImpl;

  factory _ItemIdAndQuantity.fromJson(Map<String, dynamic> json) =
      _$ItemIdAndQuantityImpl.fromJson;

  @override
  int get itemId;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ItemIdAndQuantityImplCopyWith<_$ItemIdAndQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterOrderDto _$RegisterOrderDtoFromJson(Map<String, dynamic> json) {
  return _RegisterOrderDto.fromJson(json);
}

/// @nodoc
mixin _$RegisterOrderDto {
  List<ItemIdAndQuantity> get itemIdAndQuantities =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterOrderDtoCopyWith<RegisterOrderDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterOrderDtoCopyWith<$Res> {
  factory $RegisterOrderDtoCopyWith(
          RegisterOrderDto value, $Res Function(RegisterOrderDto) then) =
      _$RegisterOrderDtoCopyWithImpl<$Res, RegisterOrderDto>;
  @useResult
  $Res call({List<ItemIdAndQuantity> itemIdAndQuantities});
}

/// @nodoc
class _$RegisterOrderDtoCopyWithImpl<$Res, $Val extends RegisterOrderDto>
    implements $RegisterOrderDtoCopyWith<$Res> {
  _$RegisterOrderDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemIdAndQuantities = null,
  }) {
    return _then(_value.copyWith(
      itemIdAndQuantities: null == itemIdAndQuantities
          ? _value.itemIdAndQuantities
          : itemIdAndQuantities // ignore: cast_nullable_to_non_nullable
              as List<ItemIdAndQuantity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterOrderDtoImplCopyWith<$Res>
    implements $RegisterOrderDtoCopyWith<$Res> {
  factory _$$RegisterOrderDtoImplCopyWith(_$RegisterOrderDtoImpl value,
          $Res Function(_$RegisterOrderDtoImpl) then) =
      __$$RegisterOrderDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ItemIdAndQuantity> itemIdAndQuantities});
}

/// @nodoc
class __$$RegisterOrderDtoImplCopyWithImpl<$Res>
    extends _$RegisterOrderDtoCopyWithImpl<$Res, _$RegisterOrderDtoImpl>
    implements _$$RegisterOrderDtoImplCopyWith<$Res> {
  __$$RegisterOrderDtoImplCopyWithImpl(_$RegisterOrderDtoImpl _value,
      $Res Function(_$RegisterOrderDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemIdAndQuantities = null,
  }) {
    return _then(_$RegisterOrderDtoImpl(
      itemIdAndQuantities: null == itemIdAndQuantities
          ? _value._itemIdAndQuantities
          : itemIdAndQuantities // ignore: cast_nullable_to_non_nullable
              as List<ItemIdAndQuantity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterOrderDtoImpl implements _RegisterOrderDto {
  const _$RegisterOrderDtoImpl(
      {required final List<ItemIdAndQuantity> itemIdAndQuantities})
      : _itemIdAndQuantities = itemIdAndQuantities;

  factory _$RegisterOrderDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterOrderDtoImplFromJson(json);

  final List<ItemIdAndQuantity> _itemIdAndQuantities;
  @override
  List<ItemIdAndQuantity> get itemIdAndQuantities {
    if (_itemIdAndQuantities is EqualUnmodifiableListView)
      return _itemIdAndQuantities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIdAndQuantities);
  }

  @override
  String toString() {
    return 'RegisterOrderDto(itemIdAndQuantities: $itemIdAndQuantities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterOrderDtoImpl &&
            const DeepCollectionEquality()
                .equals(other._itemIdAndQuantities, _itemIdAndQuantities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_itemIdAndQuantities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterOrderDtoImplCopyWith<_$RegisterOrderDtoImpl> get copyWith =>
      __$$RegisterOrderDtoImplCopyWithImpl<_$RegisterOrderDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterOrderDtoImplToJson(
      this,
    );
  }
}

abstract class _RegisterOrderDto implements RegisterOrderDto {
  const factory _RegisterOrderDto(
          {required final List<ItemIdAndQuantity> itemIdAndQuantities}) =
      _$RegisterOrderDtoImpl;

  factory _RegisterOrderDto.fromJson(Map<String, dynamic> json) =
      _$RegisterOrderDtoImpl.fromJson;

  @override
  List<ItemIdAndQuantity> get itemIdAndQuantities;
  @override
  @JsonKey(ignore: true)
  _$$RegisterOrderDtoImplCopyWith<_$RegisterOrderDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
