import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/store/item/item.dart';

part 'store.freezed.dart';

part 'store.g.dart';

extension PointExtension on Point {
  double distanceKilo(Point target) {
    const p = 0.017453292519943295;
    const c = cos;
    const radiusOfEarth = 6371;

    final a = 0.5 -
        c((target.latitude - latitude) * p) / 2 +
        c(latitude * p) *
            c(target.latitude * p) *
            (1 - c((target.longitude - longitude) * p)) /
            2;
    return radiusOfEarth * 2 * asin(sqrt(a));
  }
}

@freezed
class Point with _$Point {
  const factory Point({required double latitude, required double longitude}) =
      _Point;

  factory Point.fromJson(Map<String, Object?> json) => _$PointFromJson(json);

  factory Point.empty() {
    return const Point(latitude: 37.57888, longitude: 126.9949);
  }
}

@freezed
class StorePoint with _$StorePoint {
  const factory StorePoint({
    required int id,
    required String profileImageUrl,
    required Point location,
  }) = _StorePoint;

  factory StorePoint.fromJson(Map<String, Object?> json) =>
      _$StorePointFromJson(json);

  factory StorePoint.empty() {
    return StorePoint.fromDetail(StoreDetail.empty());
  }

  factory StorePoint.fromSimple(StoreSimple store) {
    return StorePoint(
      id: store.id,
      profileImageUrl: store.profileImageUrl,
      location: store.location,
    );
  }

  factory StorePoint.fromDetail(StoreDetail store) {
    return StorePoint(
      id: store.id,
      profileImageUrl: store.profileImageUrl,
      location: store.location,
    );
  }
}

@freezed
class SearchStoreSimpleList with _$SearchStoreSimpleList {
  const factory SearchStoreSimpleList({
    String? address,
    String? searchText,
    List<String>? hashTags,
    List<String>? categories,
    Point? baseLocation,
    int? withInMeter,
    required int pageNumber,
    required int pageSize,
  }) = _SearchStoreSimpleList;

  factory SearchStoreSimpleList.empty() {
    return const SearchStoreSimpleList(
      address: "",
      searchText: "",
      hashTags: [],
      categories: [],
      baseLocation: null,
      withInMeter: null,
      pageNumber: 0,
      pageSize: 5,
    );
  }
  factory SearchStoreSimpleList.fromJson(Map<String, Object?> json) =>
      _$SearchStoreSimpleListFromJson(json);

  static Map<String, dynamic> toStringJson(SearchStoreSimpleList target) {
    final ret = <String, dynamic>{};
    if (target.address != null) ret['address'] = target.address;
    if (target.searchText != null) ret['searchText'] = target.searchText;
    if (target.hashTags != null) ret['hashTags'] = target.hashTags;
    if (target.categories != null) ret['categories'] = target.categories;
    if (target.baseLocation != null) {
      ret['baseLocation.longitude'] = target.baseLocation!.longitude.toString();
      ret['baseLocation.latitude'] = target.baseLocation!.latitude.toString();
    }
    if (target.withInMeter != null) {
      ret['withInMeter'] = target.withInMeter.toString();
    }
    ret['pageNumber'] = target.pageNumber.toString();
    ret['pageSize'] = target.pageSize.toString();
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
  }) = _StoreSimple;

  factory StoreSimple.fromJson(Map<String, Object?> json) =>
      _$StoreSimpleFromJson(json);
}

@freezed
class StoreDetail with _$StoreDetail {
  const factory StoreDetail({
    required int id,
    required String name,
    required String profileImageUrl,
    required List<String> imageUrls,
    required String address,
    required Point location,
    required List<ItemSimple> items,
    required String phone,
    required String oneLineIntroduce,
    required String introduce,
    required String operationTime,
    required String breakTime,
    required String lastOrderTime,
  }) = _StoreDetail;

  factory StoreDetail.fromJsonWithItemSort(Map<String, Object?> json) {
    final ret = StoreDetail.fromJson(json);
    final sorted = [...ret.items];
    sorted.sort((lhs, rhs) => lhs.orderReference - rhs.orderReference);
    return ret.copyWith(items: sorted);
  }

  factory StoreDetail.fromJson(Map<String, Object?> json) =>
      _$StoreDetailFromJson(json);

  factory StoreDetail.empty() {
    return StoreDetail(
      id: -1,
      name: "벨로",
      profileImageUrl:
          "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png",
      address: "대구 북구 대흥동 13길 24",
      location: Point.empty(),
      items: List.generate(5, (_) => ItemSimple.empty()),
      phone: "010-0000-1257",
      oneLineIntroduce: "사장님께서 입력해주시는 가게 한줄 소개",
      introduce: "사장님께서 입력해주시는 가게 소개",
      operationTime:
          "월 09:00 ~ 21:00\n화 09:00 ~ 21:00\n수 09:00 ~ 21:00\n목 정기 휴무\n금 09:00 ~ 21:00\n토 09:00 ~ 22:00\n일 09:00 ~ 22:00",
      breakTime: "매일 11:00 ~ 12:00",
      lastOrderTime: "월 19:30\n화 19:30\n수 19:30\n금 19:30\n토 20:30\n일 20:30",
      imageUrls: List.generate(
          5,
          (_) =>
              "https://tgzzmmgvheix1905536.cdn.ntruss.com/2020/03/c320a089abe34b72942aeecc9b568295"),
    );
  }
}
