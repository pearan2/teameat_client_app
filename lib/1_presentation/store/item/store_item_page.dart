import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/map.dart';
import 'package:teameat/1_presentation/core/component/store/item/curation/curation.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/item/store_item_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class StoreItemPage extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const StoreItemPage(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageWidth = width - AppWidget.horizontalPadding * 2;
    const imageRatio = 3 / 4;

    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.back,
        homeOnPressed: controller.react.toHomeOffAll,
        titleWidget: c.item.obx(
          (item) => Container(
            alignment: Alignment.center,
            width: width / 2,
            child: Text(
              item.name,
              overflow: TextOverflow.ellipsis,
              style:
                  DS.textStyle.paragraph2.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      bottomFloatingButton: StoreItemBuyButton(tag: tag),
      body: CustomScrollView(
        slivers: [
          ItemImageCarouselSliver(
              imageWidth: imageWidth, imageRatio: imageRatio, tag: tag),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppWidget.horizontalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DS.space.vTiny,
                  c.item.obx((item) => StoreItemSellType(
                        rowShapeAlignment: MainAxisAlignment.spaceEvenly,
                        textStyle: DS.textStyle.paragraph3
                            .copyWith(fontWeight: FontWeight.w600),
                        sellType: item.sellType,
                        salesWillBeEndedAt: item.salesWillBeEndedAt,
                        quantity: item.quantity,
                      )),
                  DS.space.vSmall,
                  c.item.obx((item) => StoreSimpleInfoRow(
                        location: item.store.location,
                        storeId: item.store.id,
                        profileImageUrl: item.store.profileImageUrl,
                        name: item.store.name,
                        subInfo: item.store.address,
                      )),
                  DS.space.vXBase,
                  ItemSimpleInfoAndLikeRow(tag: tag),
                  DS.space.vXBase,
                  c.item.obx((item) => StoreItemPrice(
                        originalPrice: item.originalPrice,
                        price: item.price,
                        isTitle: true,
                      )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: DS.space.vMedium),
          SliverToBoxAdapter(child: TEDivider.thick()),
          SliverToBoxAdapter(
              child: c.item.obx((i) => i.curation == null
                  ? const SizedBox()
                  : (CurationInfo(i.curation!)))),
          SliverToBoxAdapter(
              child: c.item.obx((i) => StoreItemUsageInfo(item: i))),
          SliverToBoxAdapter(child: c.item.obx((i) => StoreLocation(i))),
          SliverToBoxAdapter(child: DS.space.vBase),
          // Todo 이 사이에 상품고시정보, 취소/환불 안내 들어가야함

          SliverToBoxAdapter(child: TEDivider.thin()),
          const SliverToBoxAdapter(child: ItemNotice()),
          SliverToBoxAdapter(child: DS.space.vLarge),
          SliverToBoxAdapter(child: DS.space.vLarge),
        ],
      ),
    );
  }
}

class InfoTitle extends StatelessWidget {
  final String text;

  const InfoTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: DS.textStyle.paragraph2.copyWith(
        color: DS.color.background800,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CurationInfo extends StatelessWidget {
  final CurationMain curation;
  const CurationInfo(this.curation, {super.key});

  Widget _buildDangolPick() {
    return Text(DS.text.dangolPick, style: DS.textStyle.caption1.s900.semiBold);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DS.space.vSmall,
        Row(
          children: [
            InfoTitle(DS.text.itemDescriptionByCurator),
            DS.space.hSmall,
            _buildDangolPick(),
          ],
        ).withBasePadding,
        DS.space.vSmall,
        TEDivider.thin(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: DS.space.tiny, horizontal: DS.space.small),
          child: CurationCuratorInfo(curation),
        ),
        curation.storeImageUrls.isEmpty
            ? const SizedBox()
            : TEImageCarousel(
                width: MediaQuery.of(context).size.width,
                imageUrls: curation.storeImageUrls,
              ),
        curation.storeImageUrls.isEmpty ? const SizedBox() : DS.space.vSmall,
        Text(curation.oneLineIntroduce, style: DS.textStyle.title3)
            .withBasePadding,
        DS.space.vSmall,
        TEReadMoreText(curation.introduce, visibleLength: 72).withBasePadding,
        DS.space.vSmall,
        TEDivider.thin().withBasePadding
      ],
    );
  }
}

