import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/payment/i_payment_repository.dart';

class PaymentResultPageController extends PageController {
  final _paymentRepo = Get.find<IPaymentRepository>();
  final _isLoading = true.obs;

  final Map<String, String> paymentResult;
  final int? itemId;
  final bool isForGift;

  /// 참조 :https://developers.portone.io/docs/ko/sdk/javascript-sdk/payrt?v=v1
  /// 웰컴페이먼츠 연동시에는 imp_uid, merchant_uid, error_code, error_msg만 제공됩니다.
  bool get isPaymentSuccess =>
      paymentResult['error_code'] == null ? true : false;
  bool get isGroupBuying => itemId != null;
  bool get isLoading => _isLoading.value;

  PaymentResultPageController(
      {required this.paymentResult, this.itemId, this.isForGift = false});

  void _paymentFailCallback() {
    react.back();
    showError(DS.text.paymentCancelledByUser +
        (paymentResult['error_msg'] as String));
  }

  Future<void> _paymentSuccessProcess() async {
    final orderId = paymentResult['merchant_uid'];
    final paymentId = paymentResult['imp_uid'];
    if (orderId == null || paymentId == null) {
      react.back();
      showError(DS.text.paymentIsNotCorrect);
      return;
    }

    final ret =
        await _paymentRepo.isPaid(orderId: orderId, paymentId: paymentId);
    return ret.fold(
      (l) {
        react.back();
        showError(l.desc);
      },
      (r) {
        _isLoading.value = false;
        print(isForGift);
      },
    );
  }

  @override
  Future<bool> initialLoad() async {
    Future.delayed(Duration.zero, () {
      if (!isPaymentSuccess) {
        _paymentFailCallback();
      } else {
        _paymentSuccessProcess();
      }
    });
    return true;
  }
}
