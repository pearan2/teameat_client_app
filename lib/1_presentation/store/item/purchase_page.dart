import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/business_registration_information.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/2_application/store/item/purchase_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/num.dart';

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
            DS.space.vTiny,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
              child: Text(DS.text.purchaseItemInfo,
                  style: DS.textStyle.paragraph3
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            DS.space.vSmall,
            const PurchaseItemInfoList(),
            DS.space.vBase,
            const PurchaseDivider(),
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
    final imageWith = MediaQuery.of(context).size.width / 2.5;

    return Row(
      children: [
        TENetworkCacheImage(
          url: item.imageUrl,
          width: imageWith,
          borderRadius: DS.space.small,
        ),
        DS.space.hSmall,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.store.name,
              style:
                  DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
            ),
            DS.space.vXTiny,
            Text(item.store.address,
                style: DS.textStyle.caption1.copyWith(
                  color: DS.color.background600,
                )),
            DS.space.vBase,
            Text(item.name, style: DS.textStyle.paragraph2),
            DS.space.vXTiny,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StoreItemPriceText(price: item.price * quantity),
                DS.space.hXXTiny,
                Text(
                  '/ ${quantity.format(DS.text.quantityFormat)}',
                  style: DS.textStyle.caption1,
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
        itemCount: controller.items.length);
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
