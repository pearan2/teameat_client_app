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
          DS.image.mainIconWithText,
          DS.space.vXSmall,
          Text(
            '${DS.text.paymentFinished}!',
            style: DS.textStyle.paragraph1,
          ),
          DS.space.vTiny,
          Text(
            '${DS.text.thanks}!',
            style: DS.textStyle.paragraph1,
          ),
          DS.space.vBase,
          SizedBox(
            width: DS.space.large * 4,
            child: TESecondaryButton(
                onTap: controller.react.toHomeOffAll,
                text: DS.text.shoppingContinue),
          ),
          DS.space.vSmall,
          SizedBox(
            width: DS.space.large * 4,
            child: TEPrimaryButton(
                onTap: controller.react.toVoucherOffAll,
                text: DS.text.toVoucherInventory),
          ),
        ],
      ),
    ));
  }
}
