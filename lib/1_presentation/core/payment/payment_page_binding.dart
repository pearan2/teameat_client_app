import 'package:get/get.dart';
import 'package:teameat/2_application/core/payment/payment_page_controller.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/3_domain/order/order.dart';

class PaymentPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final order = argMap['order'] as Order;
    final paymentMethod = argMap['paymentMethod'] as PaymentMethod;
    final itemId = argMap['itemId'] as int?;
    final giftQuantity = argMap['giftQuantity'] as int?;
    Get.put(PaymentPageController(
      order: order,
      paymentMethod: paymentMethod,
      itemId: itemId,
      giftQuantity: giftQuantity,
    ));
  }
}
