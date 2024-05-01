import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:teameat/0_config/firebase_message_config.dart';
import 'package:teameat/0_config/firebase_options.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Toss payment 결재위젯 테스트'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  final String clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
  final String customerKey = "a1b2c3d4e5f67890";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;

  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(
        clientKey: widget.clientKey, customerKey: widget.customerKey);

    _paymentWidget
        .renderPaymentMethods(
            selector: 'methods',
            amount: Amount(value: 300, currency: Currency.KRW, country: "KR"))
        .then((control) => _paymentMethodWidgetControl = control);

    _paymentWidget
        .renderAgreement(selector: 'agreement')
        .then((control) => _agreementWidgetControl = control);
  }

  Future<void> _onClick() async {
    final result = await _paymentWidget.requestPayment(
        paymentInfo: const PaymentInfo(
            orderId: "orderId_123", orderName: "WWWOW 디벨로퍼 외 2건"));
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Expanded(
          child: ListView(children: [
        PaymentMethodWidget(
          paymentWidget: _paymentWidget,
          selector: 'methods',
        ),
        AgreementWidget(paymentWidget: _paymentWidget, selector: 'agreement'),
        ElevatedButton(
            onPressed: () async {
              final paymentResult = await _paymentWidget.requestPayment(
                  paymentInfo: const PaymentInfo(
                      orderId: 'OrderId_123', orderName: '파란티셔츠 외 2건'));
              if (paymentResult.success != null) {
                print("결제가 완료되었습니다.");
              } else if (paymentResult.fail != null) {
                print("결제가 실패하였습니다.");
              }
            },
            child: const Text('결제허허기기')),
        ElevatedButton(
            onPressed: () async {
              final selectedPaymentMethod =
                  await _paymentMethodWidgetControl?.getSelectedPaymentMethod();
              print(
                  '${selectedPaymentMethod?.method} ${selectedPaymentMethod?.easyPay?.provider ?? ''}');
            },
            child: const Text('선택한 결제수단 출력')),
        ElevatedButton(
            onPressed: () async {
              final agreementStatus =
                  await _agreementWidgetControl?.getAgreementStatus();
              print('${agreementStatus?.agreedRequiredTerms}');
            },
            child: const Text('약관 동의 상태 출력')),
        ElevatedButton(
            onPressed: () async {
              await _paymentMethodWidgetControl?.updateAmount(amount: 300);
              print('결제 금액이 300원으로 변경되었습니다.');
            },
            child: const Text('결제 금액 변경'))
      ]))
    ])));
  }
}
