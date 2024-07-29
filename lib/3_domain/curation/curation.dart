import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/local.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

part 'curation.freezed.dart';

part 'curation.g.dart';

extension CurationExtension on MyCurationSimple {
  String getStatusText() {
    if (isSellFinished == null || isInSell == null) {
      return DS.text.applicationCompleted;
    }
    if (isSellFinished!) {
      return DS.text.saleFinished;
    }
    if (isInSell!) {
      return DS.text.inSale;
    }

    return DS.text.applicationCompleted;
  }

  Color getStatusColor() {
    if (isSellFinished == null || isInSell == null) {
      return DS.color.background500;
    }

    if (isSellFinished!) {
      return DS.color.secondary500;
    }

    if (isInSell!) {
      return DS.color.primary600;
    }

    return DS.color.background500;
  }
}

@freezed
class SearchMyCurationSimpleList with _$SearchMyCurationSimpleList {
  const factory SearchMyCurationSimpleList({
    required Code status,
    required int pageSize,
    required int pageNumber,
  }) = _SearchMyCurationSimpleList;

  factory SearchMyCurationSimpleList.empty() {
    return SearchMyCurationSimpleList(
      status: Code.empty(),
      pageSize: 10,
      pageNumber: 0,
    );
  }
  factory SearchMyCurationSimpleList.fromJson(Map<String, Object?> json) =>
      _$SearchMyCurationSimpleListFromJson(json);

  static Map<String, dynamic> toStringJson(SearchMyCurationSimpleList target) {
    final ret = <String, dynamic>{};
    ret['status'] = target.status.code;
    ret['pageSize'] = target.pageSize.toString();
    ret['pageNumber'] = target.pageNumber.toString();
    return ret;
  }
}

@freezed
class MyCurationSimple with _$MyCurationSimple {
  const factory MyCurationSimple({
    required final int id,
    required final String name,
    required final String imageUrl,
    required final int originalPrice,
    required final double rewardRatio,
    required final DateTime createdAt,
    required final String storeName,
    ItemSimple? item,
    bool? isSellFinished,
    bool? isInSell,
    int? itemSellTotalAmount,
  }) = _MyCurationSimple;

  factory MyCurationSimple.fromJson(Map<String, Object?> json) =>
      _$MyCurationSimpleFromJson(json);

  factory MyCurationSimple.fromDetail(MyCurationDetail detail) =>
      MyCurationSimple(
        id: detail.id,
        name: detail.name,
        imageUrl: detail.imageUrl,
        originalPrice: detail.originalPrice,
        rewardRatio: detail.rewardRatio,
        createdAt: detail.createdAt,
        storeName: detail.storeName,
        item: detail.item,
        isSellFinished: detail.isSellFinished,
        isInSell: detail.isInSell,
        itemSellTotalAmount: detail.itemSellTotalAmount,
      );
}

@freezed
class MyCurationDetail with _$MyCurationDetail {
  const factory MyCurationDetail({
    required final int id,
    required final String name,
    required final String imageUrl,
    required final String oneLineIntroduce,
    required final String introduce,
    required final List<String> itemImageUrls,
    required final List<String> storeImageUrls,
    required final int originalPrice,
    required final double rewardRatio,
    required final DateTime createdAt,
    required final String storeName,
    required final Local localInfo,
    ItemSimple? item,
    bool? isSellFinished,
    bool? isInSell,
    int? itemSellTotalAmount,
  }) = _MyCurationDetail;

  factory MyCurationDetail.fromJson(Map<String, Object?> json) =>
      _$MyCurationDetailFromJson(json);

  factory MyCurationDetail.empty() {
    return MyCurationDetail(
      id: -1,
      name: '',
      imageUrl: '',
      oneLineIntroduce: 'oneLineIntroduce',
      introduce: 'introduce',
      itemImageUrls: List.generate(
          5,
          (_) =>
              'https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png'),
      storeImageUrls: List.generate(
          5,
          (_) =>
              'https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png'),
      originalPrice: 15000,
      rewardRatio: 0.01,
      createdAt: DateTime.now(),
      storeName: '팀잇',
      localInfo: Local.empty(),
    );
  }
}

