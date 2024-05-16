// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      orderId: json['orderId'] as String,
      name: json['name'] as String,
      memberEmail: json['memberEmail'] as String,
      memberSocialId: json['memberSocialId'] as String,
      totalAmount: (json['totalAmount'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'name': instance.name,
      'memberEmail': instance.memberEmail,
      'memberSocialId': instance.memberSocialId,
      'totalAmount': instance.totalAmount,
    };

_$ItemIdAndQuantityImpl _$$ItemIdAndQuantityImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemIdAndQuantityImpl(
      itemId: (json['itemId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$ItemIdAndQuantityImplToJson(
        _$ItemIdAndQuantityImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'quantity': instance.quantity,
    };

_$RegisterOrderDtoImpl _$$RegisterOrderDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterOrderDtoImpl(
      itemIdAndQuantities: (json['itemIdAndQuantities'] as List<dynamic>)
          .map((e) => ItemIdAndQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RegisterOrderDtoImplToJson(
        _$RegisterOrderDtoImpl instance) =>
    <String, dynamic>{
      'itemIdAndQuantities': instance.itemIdAndQuantities,
    };
