import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/2_application/core/payment/payment_page_controller.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: TEAppBar(
          title: DS.text.payment, leadingIconOnPressed: controller.react.back),
      initialChild: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DS.image.mainLargeIconNoBg,
            DS.space.vBase,
            Text(DS.text.pleaseWait, style: DS.textStyle.paragraph3),
          ],
        ),
      ),

      userCode: 'imp66624150', // 고객사 식별 코드
      data: PaymentData(
        pg: 'welcome.welcometst', // PG사 (웰컴페이먼츠로 변경) '{PG_PROVIDER}.{MID}'
        payMethod: controller.paymentMethod.value, // 결제수단
        name: controller.order.name, // 주문명
        merchantUid: controller.order.orderId, // 주문번호
        amount: controller.order.totalAmount, // 결제금액
        buyerName: controller.order.memberSocialId, // 주문자 소셜 id
        buyerTel: controller.order.memberSocialId, // 구매자 연락처
        buyerEmail: controller.order.memberEmail, // 구매자 이메일
        appScheme: 'teameatiospaymentappscheme', // 앱 URL scheme (ios)
        cardQuota: [], //결제창 UI 내 할부개월수 제한 // [] 일 경우 일시불만 결제 가능
        noticeUrl: Environment().isDev
            ? 'https://javelin-relaxed-garfish.ngrok-free.app/api/payment/callback'
            : null,
      ),
      callback: controller.paymentResultCallback,
    );
  }
}
