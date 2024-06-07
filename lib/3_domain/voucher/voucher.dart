import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

part 'voucher.freezed.dart';

part 'voucher.g.dart';

bool isExpired(DateTime willBeExpiredAt, int quantity) {
  if (isAllUsed(quantity)) return false;
  return willBeExpiredAt.isBefore(DateTime.now());
}

bool isAllUsed(int quantity) {
  return quantity < 1;
}

bool isUsable(DateTime willBeExpiredAt, int quantity) {
  return !isAllUsed(quantity) && !isExpired(willBeExpiredAt, quantity);
}

@freezed
class SearchVoucherSimpleList with _$SearchVoucherSimpleList {
  const factory SearchVoucherSimpleList({
    required Code status,
    required Code orderBy,
    required int pageNumber,
  }) = _SearchVoucherSimpleList;

  factory SearchVoucherSimpleList.empty() {
    return SearchVoucherSimpleList(
        status: Code.empty(), orderBy: Code.orderEmpty(), pageNumber: 0);
  }
  factory SearchVoucherSimpleList.fromJson(Map<String, Object?> json) =>
      _$SearchVoucherSimpleListFromJson(json);

  static Map<String, dynamic> toStringJson(SearchVoucherSimpleList target) {
    final ret = <String, dynamic>{};
    ret['status'] = target.status.code;
    ret['orderBy'] = target.orderBy.code;
    ret['pageNumber'] = target.pageNumber.toString();
    return ret;
  }
}

@freezed
class VoucherSimple with _$VoucherSimple {
  const factory VoucherSimple({
    required int id,
    required DateTime willBeExpiredAt,
    required String imageUrl,
    required Point storeLocation,
    required String storeName,
    required String itemName,
    required int quantity,
  }) = _VoucherSimple;

  factory VoucherSimple.fromJson(Map<String, Object?> json) =>
      _$VoucherSimpleFromJson(json);
}

@freezed
class VoucherUseLog with _$VoucherUseLog {
  const factory VoucherUseLog({
    required String reason,
    required int quantity,
    required DateTime usedAt,
  }) = _VoucherUseLog;

  factory VoucherUseLog.fromJson(Map<String, Object?> json) =>
      _$VoucherUseLogFromJson(json);

  factory VoucherUseLog.empty() {
    return VoucherUseLog(reason: '', quantity: 0, usedAt: DateTime.now());
  }
}

@freezed
class VoucherDetail with _$VoucherDetail {
  const factory VoucherDetail({
    required int id,
    required int quantity,
    required DateTime willBeExpiredAt,
    required int storeId,
    required String storeProfileImageUrl,
    required String storeName,
    required String storeOneLineIntroduce,
    required String storeAddress,
    required String storeOperationTime,
    required Point storeLocation,
    required String itemName,
    required List<String> itemImageUrls,
    required List<VoucherUseLog> useLogs,
  }) = _VoucherDetail;

  factory VoucherDetail.fromJson(Map<String, Object?> json) =>
      _$VoucherDetailFromJson(json);

  factory VoucherDetail.empty() {
    final store = StoreDetail.empty();
    final item = ItemDetail.empty();
    return VoucherDetail(
      id: -1,
      quantity: 0,
      willBeExpiredAt: DateTime.now(),
      storeId: -1,
      storeProfileImageUrl: store.profileImageUrl,
      storeName: store.name,
      storeOneLineIntroduce: store.oneLineIntroduce,
      storeLocation: Point.empty(),
      storeAddress: store.address,
      storeOperationTime: store.operationTime,
      itemName: item.name,
      itemImageUrls: item.imageUrls,
      useLogs: List.generate(5, (_) => VoucherUseLog.empty()),
    );
  }
}

@freezed
class UseVoucher with _$UseVoucher {
  const factory UseVoucher({
    required String storeVoucherPassword,
    required int quantity,
  }) = _UseVoucher;

  factory UseVoucher.fromJson(Map<String, Object?> json) =>
      _$UseVoucherFromJson(json);
}


// @freezed
// class VoucherDetail with _$VoucherDetail {
//   const factory VoucherDetail({
//     required int id,
//     required DateTime willBeExpiredAt,
//     required String imageUrl,
//     required Point storeLocation,
//     required String storeName,
//     required String itemName,
//     required int quantity,
//   }) = _VoucherDetail;

//   factory VoucherDetail.fromJson(Map<String, Object?> json) =>
//       _$VoucherSimpleFromJson(json);
// }
