import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/business_registration_information.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/1_presentation/event/coupon/component/coupon.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/2_application/store/item/purchase_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

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
            PurchaseWarning(DS.text.purchaseGroupBuyingOpenWarning)
                .orEmpty(c.withOpenGroupBuying),
            PurchaseWarning(DS.text.purchaseOnlyForAdultWarning)
                .orEmpty(c.isNeedAdultWarning),
            PurchaseWarning(DS.text.purchaseForGiftWarning)
                .orEmpty(c.isForGift),
            const PurchaseItemInfoList(),
            DS.space.vXSmall,
            TEDivider.normal(),
            DS.space.vBase,
            Text(DS.text.purchaseMethod,
                    style: DS.textStyle.paragraph3
                        .copyWith(fontWeight: FontWeight.bold))
                .withBasePadding,
            DS.space.vTiny,
            Text(DS.text.purchaseHanaCardDisableNotice,
                    style: DS.textStyle.caption1.semiBold.point.h14)
                .withBasePadding,
            DS.space.vSmall,
            const PurchaseMethodSelector().withBasePadding,
            DS.space.vBase,
            const CouponList(),
            TEDivider.normal(),
            DS.space.vTiny,
            const TEServicePolicyButton(),
            const TEPrivacyPolicyButton(),
            DS.space.vTiny,
            TEDivider.normal(),
            DS.space.vBase,
            const BusinessRegistrationInformation().withBasePadding,
            DS.space.vLarge,
            DS.space.vBase,
          ],
        ),
      ),
    );
  }
}

class PurchaseWarning extends StatelessWidget {
  final String warning;

  const PurchaseWarning(this.warning, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xSmall,
        horizontal: DS.space.base,
      ),
      decoration: BoxDecoration(color: DS.color.secondary300),
      child: EmphasisText(
        warning,
        style: DS.textStyle.caption1.b800.h14,
        emphasisStyle: DS.textStyle.caption1.point.h14.bold,
      ),
    ).paddingOnly(
        bottom: DS.space.small, left: DS.space.tiny, right: DS.space.tiny);
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
        columnSpacing: DS.space.tiny,
        candidates: controller.purchaseMethods,
        numberOfRowChildrenCounts: [1, controller.purchaseMethods.length - 1],
        onTap: controller.onPurchaseMethodClick,
        builder: (value, isSelected) => TEToggle(
          borderRadius: DS.space.xTiny,
          height: DS.space.xLarge,
          text: value.method,
          isSelected: isSelected,
          textStyle: DS.textStyle.caption1.semiBold.b800,
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
            DS.space.vXBase,
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
      padding:
          const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
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

class CouponList extends GetView<PurchasePageController> {
  const CouponList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.usableCoupons.isEmpty) {
        return const SizedBox();
      }
      return Container(
        padding: EdgeInsets.all(DS.space.xBase),
        constraints: const BoxConstraints(maxHeight: 230),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(DS.text.myUsableCoupons,
                style: DS.textStyle.paragraph3
                    .copyWith(fontWeight: FontWeight.bold)),
            DS.space.vXBase,
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (_, idx) => TEonTap(
                    onTap: () => c.onSelectCoupon(c.usableCoupons[idx].id),
                    child: Obx(() => CouponCard(
                          c.usableCoupons[idx],
                          isSelected:
                              c.usableCoupons[idx].id == c.selectedCouponId,
                        ))),
                separatorBuilder: (_, __) => DS.space.vTiny,
                itemCount: c.usableCoupons.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PurchaseButton extends GetView<PurchasePageController> {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEPrimaryButton(
          listenEventLoading: true,
          onTap: c.onPurchaseClick,
          text:
              '${c.totalPrice.format(DS.text.priceFormat)} ${c.isForGift ? DS.text.giftAfterPurchase : DS.text.purchase}',
        )).withBasePadding;
  }
}
