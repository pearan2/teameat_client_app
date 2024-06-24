import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';

class PaymentResultPageController extends PageController {
  final Map<String, String> paymentResult;
  final int? itemId;

  /// 참조 :https://developers.portone.io/docs/ko/sdk/javascript-sdk/payrt?v=v1
  /// 웰컴페이먼츠 연동시에는 imp_uid, merchant_uid, error_code, error_msg만 제공됩니다.
  bool get isPaymentSuccess =>
      paymentResult['error_code'] == null ? true : false;

  PaymentResultPageController({required this.paymentResult, this.itemId});

  void paymentFailCallback() {
    react.back();
    showError(DS.text.paymentCancelledByUser +
        (paymentResult['error_msg'] as String));
  }

  @override
  Future<bool> initialLoad() async {
    if (!isPaymentSuccess) {
      Future.delayed(Duration.zero, paymentFailCallback);
    }
    return true;
  }
}