@freezed
class MyCurationMain with _$MyCurationMain {
  const factory MyCurationMain({
    required int curatorId,
    required String curatorProfileImageUrl,
    required String curatorNickname,
    String? curatorOneLineIntroduce,
    required List<dynamic> storeImageUrls,
    required String oneLineIntroduce,
    required String introduce,
  }) = _MyCurationMain;

  factory MyCurationMain.fromJson(Map<String, Object?> json) =>
      _$MyCurationMainFromJson(json);
}

@freezed
class CurationCreateRequest with _$CurationCreateRequest {
  const factory CurationCreateRequest({
    required final Local localInfo,
    required final String name,
    required final String oneLineIntroduce,
    required final String introduce,
    required final int originalPrice,
    required final List<String> itemImageUrls,
    required final List<String> storeImageUrls,
  }) = _CurationCreateRequest;

  factory CurationCreateRequest.fromJson(Map<String, Object?> json) =>
      _$CurationCreateRequestFromJson(json);

  factory CurationCreateRequest.empty() {
    return CurationCreateRequest(
      localInfo: Local.empty(),
      name: '',
      oneLineIntroduce: '',
      introduce: '',
      originalPrice: 0,
      itemImageUrls: [],
      storeImageUrls: [],
    );
  }
}

@freezed
class SearchCurationSimpleList with _$SearchCurationSimpleList {
  const factory SearchCurationSimpleList({
    String? address,
    String? searchText,
    Point? baseLocation,
    int? withInMeter,
    required Code order,
    required int pageSize,
    required int pageNumber,
  }) = _SearchCurationSimpleList;

  factory SearchCurationSimpleList.empty() {
    return SearchCurationSimpleList(
      order: Code.orderEmpty(),
      pageSize: 10,
      pageNumber: 0,
    );
  }
  factory SearchCurationSimpleList.fromJson(Map<String, Object?> json) =>
      _$SearchCurationSimpleListFromJson(json);

  static Map<String, dynamic> toStringJson(SearchCurationSimpleList target) {
    final ret = <String, dynamic>{};
    if (target.address != null) ret['address'] = target.address;
    if (target.searchText != null) ret['searchText'] = target.searchText;
    if (target.baseLocation != null) {
      ret['baseLocation.longitude'] = target.baseLocation!.longitude.toString();
      ret['baseLocation.latitude'] = target.baseLocation!.latitude.toString();
    }
    if (target.withInMeter != null) {
      ret['withInMeter'] = target.withInMeter.toString();
    }
    ret['order'] = target.order.code;
    ret['pageNumber'] = target.pageNumber.toString();
    ret['pageSize'] = target.pageSize.toString();
    return ret;
  }
}

@freezed
class CurationListStoreInfo with _$CurationListStoreInfo {
  const factory CurationListStoreInfo({
    required int id,
    required String name,
    required String address,
    required Point location,
  }) = _CurationListStoreInfo;

  factory CurationListStoreInfo.fromJson(Map<String, Object?> json) =>
      _$CurationListStoreInfoFromJson(json);

  factory CurationListStoreInfo.empty() {
    return CurationListStoreInfo(
      id: -1,
      name: "",
      address: "",
      location: Point.empty(),
    );
  }
}

@freezed
class CurationListCuratorInfo with _$CurationListCuratorInfo {
  const factory CurationListCuratorInfo({
    required int id,
    required String nickname,
    String? oneLineIntroduce,
    required String profileImageUrl,
  }) = _CurationListCuratorInfo;

  factory CurationListCuratorInfo.fromJson(Map<String, Object?> json) =>
      _$CurationListCuratorInfoFromJson(json);

  factory CurationListCuratorInfo.empty() {
    return const CurationListCuratorInfo(
      id: -1,
      nickname: "",
      profileImageUrl:
          "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png",
    );
  }
}