class ItemSimpleInfoAndLikeRow extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const ItemSimpleInfoAndLikeRow({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              c.item.obx((item) => Text(item.name,
                  style: DS.textStyle.title3.copyWith(
                      fontWeight: FontWeight.w600,
                      color: DS.color.background700))),
              DS.space.vXTiny,
              c.item.obx((item) => Text(item.introduce,
                  style: DS.textStyle.paragraph2
                      .copyWith(color: DS.color.background600))),
            ],
          ),
        ),
        DS.space.hBase,
        c.item.obx((item) => TEonTap(
              onTap: controller.onLikeClickHandler,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ItemLike.border(controller.itemId),
                  DS.space.vXXTiny,
                  item.numberOfLikes > 9999
                      ? Text(
                          '9999+',
                          style: DS.textStyle.caption2,
                        )
                      : Text(
                          item.numberOfLikes
                              .format(DS.text.numberWithoutUnitFormat),
                          style: DS.textStyle.caption2,
                        )
                ],
              ),
            )),
      ],
    );
  }
}

class ItemImageCarouselSliver extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const ItemImageCarouselSliver({
    super.key,
    required this.imageWidth,
    required this.imageRatio,
    required this.tag,
  });

  final double imageWidth;
  final double imageRatio;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      backgroundColor: DS.color.background000,
      surfaceTintColor: DS.color.background000,
      snap: false,
      floating: false,
      expandedHeight: imageWidth / imageRatio,
      flexibleSpace: c.item.obx((item) => TEImageCarousel(
            width: imageWidth,
            imageUrls: item.imageUrls,
            ratio: 3 / 4,
            bottomLeft: Padding(
              padding:
                  EdgeInsets.only(left: DS.space.xSmall, bottom: DS.space.tiny),
              child: item.curation == null
                  ? const SizedBox()
                  : DS.image.dangolPick,
            ),
          )),
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
        children: [
          SizedBox(
            width: DS.space.large * 2,
            child: Text(
              title,
              style: DS.textStyle.paragraph3.copyWith(
                color: DS.color.background500,
              ),
            ),
          ),
          Expanded(child: Text(info, style: DS.textStyle.paragraph3))
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
        DS.space.vSmall,
        InfoTitle(DS.text.itemUsageInfo),
        DS.space.vSmall,
        TEDivider.thin(),
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
    ).withBasePadding;
  }
}

class StoreLocation extends StatelessWidget {
  final ItemDetail item;

  const StoreLocation(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DS.space.vSmall,
        InfoTitle(DS.text.wayToCome),
        DS.space.vSmall,
        TEDivider.thin(),
        DS.space.vSmall,
        ClipRRect(
          borderRadius: BorderRadius.circular(DS.space.tiny),
          child: TEStoreMap.single(
              height: DS.space.large * 4,
              store: StorePoint.fromDetail(item.store),
              isLoading: false),
        ),
      ],
    ).withBasePadding;
  }
}

class StoreItemBuyBottomButton extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;
  const StoreItemBuyBottomButton(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        c.item.obx((item) => Text(
              item.name,
              style: DS.textStyle.paragraph2,
            )),
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
          showTEBottomSheet(StoreItemBuyBottomButton(tag));
        },
        text: DS.text.buy,
      ),
    );
  }
}

class ItemNotice extends StatelessWidget {
  const ItemNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppWidget.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DS.text.warningNotice, style: DS.textStyle.caption1.b500),
          DS.space.vXTiny,
          Text(DS.text.itemWarningNotice, style: DS.textStyle.caption1.b500),
        ],
      ),
    );
  }
}
