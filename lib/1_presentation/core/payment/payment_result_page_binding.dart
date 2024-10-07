import 'package:get/get.dart';
import 'package:teameat/2_application/core/payment/payment_result_page_controller.dart';

class PaymentResultPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final result = argMap['result'] as Map<String, String>;
    final itemId = argMap['itemId'] as int?;
    final giftQuantity = argMap['giftQuantity'] as int?;

    Get.put(PaymentResultPageController(
      paymentResult: result,
      itemId: itemId,
      giftQuantity: giftQuantity,
    ));
  }
}
