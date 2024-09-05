import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/user/block/block.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

abstract class IRouter {
  void toRoot();

  void toHomeOffAll();

  void toStoreItemDetail(int itemId);

  void back<T>({T? result, bool closeOverlays});

  Future<void> toLogin();

  Future<T?> toItemPurchase<T>(Map<ItemDetail, int> items,
      {required bool withOpenGroupBuying, int? groupBuyingId});

  void toPaymentOff(Order order, PaymentMethod paymentMethod, int? itemId);

  void toPaymentResultOffAll(Map<String, String> result, int? itemId);

  void toVoucherOffAll();

  void toUserOffAll();

  void toStoreDetail(int storeId);

  void toCustomerService();

  Future<T?> toVoucherDetailPage<T>(int voucherId);

  void closeBottomSheet();

  void closeDialog();

  void toVoucherUsedOffAll(
      {required VoucherDetail voucher, required int usedQuantity});

  void toItemLike();

  void toStoreLike();

  void toUserDetail();

  void toUserFollower();

  void toCurationOffAll();

  void toUserCuration();

  void toCurationRewardGuide();

  void toBlockPage(BlockTargetType targetType);

  Future<bool> toCurationCreate(MyCurationDetail? curation);

  void toCurationDetail(int curationId);

  void toCuratorSummary(int curatorId);

  void toUserCurationDetail(int curationId);

  void toPermissionSetting();

  void toGiftCreate(
      {required VoucherDetail voucher, required int giftQuantity});

  void toGiftSuccess({required String giftId});

  void toGiftReceive({required String giftId});

  void toGift();
}
