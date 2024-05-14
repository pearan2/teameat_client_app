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
      salesWillBeEndedAt: DateTime.parse(json['salesWillBeEndedAt'] as String),
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
      'salesWillBeEndedAt': instance.salesWillBeEndedAt.toIso8601String(),
      'currentGroupBuyingWillBeEndedAt':
          instance.currentGroupBuyingWillBeEndedAt?.toIso8601String(),
    };

_$ItemDetailImpl _$$ItemDetailImplFromJson(Map<String, dynamic> json) =>
    _$ItemDetailImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      originalPrice: (json['originalPrice'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      sellType: json['sellType'] as String,
      salesWillBeEndedAt: DateTime.parse(json['salesWillBeEndedAt'] as String),
      currentGroupBuyingWillBeEndedAt:
          json['currentGroupBuyingWillBeEndedAt'] == null
              ? null
              : DateTime.parse(
                  json['currentGroupBuyingWillBeEndedAt'] as String),
      store: StoreDetail.fromJson(json['store'] as Map<String, dynamic>),
      introduce: json['introduce'] as String,
      numberOfLikes: (json['numberOfLikes'] as num).toInt(),
      willBeExpiredAt: DateTime.parse(json['willBeExpiredAt'] as String),
      originInformation: json['originInformation'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ItemDetailImplToJson(_$ItemDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'originalPrice': instance.originalPrice,
      'price': instance.price,
      'sellType': instance.sellType,
      'salesWillBeEndedAt': instance.salesWillBeEndedAt.toIso8601String(),
      'currentGroupBuyingWillBeEndedAt':
          instance.currentGroupBuyingWillBeEndedAt?.toIso8601String(),
      'store': instance.store,
      'introduce': instance.introduce,
      'numberOfLikes': instance.numberOfLikes,
      'willBeExpiredAt': instance.willBeExpiredAt.toIso8601String(),
      'originInformation': instance.originInformation,
      'imageUrls': instance.imageUrls,
    };
