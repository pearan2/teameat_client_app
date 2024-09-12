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
  bool get isGroupBuying => itemId != null;

  PaymentResultPageController({required this.paymentResult, this.itemId});

  void paymentFailCallback() {
    react.back();
    showError(DS.text.paymentCancelledByUser +
        (paymentResult['error_msg'] as String));
  }

  /// Todo
  /// payment callback 호출 한 후, 실제로 결제된 게 맞다면 후 프로세스 처리(선물하기로 진입했을 경우)
  ///
  void fromGiftProcess() {}

  @override
  Future<bool> initialLoad() async {
    if (!isPaymentSuccess) {
      Future.delayed(Duration.zero, paymentFailCallback);
    }
    return true;
  }
}
