import 'package:get/get.dart';
import 'package:teameat/1_presentation/store/item/store_item_page.dart';
import 'package:teameat/1_presentation/store/item/store_item_page_binding.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class React extends IReact {
  @override
  void toRoot() {
    Get.offAllNamed('/');
  }

  @override
  void toHomeOffAll() {
    Get.offAllNamed('/home');
  }

  @override
  void toStoreItemDetail(int itemId) {
    Get.to(
      () => StoreItemPage(itemId.toString()),
      arguments: {'itemId': itemId},
      preventDuplicates: false,
      binding: StoreItemPageBinding(),
      duration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void back<T>({T? result}) {
    return Get.back<T>(result: result);
  }

  @override
  Future<void> toLogin() async {
    return Get.toNamed('/login');
  }

  @override
  void toItemPurchase(Map<ItemDetail, int> items) {
    Get.toNamed('/store/item/purchase',
        arguments: {'items': items}, preventDuplicates: false);
  }

  @override
  void toPaymentOff(Order order, PaymentMethod paymentMethod) {
    Get.offNamed('/payment',
        arguments: {'order': order, 'paymentMethod': paymentMethod});
  }

  @override
  void toPaymentResultOff(Map<String, String> result) {
    Get.offNamed('/payment/result', arguments: {'result': result});
  }

  @override
  void toUserOffAll() {
    Get.offAllNamed('/user');
  }

  @override
  void toVoucherOffAll() {
    Get.offAllNamed('/voucher');
  }

  @override
  void toStoreDetail(int storeId) {
    Get.toNamed('/store', arguments: {'storeId': storeId});
  }

  @override
  void toCustomerService() {
    Get.toNamed('/customer-service');
  }

  @override
  Future<T?> toVoucherDetailPage<T>(int voucherId) async {
    return Get.toNamed('/voucher/detail', arguments: {'voucherId': voucherId});
  }

  @override
  void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  @override
  void closeDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void toVoucherUsedOffAll(
      {required VoucherDetail voucher, required int usedQuantity}) {
    Get.offAllNamed('/voucher/used',
        arguments: {'voucher': voucher, 'usedQuantity': usedQuantity});
  }

  @override
  void toItemLike() {
    Get.toNamed('/store/item/like');
  }

  @override
  void toStoreLike() {
    Get.toNamed('/store/like');
  }
}
