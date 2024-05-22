import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';

class PaymentResultPageController extends PageController {
  final Map<String, String> paymentResult;

  bool get isPaymentSuccess => paymentResult['imp_success'] == null
      ? false
      : paymentResult['imp_success'] != 'false';

  PaymentResultPageController({required this.paymentResult});

  void paymentFailCallback() {
    react.back();
    showError(DS.text.paymentCancelledByUser);
  }

  @override
  Future<bool> initialLoad() async {
    if (!isPaymentSuccess) {
      Future.delayed(Duration.zero, paymentFailCallback);
    }
    return true;
  }
}
