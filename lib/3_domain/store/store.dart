import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/store/item/item.dart';

part 'store.freezed.dart';

part 'store.g.dart';

@freezed
class Point with _$Point {
  const factory Point({required double latitude, required double longitude}) =
      _Point;

  factory Point.fromJson(Map<String, Object?> json) => _$PointFromJson(json);
}

@freezed
class SearchStoreSimpleList with _$SearchStoreSimpleList {
  const factory SearchStoreSimpleList({
    String? searchText,
    List<String>? hashTags,
    List<String>? categories,
    Point? baseLocation,
    required int pageNumber,
  }) = _SearchStoreSimpleList;

  factory SearchStoreSimpleList.empty() {
    return const SearchStoreSimpleList(
        searchText: "",
        hashTags: [],
        categories: [],
        baseLocation: null,
        pageNumber: 0);
  }
  factory SearchStoreSimpleList.fromJson(Map<String, Object?> json) =>
      _$SearchStoreSimpleListFromJson(json);

  static Map<String, dynamic> toStringJson(SearchStoreSimpleList target) {
    final ret = <String, dynamic>{};
    if (target.searchText != null) ret['searchText'] = target.searchText;
    if (target.hashTags != null) ret['hashTags'] = target.hashTags;
    if (target.categories != null) ret['categories'] = target.categories;
    if (target.baseLocation != null) {
      ret['baseLocation'] = {
        'longitude': target.baseLocation!.longitude.toString(),
        'latitude': target.baseLocation!.latitude.toString()
      };
    }
    ret['pageNumber'] = target.pageNumber.toString();
    return ret;
  }
}

@freezed
class StoreSimple with _$StoreSimple {
  const factory StoreSimple({
    required int id,
    required String name,
    required String profileImageUrl,
    required String address,
    required Point location,
    required List<ItemSimple> items,
  }) = _StoreSimple;

  factory StoreSimple.fromJson(Map<String, Object?> json) =>
      _$StoreSimpleFromJson(json);
}
