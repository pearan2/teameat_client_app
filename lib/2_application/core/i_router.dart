import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

abstract class IRouter {
  void toRoot();

  void toHomeOffAll();

  void toStoreItemDetail(int itemId);

  void back<T>({T? result});

  Future<void> toLogin();

  void toItemPurchase(Map<ItemDetail, int> items);

  void toPaymentOff(Order order, PaymentMethod paymentMethod);

  void toPaymentResultOff(Map<String, String> result);

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
}
