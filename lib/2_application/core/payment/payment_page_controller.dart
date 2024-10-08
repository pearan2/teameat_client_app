import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/3_domain/order/order.dart';

class PaymentPageController extends PageController {
  final Order order;
  final PaymentMethod paymentMethod;
  final int? itemId;
  final int? giftQuantity;

  PaymentPageController({
    required this.order,
    required this.paymentMethod,
    this.itemId,
    this.giftQuantity,
  });

  void paymentResultCallback(Map<String, String> result) {
    react.toPaymentResultOffAll(result, itemId, giftQuantity: giftQuantity);
  }
}
