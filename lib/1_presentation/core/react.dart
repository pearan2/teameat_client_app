import 'package:get/get.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/item/item.dart';

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
  void showError() {
    throw "NOT IMPLEMENTED";
  }

  @override
  void toStoreItemDetail(int itemId) {
    Get.toNamed('/store/item', arguments: {'itemId': itemId});
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
        preventDuplicates: false, arguments: {'items': items});
  }

  @override
  void toPayment() {
    Get.offNamed('/payment');
  }
}
