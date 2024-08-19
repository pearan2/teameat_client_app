import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/business_registration_information.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/2_application/store/item/purchase_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class PurchasePage extends GetView<PurchasePageController> {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      bottomSheet: const PurchaseButton(),
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.back,
        homeOnPressed: controller.react.toHomeOffAll,
        title: DS.text.purchase,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DS.space.vMedium,
            const PurchaseItemInfoList(),
            DS.space.vXSmall,
            TEDivider.normal(),
            DS.space.vBase,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
              child: Text(DS.text.purchaseMethod,
                  style: DS.textStyle.paragraph3
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            DS.space.vSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
              child: const PurchaseMethodSelector(),
            ),
            DS.space.vBase,
            const PurchaseDivider(),
            DS.space.vBase,
            const TEServicePolicyButton(),
            const TEPrivacyPolicyButton(),
            DS.space.vBase,
            const DottedLine(),
            DS.space.vBase,
            const BusinessRegistrationInformation(),
            DS.space.vLarge,
          ],
        ),
      ),
    );
  }
}

class PurchaseMethodSelector extends GetView<PurchasePageController> {
  const PurchaseMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TESelectorGrid<PaymentMethod>(
        selectedValues: controller.purchaseMethod == null
            ? []
            : [controller.purchaseMethod!],
        candidates: controller.purchaseMethods,
        numberOfRowChildren: 1,
        onTap: controller.onPurchaseMethodClick,
        builder: (value, isSelected) => TEToggle(
          text: value.method,
          isSelected: isSelected,
        ),
      ),
    );
  }
}

class PurchaseDivider extends StatelessWidget {
  const PurchaseDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: DS.space.tiny,
      color: DS.color.background200,
    );
  }
}

class PurchaseItemInfoCard extends StatelessWidget {
  final ItemDetail item;
  final int quantity;

  const PurchaseItemInfoCard(
      {super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    const imageWith = 110.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TECacheImage(
          src: item.imageUrl,
          width: imageWith,
          ratio: 3 / 4,
          borderRadius: DS.space.xTiny,
        ),
        DS.space.hXSmall,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.store.name, style: DS.textStyle.caption1.b500.h14),
            Text(item.name, style: DS.textStyle.paragraph2.semiBold.b800.h14),
            DS.space.vBase,
            DS.space.vMedium,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StoreItemPrice(
                  originalPrice: item.originalPrice * quantity,
                  price: item.price * quantity,
                  originalPriceStyle: DS.textStyle.caption1.b500.h14,
                  priceStyle: DS.textStyle.paragraph2.semiBold.b800.h14,
                ),
                DS.space.hXXTiny,
                Text(
                  '/ ${quantity.format(DS.text.quantityFormat)}',
                  style: DS.textStyle.caption1.semiBold.b800.h14,
                )
              ],
            )
          ],
        )),
      ],
    );
  }
}

class PurchaseItemInfoList extends GetView<PurchasePageController> {
  const PurchaseItemInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, idx) => PurchaseItemInfoCard(
          item: controller.items.keys.toList()[idx],
          quantity: controller.items.values.toList()[idx]),
      separatorBuilder: (_, __) => DS.space.vBase,
      itemCount: controller.items.length,
    );
  }
}

class PurchaseButton extends GetView<PurchasePageController> {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
      child: TEPrimaryButton(
        listenEventLoading: true,
        onTap: controller.onPurchaseClick,
        text:
            '${controller.totalPrice.format(DS.text.priceFormat)} ${DS.text.purchase}',
      ),
    );
  }
}
