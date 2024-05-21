import 'package:get/get.dart';
import 'package:teameat/2_application/voucher/voucher_used_page_controller.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class VoucherUsedPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final voucher = argMap['voucher'] as VoucherDetail;
    final usedQuantity = argMap['usedQuantity'] as int;
    Get.put(VoucherUsedPageController(
        voucher: voucher, usedQuantity: usedQuantity));
  }
}
