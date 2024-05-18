import 'package:get/get.dart';
import 'package:teameat/2_application/voucher/voucher_page_controller.dart';

class VoucherPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(VoucherPageController());
  }
}
