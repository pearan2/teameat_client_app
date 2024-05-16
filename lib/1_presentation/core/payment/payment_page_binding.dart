import 'package:get/get.dart';
import 'package:teameat/2_application/core/payment/payment_page_controller.dart';

class PaymentPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentPageController());
  }
}