extension CurationListExtension on CurationListSimple {
  String? getStatusText() {
    if (isSaleFinished) {
      return DS.text.saleFinished;
    }
    if (isInSale) {
      return DS.text.inSale;
    }
    return null;
  }
}

@freezed
class CurationListStoreAdditionalInfo with _$CurationListStoreAdditionalInfo {
  const factory CurationListStoreAdditionalInfo({
    required String category,
    required int numberOfCurations,
    required bool isEntered,
    required String profileImageUrl,
    String? naverMapPlaceId,
  }) = _CurationListStoreAdditionalInfo;

  factory CurationListStoreAdditionalInfo.fromJson(Map<String, Object?> json) =>
      _$CurationListStoreAdditionalInfoFromJson(json);

  factory CurationListStoreAdditionalInfo.empty() {
    return const CurationListStoreAdditionalInfo(
        category: "",
        numberOfCurations: 0,
        isEntered: false,
        profileImageUrl:
            "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png");
  }
}

@freezed
class CurationListStoreItemInfo with _$CurationListStoreItemInfo {
  const factory CurationListStoreItemInfo({
    required int id,
    required int price,
    required int originalPrice,
  }) = _CurationListStoreItemInfo;

  factory CurationListStoreItemInfo.fromJson(Map<String, Object?> json) =>
      _$CurationListStoreItemInfoFromJson(json);

  factory CurationListStoreItemInfo.empty() {
    return const CurationListStoreItemInfo(
      id: -1,
      price: 1000,
      originalPrice: 2000,
    );
  }
}

@freezed
class CurationListSimple with _$CurationListSimple {
  const factory CurationListSimple({
    required int id,
    required String name,
    required String oneLineIntroduce,
    required String introducePreview,
    required CurationListStoreInfo store,
    required CurationListCuratorInfo curator,
    required String imageUrl,
    required int numberOfLikes,
    required bool isInSale,
    required bool isSaleFinished,
    required DateTime createdAt,
  }) = _CurationListSimple;

  factory CurationListSimple.fromJson(Map<String, Object?> json) =>
      _$CurationListSimpleFromJson(json);

  factory CurationListSimple.fromDetail(CurationListDetail detail) =>
      CurationListSimple(
        id: detail.id,
        name: detail.name,
        oneLineIntroduce: detail.oneLineIntroduce,
        introducePreview: detail.introducePreview,
        store: detail.store,
        curator: detail.curator,
        imageUrl: detail.imageUrl,
        numberOfLikes: detail.numberOfLikes,
        isInSale: detail.isInSale,
        isSaleFinished: detail.isSaleFinished,
        createdAt: detail.createdAt,
      );
}

@freezed
class CurationListDetail with _$CurationListDetail {
  const factory CurationListDetail({
    required int id,
    required String name,
    required String oneLineIntroduce,
    required String introducePreview,
    required CurationListStoreInfo store,
    CurationListStoreItemInfo? item,
    required CurationListStoreAdditionalInfo storeAdditional,
    required CurationListCuratorInfo curator,
    required String imageUrl,
    required int numberOfLikes,
    required bool isInSale,
    required bool isSaleFinished,
    required DateTime createdAt,
    required String introduce,
    required List<String> itemImageUrls,
    required List<String> storeImageUrls,
  }) = _CurationListDetail;

  factory CurationListDetail.fromJson(Map<String, Object?> json) =>
      _$CurationListDetailFromJson(json);

  factory CurationListDetail.empty() {
    return CurationListDetail(
      id: -1,
      name: "",
      store: CurationListStoreInfo.empty(),
      storeAdditional: CurationListStoreAdditionalInfo.empty(),
      curator: CurationListCuratorInfo.empty(),
      imageUrl:
          "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png",
      numberOfLikes: 0,
      isInSale: false,
      isSaleFinished: false,
      createdAt: DateTime.now(),
      oneLineIntroduce: "",
      introducePreview: "",
      introduce: "",
      itemImageUrls: [
        "https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/default_profile_image.png"
      ],
      storeImageUrls: [],
    );
  }
}
