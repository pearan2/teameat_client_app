import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/local.dart';
import 'package:teameat/3_domain/store/item/item.dart';

part 'curation.freezed.dart';

part 'curation.g.dart';

extension CurationExtension on CurationSimple {
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
class SearchCurationSimpleList with _$SearchCurationSimpleList {
  const factory SearchCurationSimpleList({
    required Code status,
    required int pageSize,
    required int pageNumber,
  }) = _SearchCurationSimpleList;

  factory SearchCurationSimpleList.empty() {
    return SearchCurationSimpleList(
      status: Code.empty(),
      pageSize: 5,
      pageNumber: 0,
    );
  }
  factory SearchCurationSimpleList.fromJson(Map<String, Object?> json) =>
      _$SearchCurationSimpleListFromJson(json);

  static Map<String, dynamic> toStringJson(SearchCurationSimpleList target) {
    final ret = <String, dynamic>{};
    ret['status'] = target.status.code;
    ret['pageSize'] = target.pageSize.toString();
    ret['pageNumber'] = target.pageNumber.toString();
    return ret;
  }
}

@freezed
class CurationSimple with _$CurationSimple {
  const factory CurationSimple({
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
  }) = _CurationSimple;

  factory CurationSimple.fromJson(Map<String, Object?> json) =>
      _$CurationSimpleFromJson(json);

  factory CurationSimple.fromDetail(CurationDetail detail) => CurationSimple(
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
class CurationDetail with _$CurationDetail {
  const factory CurationDetail({
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
    ItemSimple? item,
    bool? isSellFinished,
    bool? isInSell,
    int? itemSellTotalAmount,
  }) = _CurationDetail;

  factory CurationDetail.fromJson(Map<String, Object?> json) =>
      _$CurationDetailFromJson(json);

  factory CurationDetail.empty() {
    return CurationDetail(
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
    );
  }
}

@freezed
class CurationMain with _$CurationMain {
  const factory CurationMain({
    required int curatorId,
    required String curatorProfileImageUrl,
    required String curatorNickname,
    String? curatorOneLineIntroduce,
    required List<dynamic> storeImageUrls,
    required String oneLineIntroduce,
    required String introduce,
  }) = _CurationMain;

  factory CurationMain.fromJson(Map<String, Object?> json) =>
      _$CurationMainFromJson(json);
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
