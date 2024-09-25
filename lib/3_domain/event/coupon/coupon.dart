import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';

part 'coupon.g.dart';

@freezed
class CouponEvent with _$CouponEvent {
  const factory CouponEvent({
    required int id,
    required String title,
    required String description,
    double? discountRatio,
    int? discountAmount,
    required DateTime expiredAt,
    int? storeId,
    String? storeName,
  }) = _CouponEvent;

  factory CouponEvent.empty() {
    return CouponEvent(
      id: -1,
      title: '',
      description: '',
      discountAmount: 0,
      expiredAt: DateTime.now(),
    );
  }

  factory CouponEvent.fromJson(Map<String, Object?> json) =>
      _$CouponEventFromJson(json);
}

@freezed
class Coupon with _$Coupon {
  const factory Coupon({
    required int id,
    DateTime? usedAt,
    required CouponEvent event,
  }) = _Coupon;

  factory Coupon.empty() {
    return Coupon(
      id: -1,
      event: CouponEvent.empty(),
    );
  }

  factory Coupon.fromJson(Map<String, Object?> json) => _$CouponFromJson(json);
}

@freezed
class SearchMyCoupons with _$SearchMyCoupons {
  const factory SearchMyCoupons({
    bool? isUsable,
    List<int>? storeIds,
    required int pageSize,
    required int pageNumber,
  }) = _SearchMyCoupons;

  factory SearchMyCoupons.empty() {
    return const SearchMyCoupons(
      storeIds: [],
      isUsable: true,
      pageSize: 20,
      pageNumber: 0,
    );
  }
  factory SearchMyCoupons.fromJson(Map<String, Object?> json) =>
      _$SearchMyCouponsFromJson(json);

  static Map<String, dynamic> toStringJson(SearchMyCoupons target) {
    final ret = <String, dynamic>{};

    ret['pageSize'] = target.pageSize.toString();
    ret['pageNumber'] = target.pageNumber.toString();
    if (target.storeIds != null) {
      ret['storeIds'] = target.storeIds!.map((id) => id.toString()).toList();
    }
    if (target.isUsable != null) {
      ret['isUsable'] = target.isUsable!.toString();
    }

    return ret;
  }
}

@freezed
class CouponApplyResult with _$CouponApplyResult {
  const factory CouponApplyResult({
    required int amount,
  }) = _CouponApplyResult;

  factory CouponApplyResult.empty() {
    return const CouponApplyResult(amount: 1000);
  }

  factory CouponApplyResult.fromJson(Map<String, Object?> json) =>
      _$CouponApplyResultFromJson(json);
}
