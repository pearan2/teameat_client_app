import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/item/store_item_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension.dart';

class StoreItemPage extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const StoreItemPage(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.back,
        homeOnPressed: controller.react.toHomeOffAll,
      ),
      bottomSheet: StoreItemBuyButton(tag: tag),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            backgroundColor: DS.getColor().background000,
            surfaceTintColor: DS.getColor().background000,
            snap: true,
            floating: true,
            expandedHeight: width,
            flexibleSpace: Obx(
              () => StoreItemImageCarousel(
                width: width,
                height: width,
                item: controller.item,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DS.getSpace().vTiny,
                      PageLoadingWrapper(
                          child: StoreSimpleInfoRow(
                        storeId: controller.item.store.id,
                        profileImageUrl: controller.item.store.profileImageUrl,
                        name: controller.item.store.name,
                        subInfo: controller.item.store.address,
                      )),
                      DS.getSpace().vSmall,
                      PageLoadingWrapper(
                          child: Text(controller.item.name,
                              style: DS.getTextStyle().title3)),
                      DS.getSpace().vTiny,
                      PageLoadingWrapper(
                          child: Text(
                        controller.item.introduce,
                        style: DS
                            .getTextStyle()
                            .paragraph3
                            .copyWith(fontWeight: FontWeight.normal),
                      )),
                      DS.getSpace().vTiny,
                      PageLoadingWrapper(
                        child: StoreItemSellTypeText(
                            sellType: controller.item.sellType),
                      ),
                      DS.getSpace().vTiny,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PageLoadingWrapper(
                            child: StoreItemPriceText(
                                price: controller.item.price, isTitle: true),
                          ),
                          DS.getSpace().hXTiny,
                          PageLoadingWrapper(
                            child: ItemPriceDiscountRateText(
                              price: controller.item.price,
                              originalPrice: controller.item.originalPrice,
                              withPercentage: false,
                            ),
                          )
                        ],
                      ),
                      DS.getSpace().vSmall,
                      StoreItemUsageInfo(item: controller.item),
                      DS.getSpace().vLarge
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class StoreItemUsageInfo extends StatelessWidget {
  final ItemDetail item;

  const StoreItemUsageInfo({super.key, required this.item});

  Widget buildInfo(String title, String info) {
    return Padding(
      padding: EdgeInsets.only(top: DS.getSpace().small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: DS.getTextStyle().paragraph3.copyWith(
                  color: DS.getColor().background400,
                ),
          ),
          Text(info, style: DS.getTextStyle().paragraph3)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DS.getText().itemUsageInfo,
          style: DS
              .getTextStyle()
              .paragraph3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        DS.getSpace().vSmall,
        Divider(
          color: DS.getColor().background800,
        ),
        buildInfo(DS.getText().expiredAt,
            item.willBeExpiredAt.format(DS.getText().yyyyMMddBasicFormat)),
        buildInfo(DS.getText().phone, item.store.phone),
        buildInfo(DS.getText().operationTime, item.store.operationTime),
        buildInfo(DS.getText().breakTime, item.store.breakTime),
        buildInfo(DS.getText().lastOrderTime, item.store.lastOrderTime),
        buildInfo(DS.getText().originInformation, item.originInformation),
      ],
    );
  }
}

class StoreItemBuyBottomSheet extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;
  const StoreItemBuyBottomSheet(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.item.name,
          style: DS.getTextStyle().paragraph2,
        ),
        DS.getSpace().vBase,
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StoreItemQuantityPicker(
                quantity: controller.buyQuantity,
                onQuantityChanged: controller.onBuyQuantityChanged,
              ),
              StoreItemPriceText(price: controller.totalPrice)
            ],
          ),
        ),
        DS.getSpace().vBase,
        TEPrimaryButton(
          isLoginRequired: true,
          onTap: controller.onBuyClickHandler,
          text: DS.getText().buy,
        )
      ],
    );
  }
}

class StoreItemBuyButton extends StatelessWidget {
  final String tag;
  const StoreItemBuyButton({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
      child: TEPrimaryButton(
        listenEventLoading: false,
        onTap: () {
          showTEBottomSheet(StoreItemBuyBottomSheet(tag));
        },
        text: DS.getText().buy,
      ),
    );
  }
}
