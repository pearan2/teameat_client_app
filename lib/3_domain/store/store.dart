import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/date_time.dart';

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
    String? naverMapPlaceId,
    required Point location,
    required String name,
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
      naverMapPlaceId: store.naverMapPlaceId,
      location: store.location,
      name: store.name,
    );
  }

  factory StorePoint.fromDetail(StoreDetail store) {
    return StorePoint(
      id: store.id,
      profileImageUrl: store.profileImageUrl,
      naverMapPlaceId: store.naverMapPlaceId,
      location: store.location,
      name: store.name,
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
    int? randomSeed,
  }) = _SearchStoreSimpleList;

  factory SearchStoreSimpleList.empty() {
    return SearchStoreSimpleList(
      address: "",
      searchText: "",
      hashTags: const [],
      categories: const [],
      baseLocation: null,
      withInMeter: null,
      pageNumber: 0,
      pageSize: 10,
      randomSeed: Random().nextInt(10000),
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
    if (target.randomSeed != null) {
      ret['randomSeed'] = target.randomSeed.toString();
    }

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
    String? naverMapPlaceId,
  }) = _StoreSimple;

  factory StoreSimple.fromJson(Map<String, Object?> json) =>
      _$StoreSimpleFromJson(json);
}

@freezed
class StoreDetailItemSimple with _$StoreDetailItemSimple {
  const factory StoreDetailItemSimple({
    required int id,
    required String imageUrl,
    required String name,
    required String introducePreview,
    required int orderReference,
    required int price,
    required int originalPrice,
  }) = _StoreDetailItemSimple;

  factory StoreDetailItemSimple.fromJson(Map<String, Object?> json) =>
      _$StoreDetailItemSimpleFromJson(json);

  factory StoreDetailItemSimple.empty() => const StoreDetailItemSimple(
        id: -1,
        imageUrl:
            "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png",
        name: "",
        introducePreview: "",
        orderReference: -1,
        price: 1000,
        originalPrice: 1200,
      );
}

class StoreTimeWrapper {
  final String dayOfWeek;
  final String operationTime;
  final String breakTime;
  final String lastOrderTime;

  StoreTimeWrapper({
    required this.dayOfWeek,
    required this.operationTime,
    required this.breakTime,
    required this.lastOrderTime,
  });
}

extension StoreDetailExtension on StoreDetail {
  String get cleanCategory {
    if (category.contains(">")) {
      return category.split(">").last;
    }
    return category;
  }

  bool _canParse(String target) {
    final splittedByLineBreak = target.split('\n');
    if (splittedByLineBreak.length != 7) {
      return false;
    }
    for (final line in splittedByLineBreak) {
      if (!line.contains("|")) {
        return false;
      }
    }
    return true;
  }

  List<StoreTimeWrapper> get timeInfo {
    if (!_canParse(operationTime) ||
        !_canParse(breakTime) ||
        !_canParse(lastOrderTime)) {
      return [
        StoreTimeWrapper(
            dayOfWeek: '',
            operationTime: 'No data',
            breakTime: '',
            lastOrderTime: '')
      ];
    }
    final ret = <StoreTimeWrapper>[];

    final opers = operationTime.split("\n");
    final breaks = breakTime.split("\n");
    final lasts = lastOrderTime.split("\n");
    for (int i = 0; i < opers.length; i++) {
      final splitted = opers[i].split("|");
      final dayOfWeek = splitted[0];
      ret.add(StoreTimeWrapper(
        dayOfWeek: dayOfWeek,
        operationTime: opers[i].split("|")[1],
        breakTime: breaks[i].split("|")[1],
        lastOrderTime: lasts[i].split("|")[1],
      ));
    }
    while (ret.first.dayOfWeek != DateTime.now().dayOfWeekKor()) {
      ret.add(ret.removeAt(0));
    }
    return ret;
  }
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
    String? naverMapPlaceId,
    required List<ItemSimple> items,
    required List<StoreDetailItemSimple> simpleItems,
    required String phone,
    required String oneLineIntroduce,
    required String introduce,
    required int numberOfCurations,
    required String category,
    required String operationTime,
    required String breakTime,
    required String lastOrderTime,
  }) = _StoreDetail;

  factory StoreDetail.fromJsonWithItemSort(Map<String, Object?> json) {
    final ret = StoreDetail.fromJson(json);

    final sortedItems = [...ret.items];
    sortedItems.sort((lhs, rhs) => lhs.orderReference - rhs.orderReference);

    final sortedSimpleItems = [...ret.simpleItems];
    sortedSimpleItems
        .sort((lhs, rhs) => lhs.orderReference - rhs.orderReference);

    return ret.copyWith(items: sortedItems, simpleItems: sortedSimpleItems);
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
      simpleItems: List.generate(5, (_) => StoreDetailItemSimple.empty()),
      phone: "010-0000-1257",
      oneLineIntroduce: "사장님께서 입력해주시는 가게 한줄 소개",
      introduce: "사장님께서 입력해주시는 가게 소개",
      numberOfCurations: 0,
      category: "",
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
