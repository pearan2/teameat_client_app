import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/store/store.dart';

part 'item.freezed.dart';

part 'item.g.dart';

@freezed
class ItemSimple with _$ItemSimple {
  const factory ItemSimple({
    required int id,
    required String name,
    required String imageUrl,
    required int originalPrice,
    required int price,
    required int quantity,
    required String sellType,
    required DateTime salesWillBeEndedAt,
    required int orderReference,
    DateTime? currentGroupBuyingWillBeEndedAt,
    String? curatorProfileImageUrl,
    required int storeId,
    required String storeName,
    required Point storeLocation,
  }) = _ItemSimple;

  factory ItemSimple.fromJson(Map<String, Object?> json) =>
      _$ItemSimpleFromJson(json);

  factory ItemSimple.empty() {
    return ItemSimple(
      id: -1,
      name: "마르게리따 피자 + 오레가노 치즈스테이크에 더해지는 풍미가 오늘은 ",
      imageUrl:
          "https://tgzzmmgvheix1905536.cdn.ntruss.com/2020/03/c320a089abe34b72942aeecc9b568295",
      originalPrice: 14900,
      price: 12800,
      quantity: 100,
      sellType: '이용권',
      orderReference: 0,
      salesWillBeEndedAt: DateTime.now(),
      currentGroupBuyingWillBeEndedAt: DateTime.now(),
      curatorProfileImageUrl:
          "https://tgzzmmgvheix1905536.cdn.ntruss.com/2020/03/c320a089abe34b72942aeecc9b568295",
      storeId: -1,
      storeName: "팀잇",
      storeLocation: Point.empty(),
    );
  }
}

@freezed
class ItemDetail with _$ItemDetail {
  const factory ItemDetail({
    required int id,
    required String name,
    required String imageUrl,
    required int originalPrice,
    required int price,
    required int quantity,
    required String sellType,
    required DateTime salesWillBeEndedAt,
    DateTime? currentGroupBuyingWillBeEndedAt,
    required StoreDetail store,
    required String introduce,
    required int numberOfLikes,
    DateTime? willBeExpiredAt,
    int? willBeExpiredAfterDay,
    int? weight,
    required String originInformation,
    required List<String> imageUrls,
    CurationMain? curation,
  }) = _ItemDetail;

  factory ItemDetail.fromJson(Map<String, Object?> json) =>
      _$ItemDetailFromJson(json);

  factory ItemDetail.empty() {
    return ItemDetail(
      id: -1,
      name: "마르게리따 피자 + 오레가노 치즈스테이크에 더해지는 풍미가 오늘은 ",
      imageUrl:
          "https://tgzzmmgvheix1905536.cdn.ntruss.com/2020/03/c320a089abe34b72942aeecc9b568295",
      originalPrice: 14900,
      price: 12800,
      quantity: 100,
      sellType: '이용권',
      salesWillBeEndedAt: DateTime.now(),
      currentGroupBuyingWillBeEndedAt: DateTime.now(),
      store: StoreDetail.empty(),
      introduce:
          "이것은 아주 맛있고 토마토소스를 직접 매장에서 끓여 만든화덕 피자로 어쩌고 저쩌고 매우 맛있으니 꼭 드셔보세요 아주 훌륭한 피자랍니다 ",
      numberOfLikes: 824,
      willBeExpiredAt: DateTime.now(),
      originInformation: "원 산지 산지 산지 산지 산지 산지 직송",
      imageUrls: List.generate(
          5,
          (_) =>
              "https://tgzzmmgvheix1905536.cdn.ntruss.com/2020/03/c320a089abe34b72942aeecc9b568295"),
    );
  }
}
