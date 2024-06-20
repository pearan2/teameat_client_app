import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/not_found.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/community_page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CommunityPage extends GetView<CommunityPageController> {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(height: 0),
      activated: BottomNavigatorType.community,
      bottomFloatingButton: const CurationApplicationButton(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: DS.space.tiny, horizontal: AppWidget.horizontalPadding),
        child: CustomScrollView(
          slivers: [
            const BannerSliver(),
            const UserInfoSliver(),
            const CurationStatusSelectorSliver(),
            const CurationList(),
            SliverToBoxAdapter(child: DS.space.vMedium),
            SliverToBoxAdapter(child: DS.space.vMedium),
          ],
        ),
      ),
    );
  }
}

class UserInfoSliver extends GetView<CommunityPageController> {
  const UserInfoSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      backgroundColor: DS.color.background000,
      surfaceTintColor: DS.color.background000,
      snap: true,
      floating: true,
      toolbarHeight: DS.space.medium,
      flexibleSpace: Container(
        padding: EdgeInsets.only(top: DS.space.small),
        alignment: Alignment.centerLeft,
        child: c.me.obx((me) => Text(
              '${me.nickname} ${DS.text.applicationsOfUserFormat}',
              style: DS.textStyle.paragraph2.copyWith(
                fontWeight: FontWeight.w600,
                color: DS.color.background800,
              ),
            )),
      ),
    );
  }
}

class BannerSliver extends StatelessWidget {
  const BannerSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      backgroundColor: DS.color.background000,
      surfaceTintColor: DS.color.background000,
      snap: true,
      floating: true,
      expandedHeight: DS.space.large * 3,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.circular(DS.space.xTiny),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: DS.color.primary600,
          child: DS.image.communityBanner1,
        ),
      ),
    );
  }
}

class CurationStatusSelectorSliver extends GetView<CommunityPageController> {
  const CurationStatusSelectorSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      backgroundColor: DS.color.background000,
      surfaceTintColor: DS.color.background000,
      pinned: true,
      toolbarHeight: DS.space.medium * 2,
      flexibleSpace: Obx(
        () => Container(
          alignment: Alignment.center,
          child: TESelectorGrid<Code>(
            selectedValues: [c.searchOption.status],
            numberOfRowChildren: c.filters.length,
            candidates: c.filters,
            isEqual: (lhs, rhs) => lhs.code == rhs.code,
            onTap: c.onFilterChanged,
            rowSpacing: DS.space.tiny,
            builder: (value, isSelected) => TEToggle(
              textUnSelected: DS.color.background600,
              textSelected: DS.color.background000,
              boxUnSelected: DS.color.background000,
              boxSelected: DS.color.primary600,
              borderRadius: DS.space.tiny,
              text: value.title,
              isSelected: isSelected,
              textStyle: DS.textStyle.paragraph3,
              withShadow: true,
            ),
          ),
        ),
      ),
    );
  }
}

class CurationApplicationButton extends GetView<CommunityPageController> {
  const CurationApplicationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DS.space.medium),
      child: TEPrimaryButton(
        isLoginRequired: true,
        listenEventLoading: false,
        onTap: c.onCurationApplicationClicked,
        text: DS.text.menuApplication,
        withShadow: true,
      ),
    );
  }
}

class CurationCreatedAtAndStatusRow extends StatelessWidget {
  final CurationSimple curation;
  const CurationCreatedAtAndStatusRow({super.key, required this.curation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          curation.createdAt.format(DS.text.yyyyMMddBasicFormat),
          style:
              DS.textStyle.paragraph3.copyWith(color: DS.color.background500),
        ),
        Text(
          curation.getStatusText(),
          style: DS.textStyle.paragraph3
              .copyWith(color: curation.getStatusColor()),
        )
      ],
    );
  }
}

class CurationImage extends StatelessWidget {
  final CurationSimple curation;

  const CurationImage({super.key, required this.curation});

