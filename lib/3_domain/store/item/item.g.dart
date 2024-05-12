// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemSimpleImpl _$$ItemSimpleImplFromJson(Map<String, dynamic> json) =>
    _$ItemSimpleImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      originalPrice: (json['originalPrice'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      sellType: json['sellType'] as String,
      currentGroupBuyingWillBeEndedAt:
          json['currentGroupBuyingWillBeEndedAt'] == null
              ? null
              : DateTime.parse(
                  json['currentGroupBuyingWillBeEndedAt'] as String),
    );

Map<String, dynamic> _$$ItemSimpleImplToJson(_$ItemSimpleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'originalPrice': instance.originalPrice,
      'price': instance.price,
      'sellType': instance.sellType,
      'currentGroupBuyingWillBeEndedAt':
          instance.currentGroupBuyingWillBeEndedAt?.toIso8601String(),
    };
