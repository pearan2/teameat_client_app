import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/payment/payment_result_page_controller.dart';

class PaymentResultPage extends GetView<PaymentResultPageController> {
  const PaymentResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DS.getImage().mainIconWithText,
          DS.getSpace().vXSmall,
          Text(
            '${DS.getText().paymentFinished}!',
            style: DS.getTextStyle().paragraph1,
          ),
          DS.getSpace().vTiny,
          Text(
            '${DS.getText().thanks}!',
            style: DS.getTextStyle().paragraph1,
          ),
          DS.getSpace().vBase,
          SizedBox(
            width: DS.getSpace().large * 4,
            child: TESecondaryButton(
                onTap: controller.react.toHomeOffAll,
                text: DS.getText().shoppingContinue),
          ),
          DS.getSpace().vSmall,
          SizedBox(
            width: DS.getSpace().large * 4,
            child: TEPrimaryButton(
                onTap: controller.react.toVoucherOffAll,
                text: DS.getText().toVoucherInventory),
          ),
        ],
      ),
    ));
  }
}
