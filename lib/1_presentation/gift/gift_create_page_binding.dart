import 'package:get/get.dart';
import 'package:teameat/2_application/gift/gift_create_page_controller.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class GiftCreatePageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final voucher = argMap['voucher'] as VoucherDetail;
    final giftQuantity = argMap['giftQuantity'] as int;

    Get.put(
        GiftCreatePageController(voucher: voucher, giftQuantity: giftQuantity));
  }
}