  @override
  Widget build(BuildContext context) {
    return TECacheImage(
      src: curation.imageUrl,
      width: CurationCard.imageSize,
      ratio: 1 / 1,
      borderRadius: DS.space.xTiny,
    );
  }
}

class CurationItemInfoColumn extends StatelessWidget {
  final CurationSimple curation;
  const CurationItemInfoColumn({super.key, required this.curation});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          curation.storeName,
          style: DS.textStyle.caption1.copyWith(color: DS.color.background500),
        ),
        DS.space.vTiny,
        Text(curation.name,
            style: DS.textStyle.paragraph3
                .copyWith(color: DS.color.background700)),
        DS.space.vTiny,
        curation.item == null
            ? Text(
                curation.originalPrice.format(DS.text.priceFormat),
                style: DS.textStyle.paragraph3.copyWith(
                    fontWeight: FontWeight.bold, color: DS.color.background800),
              )
            : StoreItemPrice(
                originalPrice: curation.item!.originalPrice,
                price: curation.item!.price,
              )
      ],
    );
  }
}

class CurationRewardRow extends StatelessWidget {
  final ItemSimple item;
  final int? itemSellTotalAmount;
  final double rewardRatio;

  const CurationRewardRow({
    super.key,
    required this.item,
    required this.itemSellTotalAmount,
    required this.rewardRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: CurationCard.imageSize,
          child: StoreItemSellType(
            sellType: item.sellType,
            quantity: item.quantity,
            salesWillBeEndedAt: item.salesWillBeEndedAt,
            useDDay: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Container(
                width: DS.space.tiny,
                height: DS.space.tiny,
                color: DS.color.secondary500,
              ),
            ),
            DS.space.hTiny,
            Text(
              DS.text.reward,
              style: DS.textStyle.paragraph3
                  .copyWith(color: DS.color.background700),
            ),
            DS.space.hTiny,
            Text(
              (((itemSellTotalAmount ?? 0) * rewardRatio).round())
                  .format(DS.text.priceFormat),
              style: DS.textStyle.paragraph2.copyWith(
                color: DS.color.background800,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    );
  }
}

class CurationCard extends GetView<CommunityPageController> {
  static const imageSize = 120.0;
  final CurationSimple curation;

  const CurationCard({super.key, required this.curation});

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => c.react.toCommunityView(curation.id),
      child: Container(
        padding: EdgeInsets.all(DS.space.small),
        decoration: BoxDecoration(
            border: Border.all(color: DS.color.background200),
            borderRadius: BorderRadius.circular(DS.space.xTiny),
            color: DS.color.background000,
            boxShadow: [
              BoxShadow(
                color: DS.color.background800.withOpacity(0.05),
                blurRadius: DS.space.xTiny,
                offset: Offset(0, DS.space.xTiny),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CurationCreatedAtAndStatusRow(curation: curation),
            DS.space.vSmall,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurationImage(curation: curation),
                DS.space.hXSmall,
                CurationItemInfoColumn(curation: curation),
              ],
            ),
            curation.item == null ? const SizedBox() : DS.space.vTiny,
            curation.item == null
                ? const SizedBox()
                : CurationRewardRow(
                    item: curation.item!,
                    itemSellTotalAmount: curation.itemSellTotalAmount,
                    rewardRatio: curation.rewardRatio,
                  ),
          ],
        ),
      ),
    );
  }
}

class CurationList extends GetView<CommunityPageController> {
  const CurationList({super.key});

  @override
  Widget build(BuildContext context) {
    return PagedSliverList.separated(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<CurationSimple>(
        noItemsFoundIndicatorBuilder: (_) => Center(
          child: SimpleNotFound(
            title: DS.text.curationNotFound,
            buttonText: DS.text.goToApplyMyFavoriteMenu,
            onTap: controller.react.toCommunityCreate,
          ),
        ),
        itemBuilder: (_, curation, idx) =>
            CurationCard(key: ValueKey(curation.id), curation: curation),
      ),
      separatorBuilder: (_, idx) => DS.space.vTiny,
    );
  }
}
