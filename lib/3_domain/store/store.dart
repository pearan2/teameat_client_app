import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/store/item/item.dart';

part 'store.freezed.dart';

part 'store.g.dart';

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

  factory StoreDetail.fromJson(Map<String, Object?> json) =>
      _$StoreDetailFromJson(json);

  factory StoreDetail.empty() {
    return StoreDetail(
      id: -1,
      name: "벨로",
      profileImageUrl:
          "https://tgzzmmgvheix1905536.cdn.ntruss.com/2020/03/c320a089abe34b72942aeecc9b568295",
      address: "대구 북구 대흥동 13길 24",
      location: Point.empty(),
      items: List.generate(5, (_) => ItemSimple.empty()),
      phone: "010-0000-1257",
      oneLineIntroduce: "맛있는 양식집 이올시다",
      introduce:
          "벨로는 오래된 양식집의 향기가 내 안에 바람을 타고와서 우리집 밑에 있는 재료보다는 갈래 말래 우리가 지금 함께 하는 이길에서 지금 여기 특이한 만두를 가지고 가는 느낌의 오늘 하루 하하 호호 하는 기분 ",
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
