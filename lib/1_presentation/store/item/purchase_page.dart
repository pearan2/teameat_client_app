import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/item/purchase_method.dart';
import 'package:teameat/2_application/store/item/purchase_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension.dart';

class PurchasePage extends GetView<PurchasePageController> {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      bottomSheet: const PurchaseButton(),
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.back,
        title: DS.getText().purchase,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DS.getSpace().vTiny,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
              child: Text(DS.getText().purchaseItemInfo,
                  style: DS
                      .getTextStyle()
                      .paragraph3
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            DS.getSpace().vSmall,
            const PurchaseItemInfoList(),
            DS.getSpace().vBase,
            const PurchaseDivider(),
            DS.getSpace().vBase,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
              child: Text(DS.getText().purchaseMethod,
                  style: DS
                      .getTextStyle()
                      .paragraph3
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            DS.getSpace().vSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
              child: const PurchaseMethodSelector(),
            ),
            DS.getSpace().vBase,
            const PurchaseDivider(),
            DS.getSpace().vLarge,
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
      () => TESelectorGrid<PurchaseMethod>(
        selectedValues: controller.purchaseMethod == null
            ? []
            : [controller.purchaseMethod!],
        candidates: controller.purchaseMethods,
        numberOfRowChild: 2,
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
      height: DS.getSpace().tiny,
      color: DS.getColor().background200,
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
        TENetworkImage(
          url: item.imageUrl,
          width: imageWith,
          borderRadius: DS.getSpace().small,
        ),
        DS.getSpace().hSmall,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.store.name,
              style: DS
                  .getTextStyle()
                  .paragraph3
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            DS.getSpace().vXTiny,
            Text(item.store.address,
                style: DS.getTextStyle().caption1.copyWith(
                      color: DS.getColor().background600,
                    )),
            DS.getSpace().vBase,
            Text(item.name, style: DS.getTextStyle().paragraph2),
            DS.getSpace().vXTiny,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StoreItemPriceText(price: item.price * quantity),
                DS.getSpace().hXXTiny,
                Text(
                  '/ ${quantity.format(DS.getText().quantityFormat)}',
                  style: DS.getTextStyle().caption1,
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
        padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, idx) => PurchaseItemInfoCard(
            item: controller.items.keys.toList()[idx],
            quantity: controller.items.values.toList()[idx]),
        separatorBuilder: (_, __) => DS.getSpace().vBase,
        itemCount: controller.items.length);
  }
}

class PurchaseButton extends GetView<PurchasePageController> {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
      child: TEPrimaryButton(
        onTap: controller.onPurchaseClick,
        text:
            '${controller.totalPrice.format(DS.getText().priceFormat)} ${DS.getText().purchase}',
      ),
    );
  }
}
