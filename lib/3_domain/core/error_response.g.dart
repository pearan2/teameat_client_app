// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      status: (json['status'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'name': instance.name,
      'code': instance.code,
      'message': instance.message,
    };
