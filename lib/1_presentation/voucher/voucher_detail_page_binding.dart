import 'package:get/get.dart';
import 'package:teameat/2_application/voucher/voucher_detail_page_controller.dart';

class VoucherDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    final voucherIdString = Get.parameters["voucherId"]!;
    Get.put(VoucherDetailPageController(voucherId: int.parse(voucherIdString)));
  }
}
