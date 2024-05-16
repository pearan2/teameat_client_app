import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:teameat/2_application/core/payment/payment_page_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: AppBar(
        title: const Text('아임포트 결제'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/images/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      // L7gDuHAhg2JZYgQbQhEFfau7tHM9ThpjFSgj7MohM8X8MEI4TwbdN14a5swWdQMjMvTBkVW0JFLfjVKL
      userCode: 'imp66624150',
      /* [필수입력] 결제 데이터 */
      // inicis_v2.INIpayTest

      data: PaymentData(
          pg: 'html5_inicis.INIpayTest', // PG사
          payMethod: 'kakaopay', // 결제수단
          name: '결제 테스트 해버리기', // 주문명
          merchantUid: 'TE_${const UuidV4().generate()}', // 주문번호
          amount: 100, // 결제금액
          buyerName: '홍길동', // 구매자 이름
          buyerTel: '01012345678', // 구매자 연락처
          buyerEmail: 'example@naver.com', // 구매자 이메일
          buyerAddr: '서울시 강남구 신사동 661-16', // 구매자 주소
          buyerPostcode: '06018', // 구매자 우편번호
          appScheme: 'teameatiospaymentappscheme', // 앱 URL scheme
          cardQuota: [2, 3] //결제창 UI 내 할부개월수 제한
          ),
      callback: (Map<String, String> result) {
        print(result);
        controller.react.back();
      },
    );
  }
}
