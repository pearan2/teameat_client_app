// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointImpl _$$PointImplFromJson(Map<String, dynamic> json) => _$PointImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$PointImplToJson(_$PointImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$SearchStoreSimpleListImpl _$$SearchStoreSimpleListImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchStoreSimpleListImpl(
      searchText: json['searchText'] as String?,
      hashTags: (json['hashTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      baseLocation: json['baseLocation'] == null
          ? null
          : Point.fromJson(json['baseLocation'] as Map<String, dynamic>),
      pageNumber: (json['pageNumber'] as num).toInt(),
    );

Map<String, dynamic> _$$SearchStoreSimpleListImplToJson(
        _$SearchStoreSimpleListImpl instance) =>
    <String, dynamic>{
      'searchText': instance.searchText,
      'hashTags': instance.hashTags,
      'categories': instance.categories,
      'baseLocation': instance.baseLocation,
      'pageNumber': instance.pageNumber,
    };

_$StoreSimpleImpl _$$StoreSimpleImplFromJson(Map<String, dynamic> json) =>
    _$StoreSimpleImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      address: json['address'] as String,
      location: Point.fromJson(json['location'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StoreSimpleImplToJson(_$StoreSimpleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'address': instance.address,
      'location': instance.location,
      'items': instance.items,
    };
