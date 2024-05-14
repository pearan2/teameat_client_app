// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CodeInnerImpl _$$CodeInnerImplFromJson(Map<String, dynamic> json) =>
    _$CodeInnerImpl(
      code: json['code'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$CodeInnerImplToJson(_$CodeInnerImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
    };

_$CodeImpl _$$CodeImplFromJson(Map<String, dynamic> json) => _$CodeImpl(
      code: json['code'] as String,
      title: json['title'] as String,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CodeInner.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CodeImplToJson(_$CodeImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
      'children': instance.children,
    };
