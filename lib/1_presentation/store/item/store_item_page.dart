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
            backgroundColor: DS.color.background000,
            surfaceTintColor: DS.color.background000,
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
              padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DS.space.vTiny,
                      PageLoadingWrapper(
                          child: StoreSimpleInfoRow(
                        storeId: controller.item.store.id,
                        profileImageUrl: controller.item.store.profileImageUrl,
                        name: controller.item.store.name,
                        subInfo: controller.item.store.address,
                      )),
                      DS.space.vSmall,
                      PageLoadingWrapper(
                          child: Text(controller.item.name,
                              style: DS.textStyle.title3)),
                      DS.space.vTiny,
                      PageLoadingWrapper(
                          child: Text(
                        controller.item.introduce,
                        style: DS.textStyle.paragraph3
                            .copyWith(fontWeight: FontWeight.normal),
                      )),
                      DS.space.vTiny,
                      PageLoadingWrapper(
                        child: StoreItemSellTypeText(
                            sellType: controller.item.sellType),
                      ),
                      DS.space.vTiny,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PageLoadingWrapper(
                            child: StoreItemPriceText(
                                price: controller.item.price, isTitle: true),
                          ),
                          DS.space.hXTiny,
                          PageLoadingWrapper(
                            child: ItemPriceDiscountRateText(
                              price: controller.item.price,
                              originalPrice: controller.item.originalPrice,
                              withPercentage: false,
                            ),
                          )
                        ],
                      ),
                      DS.space.vSmall,
                      StoreItemUsageInfo(item: controller.item),
                      DS.space.vLarge
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
      padding: EdgeInsets.only(top: DS.space.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: DS.textStyle.paragraph3.copyWith(
              color: DS.color.background400,
            ),
          ),
          Text(info, style: DS.textStyle.paragraph3)
        ],
      ),
    );
  }

  String getExpiredAtString() {
    if (item.willBeExpiredAfterDay == null && item.willBeExpiredAt == null) {
      return DS.text.noData;
    }
    if (item.willBeExpiredAt != null) {
      return item.willBeExpiredAt!.format(DS.text.willBeExpiredAtFormat);
    }
    return item.willBeExpiredAfterDay!
        .format(DS.text.willBeExpiredAfterDayFormat);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DS.text.itemUsageInfo,
          style: DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
        ),
        DS.space.vSmall,
        Divider(
          color: DS.color.background800,
        ),
        buildInfo(DS.text.expiredAt, getExpiredAtString()),
        buildInfo(DS.text.phone, item.store.phone),
        buildInfo(DS.text.operationTime, item.store.operationTime),
        buildInfo(DS.text.breakTime, item.store.breakTime),
        buildInfo(DS.text.lastOrderTime, item.store.lastOrderTime),
        buildInfo(DS.text.originInformation, item.originInformation),
        item.weight != null
            ? buildInfo(
                DS.text.weight, item.weight!.format(DS.text.weightGramFormat))
            : const SizedBox(),
        DS.space.vSmall,
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
          style: DS.textStyle.paragraph2,
        ),
        DS.space.vBase,
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
        DS.space.vBase,
        TEPrimaryButton(
          isLoginRequired: true,
          onTap: controller.onBuyClickHandler,
          text: DS.text.buy,
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
      padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
      child: TEPrimaryButton(
        listenEventLoading: false,
        onTap: () {
          showTEBottomSheet(StoreItemBuyBottomSheet(tag));
        },
        text: DS.text.buy,
      ),
    );
  }
}
