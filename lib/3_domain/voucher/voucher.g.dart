// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchVoucherSimpleListImpl _$$SearchVoucherSimpleListImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchVoucherSimpleListImpl(
      status: Code.fromJson(json['status'] as Map<String, dynamic>),
      orderBy: Code.fromJson(json['orderBy'] as Map<String, dynamic>),
      pageNumber: (json['pageNumber'] as num).toInt(),
    );

Map<String, dynamic> _$$SearchVoucherSimpleListImplToJson(
        _$SearchVoucherSimpleListImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'orderBy': instance.orderBy,
      'pageNumber': instance.pageNumber,
    };

_$VoucherSimpleImpl _$$VoucherSimpleImplFromJson(Map<String, dynamic> json) =>
    _$VoucherSimpleImpl(
      id: (json['id'] as num).toInt(),
      willBeExpiredAt: DateTime.parse(json['willBeExpiredAt'] as String),
      imageUrl: json['imageUrl'] as String,
      storeLocation:
          Point.fromJson(json['storeLocation'] as Map<String, dynamic>),
      storeName: json['storeName'] as String,
      itemName: json['itemName'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$VoucherSimpleImplToJson(_$VoucherSimpleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'willBeExpiredAt': instance.willBeExpiredAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'storeLocation': instance.storeLocation,
      'storeName': instance.storeName,
      'itemName': instance.itemName,
      'quantity': instance.quantity,
    };

_$VoucherUseLogImpl _$$VoucherUseLogImplFromJson(Map<String, dynamic> json) =>
    _$VoucherUseLogImpl(
      reason: json['reason'] as String,
      quantity: (json['quantity'] as num).toInt(),
      usedAt: DateTime.parse(json['usedAt'] as String),
    );

Map<String, dynamic> _$$VoucherUseLogImplToJson(_$VoucherUseLogImpl instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'quantity': instance.quantity,
      'usedAt': instance.usedAt.toIso8601String(),
    };

_$VoucherDetailImpl _$$VoucherDetailImplFromJson(Map<String, dynamic> json) =>
    _$VoucherDetailImpl(
      id: (json['id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      willBeExpiredAt: DateTime.parse(json['willBeExpiredAt'] as String),
      storeId: (json['storeId'] as num).toInt(),
      storeProfileImageUrl: json['storeProfileImageUrl'] as String,
      storeName: json['storeName'] as String,
      storeOneLineIntroduce: json['storeOneLineIntroduce'] as String,
      storeAddress: json['storeAddress'] as String,
      storeOperationTime: json['storeOperationTime'] as String,
      itemName: json['itemName'] as String,
      itemImageUrls: (json['itemImageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      useLogs: (json['useLogs'] as List<dynamic>)
          .map((e) => VoucherUseLog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VoucherDetailImplToJson(_$VoucherDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'willBeExpiredAt': instance.willBeExpiredAt.toIso8601String(),
      'storeId': instance.storeId,
      'storeProfileImageUrl': instance.storeProfileImageUrl,
      'storeName': instance.storeName,
      'storeOneLineIntroduce': instance.storeOneLineIntroduce,
      'storeAddress': instance.storeAddress,
      'storeOperationTime': instance.storeOperationTime,
      'itemName': instance.itemName,
      'itemImageUrls': instance.itemImageUrls,
      'useLogs': instance.useLogs,
    };
