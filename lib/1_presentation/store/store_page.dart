import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/expandable.dart';
import 'package:teameat/1_presentation/core/component/map.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/store_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StorePage extends GetView<StorePageController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TEScaffold(
        loading: c.isLoading,
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          headerSliverBuilder: (_, __) => [
            c.store.obx(
              (store) =>
                  ColorAdjustImageCarouselAppBar(imageUrls: store.imageUrls),
              loadingBuilder: (_) => ColorAdjustImageCarouselAppBar.loading(),
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _StoreInfoColumn(),
                TEDivider.normal()
                    .paddingOnly(top: DS.space.xBase, bottom: DS.space.medium),
                const _StoreItemSimpleList(),
                TEDivider.normal().paddingVertical(DS.space.medium),
                const _StoreCurationSimpleList(),
                c.store.obx((s) => s.numberOfCurations < 1
                    ? const SizedBox()
                    : TEDivider.normal().paddingVertical(DS.space.medium)),
                const _StoreLocationColumn(),
                DS.space.vLarge,
                DS.space.vLarge,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoreInfoColumn extends GetView<StorePageController> {
  const _StoreInfoColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StoreItemSaleStatusAndToolsRow(),
        DS.space.vXSmall,
        c.store
            .obx((s) => Text(s.name, style: DS.textStyle.title1.b800.bold.h14)),
        c.store.obx((s) => TELeftRightText(
              s.cleanCategory,
              s.numberOfCurations.format(DS.text.numberOfCurationFormat),
              style: DS.textStyle.caption1.b500.h14,
            )),
        DS.space.vXSmall,
        c.store.obx(
          (s) => TEExpandable(
            header: Text(s.oneLineIntroduce,
                style: DS.textStyle.paragraph3.b800.h14),
            content: Text(s.introduce, style: DS.textStyle.paragraph3.b800.h14)
                .paddingOnly(top: DS.space.xTiny),
          ),
        ),
        DS.space.vXSmall,
        TEDivider.thin(),
        DS.space.vXSmall,
        Row(
          children: [
            DS.image.phone(size: DS.space.small, color: DS.color.background700),
            DS.space.hTiny,
            c.store.obx((s) => TEonTap(
                  onTap: () => launchUrlString('tel:${s.phone}'),
                  child: TEUnderlineText(
                    s.phone,
                    style: DS.textStyle.paragraph3.b800.h14,
                    underlineColor: DS.color.background800,
                  ),
                )),
          ],
        ),
        DS.space.vTiny,
        Row(
          children: [
            DS.image.locationSm,
            DS.space.hTiny,
            c.store.obx((s) => DistanceText(
                  point: s.location,
                  padding: EdgeInsets.only(right: DS.space.tiny),
                  style: DS.textStyle.paragraph3.b700.semiBold,
                )),
            Expanded(
              child: c.store.obx(
                  (s) => Text(s.address, style: DS.textStyle.paragraph3.b800)),
            ),
          ],
        ),
        DS.space.vTiny,
        c.store.obx((s) => StoreTimeInfoExpandable(s.timeInfo)),
      ],
    ).paddingOnly(
      left: AppWidget.horizontalPadding,
      right: AppWidget.horizontalPadding,
      top: AppWidget.horizontalPadding,
    );
  }
}

class _StoreItemSaleStatusAndToolsRow extends GetView<StorePageController> {
  const _StoreItemSaleStatusAndToolsRow();

  @override
  Widget build(BuildContext context) {
    return c.store.obx((store) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (const StoreItemInSaleIcon()).orEmpty(store.simpleItems.isNotEmpty),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TEonTap(onTap: c.onShare, child: DS.image.share),
              DS.space.hXSmall,
              StoreLike(storeId: c.storeId),
            ],
          )
        ],
      );
    });
  }
}

class _StoreItemSimpleList extends GetView<StorePageController> {
  const _StoreItemSimpleList();

  Widget _buildSimpleItemCard(StoreDetailItemSimple item) {
    return TEonTap(
      onTap: () => c.react.toStoreItemDetail(item.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TECacheImage(
            src: item.imageUrl,
            width: 110,
            ratio: 3 / 4,
            borderRadius: DS.space.xTiny,
          ),
          DS.space.hXSmall,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: DS.textStyle.paragraph2.semiBold.b800.h14,
                ),
                Text(
                  item.introducePreview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: DS.textStyle.caption1.b600.h14,
                ),
                DS.space.vMedium,
                StoreItemPrice(
                  originalPrice: item.originalPrice,
                  price: item.price,
                  originalPriceStyle: DS.textStyle.caption1.b500.h14,
                  priceStyle: DS.textStyle.paragraph2.b800.semiBold.h14,
                ),
              ],
            ),
          )
        ],
      ),
    ).withBasePadding;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(DS.text.storeItemInSale, style: DS.textStyle.title3.bold.b800.h14)
            .withBasePadding,
        DS.space.vBase,
        c.store.obx((s) => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (_, idx) => _buildSimpleItemCard(s.simpleItems[idx]),
              separatorBuilder: (_, __) =>
                  TEDivider.thin().paddingVertical(DS.space.xSmall),
              itemCount: s.simpleItems.length,
            )),
      ],
    );
  }
}

class _StoreCurationSimpleList extends GetView<StorePageController> {
  const _StoreCurationSimpleList();

  final listHeight = 211.0;
  final width = 170.0;

  Widget _buildSimpleCurationCard(CurationListSimple curation) {
    return TEonTap(
      onTap: () => c.react.toCurationDetail(curation.id),
      isLoginRequired: true,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TECacheImage(
              src: curation.imageUrl,
              borderRadius: DS.space.xTiny,
              width: width,
              ratio: 1 / 1,
            ),
            DS.space.vTiny,
            Text(
              curation.oneLineIntroduce,
              style: DS.textStyle.caption1.bold.b800.h14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              curation.introducePreview,
              style: DS.textStyle.caption2.b600.h14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return c.store.obx((s) {
      if (s.numberOfCurations < 1) {
        return const SizedBox();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DS.text.curationOfThisStore,
                  style: DS.textStyle.title3.bold.b800.h14)
              .withBasePadding,
          DS.space.vBase,
          SizedBox(
            height: listHeight,
            child: PagedListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: AppWidget.horizontalPadding),
              pagingController: c.pagingController,
              builderDelegate: PagedChildBuilderDelegate<CurationListSimple>(
                  itemBuilder: (_, curationSimple, __) =>
                      _buildSimpleCurationCard(curationSimple)),
              separatorBuilder: (_, __) => DS.space.hXSmall,
            ),
          ),
        ],
      );
    });
  }
}

class _StoreLocationColumn extends GetView<StorePageController> {
  const _StoreLocationColumn();

  final mapHeight = 170.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DS.text.storeLocation,
          style: DS.textStyle.title3.bold.b800.h14,
        ).paddingSymmetric(horizontal: AppWidget.horizontalPadding),
        DS.space.vBase,
        c.store.obx(
          (s) => TESingleStoreMap(
            height: mapHeight,
            store: StorePoint.fromDetail(s),
            address: s.address,
            isLoading: s == StoreDetail.empty(),
          ),
        ),
      ],
    );
  }
}
