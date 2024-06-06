import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/voucher/voucher_used_page_controller.dart';
import 'package:teameat/99_util/extension/int.dart';

class VoucherUsedPage extends GetView<VoucherUsedPageController> {
  const VoucherUsedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      onPop: (_) => controller.react.toHomeOffAll(),
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.toVoucherOffAll,
        homeOnPressed: controller.react.toHomeOffAll,
        title: DS.text.allUsed,
      ),
      body: Padding(
        padding: EdgeInsets.all(DS.space.xBase),
        child: Column(
          children: [
            TENetworkCacheImage(
              url: controller.voucher.itemImageUrls.first,
              borderRadius: DS.space.base,
            ),
            DS.space.vBase,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
              child: Text(
                controller.voucher.itemName,
                style: DS.textStyle.title3,
                textAlign: TextAlign.center,
              ),
            ),
            DS.space.vBase,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: controller.usedQuantity
                        .format(DS.text.voucherCountFormat),
                    style: DS.textStyle.title2.copyWith(
                      color: DS.color.secondary500,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: DS.text.allUsed,
                    style: DS.textStyle.paragraph1,
                  ),
                ],
              ),
            ),
            DS.space.vBase,
            TEPrimaryButton(
              text: DS.text.toVoucherInventory,
              onTap: controller.react.toVoucherOffAll,
              fitContentWidth: true,
              contentHorizontalPadding: DS.space.xBase,
            )
          ],
        ),
      ),
    );
  }
}
