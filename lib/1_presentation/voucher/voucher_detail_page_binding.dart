import 'package:get/get.dart';
import 'package:teameat/2_application/voucher/voucher_detail_page_controller.dart';

class VoucherDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final voucherId = argMap['voucherId'] as int;
    Get.put(VoucherDetailPageController(voucherId: voucherId));
  }
}
