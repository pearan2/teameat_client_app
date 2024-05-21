import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/voucher/voucher_used_page_controller.dart';
import 'package:teameat/99_util/extension.dart';

class VoucherUsedPage extends GetView<VoucherUsedPageController> {
  const VoucherUsedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      onPop: (_) => controller.react.toHomeOffAll(),
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.toVoucherOffAll,
        homeOnPressed: controller.react.toHomeOffAll,
        title: DS.getText().allUsed,
      ),
      body: Padding(
        padding: EdgeInsets.all(DS.getSpace().xBase),
        child: Column(
          children: [
            TENetworkImage(
              url: controller.voucher.itemImageUrls.first,
              borderRadius: DS.getSpace().base,
            ),
            DS.getSpace().vBase,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
              child: Text(
                controller.voucher.itemName,
                style: DS.getTextStyle().title3,
                textAlign: TextAlign.center,
              ),
            ),
            DS.getSpace().vBase,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: controller.usedQuantity
                        .format(DS.getText().voucherCountFormat),
                    style: DS.getTextStyle().title2.copyWith(
                          color: DS.getColor().secondary500,
                        ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: DS.getText().allUsed,
                    style: DS.getTextStyle().paragraph1,
                  ),
                ],
              ),
            ),
            DS.getSpace().vBase,
            TEPrimaryButton(
              text: DS.getText().toVoucherInventory,
              onTap: controller.react.toVoucherOffAll,
              fitContentWidth: true,
              contentHorizontalPadding: DS.getSpace().xBase,
            )
          ],
        ),
      ),
    );
  }
}
