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
  void back<T>({T? result, bool closeOverlays = false}) {
    return Get.back<T>(result: result, closeOverlays: closeOverlays);
  }

  @override
  Future<void> toLogin() async {
    return Get.toNamed('/login');
  }

  @override
  Future<T?> toItemPurchase<T>(Map<ItemDetail, int> items,
      {required bool withOpenGroupBuying, int? groupBuyingId}) async {
    return Get.toNamed('/store/item/purchase',
        arguments: {
          'items': items,
          'groupBuyingId': groupBuyingId,
          'withOpenGroupBuying': withOpenGroupBuying
        },
        preventDuplicates: false);
  }

  @override
  void toPaymentOff(Order order, PaymentMethod paymentMethod, int? itemId) {
    Get.offNamed('/payment', arguments: {
      'order': order,
      'paymentMethod': paymentMethod,
      'itemId': itemId
    });
  }

  @override
  void toPaymentResultOff(Map<String, String> result, int? itemId) {
    Get.offNamed('/payment/result',
        arguments: {'result': result, 'itemId': itemId});
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

  @override
  void toUserDetail() {
    Get.toNamed('/user/detail');
  }

  @override
  void toCommunityOffAll() {
    Get.offAllNamed('/community');
  }

  @override
  void toCommunityCreate() {
    Get.toNamed('/community/create');
  }

  @override
  void toCommunityView(int curationId) {
    Get.toNamed('/community/view', arguments: {'curationId': curationId});
  }

  @override
  void to(dynamic page) {
    Get.to(
      page,
      duration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    );
  }
}
