import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/onboarding_page.dart';
import 'package:teameat/2_application/community/curation_page_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';
import 'package:teameat/2_application/voucher/voucher_page_controller.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_temp_save_service.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/user/block/block.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class React extends IReact {
  @override
  void toRoot() {
    Get.offAllNamed('/');
  }

  @override
  void toHomeOffAll() {
    if (Get.isRegistered<HomePageController>()) {
      final controller = Get.find<HomePageController>();
      controller.refreshPage();
    }
    Get.offAllNamed('/home');
  }

  @override
  void toGroupBuyingSearchPage({SearchableAddress? selectedAddress}) {
    Get.toNamed('/search/group-buying',
        arguments: {'selectedAddress': selectedAddress});
  }

  @override
  void toStoreItemDetail(int itemId, {ItemSimple? item}) {
    Get.toNamed(
      '/store/item/detail/$itemId',
      arguments: {'itemId': itemId, 'item': item},
      preventDuplicates: false,
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
  void toPaymentOff(Order order, PaymentMethod paymentMethod, int? itemId,
      {bool isForGift = false}) {
    Get.offNamed('/payment', arguments: {
      'order': order,
      'paymentMethod': paymentMethod,
      'itemId': itemId,
      'isForGift': isForGift,
    });
  }

  @override
  void toPaymentResultOffAll(Map<String, String> result, int? itemId,
      {bool isForGift = false}) {
    Get.offAllNamed('/payment/result', arguments: {
      'result': result,
      'itemId': itemId,
      'isForGift': isForGift,
    });
  }

  @override
  void toUserOffAll() {
    Get.offAllNamed('/user');
  }

  @override
  void toVoucherOffAll() {
    if (Get.isRegistered<VoucherPageController>()) {
      final controller = Get.find<VoucherPageController>();
      controller.refreshPage();
    }
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
    return Get.toNamed('/voucher/detail/$voucherId');
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
  void toUserFollower() {
    Get.toNamed('/user/follower');
  }

  @override
  void toCurationOffAll() {
    if (Get.isRegistered<CurationPageController>()) {
      final controller = Get.find<CurationPageController>();
      controller.refreshPage();
    }
    Get.offAllNamed('/curation');
  }

  @override
  Future<bool> toCurationCreate(MyCurationDetail? curation) async {
    late final bool startWithTempSave;
    if (curation == null &&
        Get.find<ICurationTempSaveService>().isTempSaveExists()) {
      startWithTempSave = await showTEConfirmDialog(
        content: DS.text.youHaveTempSavedCurationCreateTryLoad,
        leftButtonText: DS.text.createCurationFromScratch,
        rightButtonText: DS.text.createCurationFromTempSave,
        dismissible: false,
      );
    } else {
      startWithTempSave = false;
    }
    final ret = await Get.toNamed('/curation/create', arguments: {
      'curation': curation,
      'startWithTempSave': startWithTempSave,
    });
    return _parseToBool(ret);
  }

  @override
  void toCurationDetail(int curationId, {CurationListSimple? simple}) {
    Get.toNamed(
      '/curation/detail/$curationId',
      arguments: {'curationId': curationId, 'curation': simple},
      preventDuplicates: false,
    );
  }

  @override
  void toCuratorSummary(int curatorId) {
    Get.toNamed(
      '/curation/curator/$curatorId/summary',
      arguments: {'curatorId': curatorId},
      preventDuplicates: false,
    );
  }

  @override
  void toPermissionSetting() {
    Get.toNamed('/permission-setting');
  }

  @override
  void toGiftCreate({
    required VoucherDetail voucher,
    required int giftQuantity,
  }) {
    Get.toNamed('/voucher/gift',
        arguments: {'voucher': voucher, 'giftQuantity': giftQuantity});
  }

  @override
  void toGiftSuccess({required String giftId}) {
    Get.toNamed('/voucher/gift/success', arguments: {'giftId': giftId});
  }

  @override
  void toGiftReceive({required String giftId}) {
    Get.toNamed('/voucher/gift/receive', arguments: {'giftId': giftId});
  }

  @override
  void toGift() {
    Get.toNamed('/gift');
  }

  @override
  void toUserCuration() {
    Get.toNamed('/user/curation');
  }

  @override
  void toUserCurationDetail(int curationId) {
    Get.toNamed('/user/curation/view', arguments: {'curationId': curationId});
  }

  bool _parseToBool(dynamic routeResult) {
    if (routeResult == null) {
      return false;
    } else {
      if (routeResult is bool && routeResult) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void toBlockPage(BlockTargetType targetType) {
    Get.toNamed('/user/block', arguments: {'blockTargetType': targetType});
  }

  @override
  void toCurationRewardGuide() {
    Get.toNamed('/curation/reward-guide');
  }

  @override
  void toOnboarding() {
    Get.toNamed('/onboarding');
  }

  @override
  void toOnboardingOffAll() {
    Get.offAll(
      OnboardingPage(lastButtonText: DS.text.start),
      duration: Duration.zero,
      transition: Transition.noTransition,
    );
  }

  @override
  void toCoupon() {
    Get.toNamed('/user/coupon');
  }
}
