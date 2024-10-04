import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/component/map.dart';
import 'package:teameat/1_presentation/core/component/store/item/curation/curation.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/container.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/store/item/store_item_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/build_context.dart';
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
    const imageRatio = 3 / 4;

    return Obx(() => TEScaffold(
          loading: c.isLoading,
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
                  style: DS.textStyle.paragraph2.semiBold.b800,
                ),
              ),
            ),
          ),
          bottomSheet: StoreItemBuyButton(tag: tag),
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              ItemImageCarousel(
                      imageWidth: width, imageRatio: imageRatio, tag: tag)
                  .toSliver,
              c.item
                  .obx((item) => StoreSimpleInfoRow(
                        profileImageUrl: item.store.profileImageUrl,
                        name: item.store.name,
                        subInfo: item.store.address,
                        storeId: item.store.id,
                        location: item.store.location,
                        backgroundColor: DS.color.background100,
                        padding: EdgeInsets.all(DS.space.tiny),
                      ))
                  .toSliver,
              TEDivider.normal().toSliver,
              DS.space.vTiny.toSliver,
              StoreItemInfoBox(tag).toSliver,
              c.item
                  .obx((i) => i.curation == null
                      ? const SizedBox()
                      : CurationInfo(i.curation!)
                          .withTitle(DS.text.itemDescriptionByCurator,
                              spacing: DS.space.xSmall)
                          .withDivider(TEDivider.normal()))
                  .toSliver,
              c.item.obx((i) => StoreItemUsageInfo(item: i)).toSliver,
              TEDivider.normal().toSliver,
              StoreItemNotice.refund().withBasePadding.toSliver,
              StoreItemNotice.warning().withBasePadding.toSliver,
              c.item
                  .obx((i) => StoreLocation(i, isLoading: c.item.isLoading))
                  .toSliver,
              DS.space.vBase.toSliver,
              DS.space.vLarge.toSliver,
              DS.space.vLarge.toSliver,
            ],
          ),
        ));
  }
}

class StoreItemInfoBox extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const StoreItemInfoBox(this.tag, {super.key});

  Widget _buildSellTypeAndToolsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        c.item.obx((item) => StoreItemSellTypeBadge(sellType: item.sellType)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TEonTap(onTap: c.onShareClickHandler, child: DS.image.share),
            DS.space.hTiny,
            c.item.obx(
              (item) => Like<IStoreItemRepository>.base(
                controller.itemId,
                numberOfLikes: item.numberOfLikes,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DS.space.vSmall,
        _buildSellTypeAndToolsRow(),
        c.item.obx((item) => Text(item.name, style: DS.textStyle.title1.b800)),
        DS.space.vXSmall,
        c.item.obx((item) =>
            Text(item.introduce, style: DS.textStyle.paragraph3.h14.b800)),
        _SellTypeContentBox(tag),
        c.item.obx((item) => StoreItemPrice(
              originalPrice: item.originalPrice,
              price: item.price,
              originalPriceStyle: DS.textStyle.caption1.b500.h14,
              priceStyle: DS.textStyle.paragraph2.semiBold.b800.h14,
            ).paddingOnly(top: DS.space.xSmall)),
        DS.space.vXSmall,
        TEDivider.thin(),
        DS.space.vXSmall,
        c.item.obx((item) => TETitleContentText(
              titles: [DS.text.originInformation, DS.text.weight],
              contents: [
                item.originInformation,
                item.weight == null
                    ? '-'
                    : item.weight!.format(DS.text.weightGramFormat)
              ],
              titleStyle: DS.textStyle.caption1.semiBold.b500.h14,
              contentStyle: DS.textStyle.caption1.b500.h14,
            )),
        DS.space.vXBase,
      ],
    ).withBasePadding;
  }
}

class _SellTypeContentBox extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const _SellTypeContentBox(this.tag);

  Widget _buildContent(ItemDetail item) {
    if (item.sellType == DS.text.groupBuying) {
      return c.groupBuyings.obx((gb) => OpenedGroupBuyingList(
            groupBuyings: gb,
            onGroupBuyingClick: c.onEnterGroupBuying,
            onOpenGroupBuyingClick: c.onOpenGroupBuyingClickHandler,
          ));
    } else if (item.sellType == DS.text.sellTypeQuantityLimit) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StoreItemSellTypeBadge(sellType: item.sellType),
          Text(
            item.quantity.format(DS.text.voucherRemainQuantityFormat),
            style: DS.textStyle.caption1.semiBold.s900,
          )
        ],
      );
    } else if (item.sellType == DS.text.sellTypeTimeLimit) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StoreItemSellTypeBadge(sellType: item.sellType),
          TEDDateText(
            futurePoint: item.salesWillBeEndedAt,
            withMillis: false,
            style: DS.textStyle.caption1.semiBold.s900,
          ),
        ],
      );
    } else {
      throw 'invalid sellType';
    }
  }

  @override
  Widget build(BuildContext context) {
    return c.item.obx((item) {
      if (item.sellType == DS.text.sellTypeVoucher) {
        return const SizedBox();
      }
      return Container(
        padding: EdgeInsets.symmetric(
            vertical: DS.space.base, horizontal: DS.space.xSmall),
        decoration: BoxDecoration(
          color: DS.color.background100,
          borderRadius: BorderRadius.circular(DS.space.xTiny),
        ),
        child: _buildContent(item),
      ).paddingOnly(top: DS.space.xSmall);
    });
  }
}

class GroupBuyingListItem extends StatefulWidget {
  final GroupBuying gb;
  final void Function() onClick;

  const GroupBuyingListItem(
      {super.key, required this.gb, required this.onClick});

  @override
  State<GroupBuyingListItem> createState() => _GroupBuyingListItemState();
}

class _GroupBuyingListItemState extends State<GroupBuyingListItem> {
  int millis = 0;
  Timer? timer;
  late Duration diff;

  void timerCallback() {
    setState(() => millis += 100);
  }

  void init() {
    millis = 0;
    timer?.cancel();
    diff = widget.gb.willBeClosedAt.difference(DateTime.now());
    timer = Timer.periodic(
        const Duration(milliseconds: 100), (timer) => timerCallback());
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String calcRemainSaleDuration() {
    final remainMillis = diff.inMilliseconds - millis;

    final remainSec = remainMillis ~/ 1000;
    final intHour = remainSec ~/ 3600;
    final intMin = remainSec % 3600 ~/ 60;
    final intSec = remainSec % 60;

    String hourString = intHour.toString();
    if (hourString.length == 1) {
      hourString = '0$hourString';
    }
    String minString = intMin.toString();
    if (minString.length == 1) {
      minString = '0$minString';
    }
    String secString = intSec.toString();
    if (secString.length == 1) {
      secString = '0$secString';
    }
    return '$hourString:$minString:$secString';
  }

  Widget _buildCreatorInfoRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TECacheImage(
          src: widget.gb.creatorProfileImageUrl,
          borderRadius: 300,
          ratio: 1 / 1,
          width: DS.space.medium,
        ),
        DS.space.hTiny,
        Text(
          "${widget.gb.creatorNickname.substring(0, 2)}*",
          style: DS.textStyle.caption1.semiBold.b700,
        ),
      ],
    );
  }

  Widget _buildButton() {
    final remainMillis = diff.inMilliseconds - millis;
    if (remainMillis < 0) {
      return Text(DS.text.groupBuyingTimeOver, style: DS.textStyle.caption1);
    }
    return TEonTap(
      onTap: widget.onClick,
      isLoginRequired: true,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DS.space.tiny,
          vertical: DS.space.xxTiny,
        ),
        decoration: BoxDecoration(
          color: DS.color.secondary900,
          borderRadius: BorderRadius.circular(DS.space.xTiny),
        ),
        child: Text(
          DS.text.joinToGroupBuying,
          style: DS.textStyle.caption1.semiBold.b000.h14,
        ),
      ),
    );
  }

  Widget _buildRemainTimeAndJoinButtonRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(calcRemainSaleDuration(),
            style: DS.textStyle.caption1.semiBold.b700),
        DS.space.hTiny,
        _buildButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildCreatorInfoRow(), _buildRemainTimeAndJoinButtonRow()],
    );
  }
}

class OpenedGroupBuyingList extends StatelessWidget {
  final List<GroupBuying> groupBuyings;
  final void Function(int) onGroupBuyingClick;
  final void Function() onOpenGroupBuyingClick;
  const OpenedGroupBuyingList({
    super.key,
    required this.groupBuyings,
    required this.onGroupBuyingClick,
    required this.onOpenGroupBuyingClick,
  });

  @override
  Widget build(BuildContext context) {
    if (groupBuyings.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text(
              DS.text.openedGroupBuyingNotFound,
              style: DS.textStyle.paragraph3.b700.semiBold,
            ),
            DS.space.vTiny,
            TEPrimaryButton(
              isLoginRequired: true,
              text: DS.text.openGroupBuying,
              onTap: onOpenGroupBuyingClick,
            )
          ],
        ),
      );
    }
    return Container(
      constraints: BoxConstraints(maxHeight: DS.space.large * 4),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (_, idx) => GroupBuyingListItem(
            key: ValueKey(groupBuyings[idx].id),
            gb: groupBuyings[idx],
            onClick: () => onGroupBuyingClick(groupBuyings[idx].id)),
        separatorBuilder: (_, __) => DS.space.vSmall,
        itemCount: groupBuyings.length,
      ),
    );
  }
}

class CurationInfo extends StatelessWidget {
  final MyCurationMain curation;
  const CurationInfo(this.curation, {super.key});

  Widget _buildCuratorInfo() {
    if (curation.storeImageUrls.isNotEmpty) {
      return const SizedBox();
    }
    return CurationCuratorInfo(curation).withBasePadding;
  }

  Widget _buildCurationStoreImageCarousel(double width) {
    if (curation.storeImageUrls.isEmpty) {
      return const SizedBox();
    }
    return Stack(
      children: [
        TEImageCarousel(
          width: width,
          ratio: 3 / 4,
          imageSrcs: curation.storeImageUrls,
          overlayAdditionalHorizontalPadding: DS.space.tiny,
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TEGradientContainer(
              height: DS.space.big,
              child:
                  CurationCuratorInfo(curation, color: DS.color.background000)
                      .paddingSymmetric(
                horizontal: AppWidget.horizontalPadding,
                vertical: DS.space.xSmall,
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCuratorInfo(),
        _buildCurationStoreImageCarousel(context.screenWidth),
        DS.space.vBase,
        Text(curation.oneLineIntroduce,
                style: DS.textStyle.paragraph2.semiBold.b800.h14)
            .withBasePadding,
        DS.space.vTiny,
        TEReadMoreText(
          curation.introduce,
          visibleLength: 72,
          style: DS.textStyle.paragraph3.b500.h14,
        ).withBasePadding,
        DS.space.vBase,
      ],
    );
  }
}

class ItemImageCarousel extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const ItemImageCarousel({
    super.key,
    required this.imageWidth,
    required this.imageRatio,
    required this.tag,
  });

  final double imageWidth;
  final double imageRatio;

  @override
  Widget build(BuildContext context) {
    return c.item.obx((item) => TEImageCarousel(
          width: imageWidth,
          overlayAdditionalHorizontalPadding: DS.space.tiny,
          imageSrcs: item.imageUrls,
          ratio: 3 / 4,
        ));
  }
}

class StoreItemUsageInfo extends StatelessWidget {
  final ItemDetail item;

  const StoreItemUsageInfo({super.key, required this.item});

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

  Widget _buildStoreItemNoticeInformation() {
    return TETitleContentText(
      titles: [
        DS.text.publisher,
        DS.text.voucherProvider,
        DS.text.expiredDuration,
        DS.text.phone,
        DS.text.storeAddress,
        DS.text.voucherCanBeUsedAt,
      ],
      contents: [
        '파이어니어스',
        item.store.name,
        getExpiredAtString(),
        item.store.phone,
        item.store.address,
        DS.text.voucherCanBeUsedOnlyEnteredStore,
      ],
      titleStyle: DS.textStyle.caption1.semiBold.b600.h14,
      contentStyle: DS.textStyle.caption1.b600.h14,
    ).withTitle(
      DS.text.storeItemNoticeInformation,
      spacing: DS.space.tiny,
      style: DS.textStyle.paragraph2.semiBold.b800.h14,
      withBasePadding: false,
    );
  }

  Widget _buildStoreItemUsageInformation() {
    final List<Widget> itemUsageIcons = [
      DS.image.itemUsageInventoryIcon,
      DS.image.itemUsageQrCodeIcon,
      DS.image.itemUsageMobileIcon,
      DS.image.itemUsageGiftIcon
    ];
    final List<String> itemUsageInformation = [
      DS.text.itemUsageVoucherInformation,
      DS.text.itemUsageQrCodeInformation,
      DS.text.itemUsageMobileInformation,
      DS.text.itemUsageGiftInformation,
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xBase,
        horizontal: DS.space.small,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DS.space.xxTiny),
        color: DS.color.background100,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (_, idx) => _buildUsageInformation(
            itemUsageIcons[idx], itemUsageInformation[idx]),
        separatorBuilder: (_, __) => DS.space.vSmall,
        itemCount: 4,
      ),
    ).withTitle(
      DS.text.storeItemUsageInformation,
      spacing: DS.space.tiny,
      style: DS.textStyle.paragraph2.semiBold.b800.h14,
      withBasePadding: false,
    );
  }

  Widget _buildUsageInformation(Widget icon, String information) {
    return Row(
      children: [
        icon,
        DS.space.hBase,
        Text(information, style: DS.textStyle.caption1.b600.h14),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStoreItemNoticeInformation(),
        DS.space.vXBase,
        _buildStoreItemUsageInformation(),
        DS.space.vBase,
      ],
    )
        .withBasePadding
        .withTitle(DS.text.itemUsageInfo)
        .withDivider(TEDivider.normal());
  }
}

class StoreLocation extends StatelessWidget {
  final ItemDetail item;
  final bool isLoading;

  const StoreLocation(this.item, {super.key, required this.isLoading});

  String getCategory() {
    final category = item.store.category;
    if (!category.contains('>')) {
      return category;
    } else {
      return category.split('>').last;
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StorePoint.fromDetail(item.store);
    final react = Get.find<IReact>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TEonTap(
          onTap: () => react.toStoreDetail(item.store.id),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  item.store.name,
                  style: DS.textStyle.paragraph2.semiBold.h14.b800,
                ),
              ),
              DS.image.rightArrow(
                  size: DS.space.xBase, color: DS.color.background700)
            ],
          ).withBasePadding,
        ),
        TELeftRightText(
                getCategory(),
                item.store.numberOfCurations
                    .format(DS.text.numberOfCurationFormat))
            .withBasePadding,
        DS.space.vXSmall,
        TEStoreMap.single(
          height: DS.space.large * 4,
          store: store,
          isLoading: isLoading,
        ),
        DS.space.vXSmall,
        TETextCopyButton(textData: item.store.address).withBasePadding,
      ],
    ).withTitle(DS.text.storeLocation).withDivider(TEDivider.normal());
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
        ),
        DS.space.vXBase,
      ],
    );
  }
}

class StoreItemGroupBuyButton extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;
  const StoreItemGroupBuyButton({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TESecondaryButton(
          isLoginRequired: true,
          text: DS.text.buy2Lonely,
          onTap: c.onGroupBuyingSelfClickHandler,
        )),
        DS.space.hXTiny,
        Expanded(
            child: TEPrimaryButton(
          isLoginRequired: true,
          text: DS.text.openGroupBuying,
          onTap: c.onOpenGroupBuyingClickHandler,
        ))
      ],
    );
  }
}

class StoreItemBuyButton extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;
  const StoreItemBuyButton({super.key, required this.tag});

  Widget _buildChild() {
    return c.item.obx((item) => item.sellType == DS.text.groupBuying
        ? StoreItemGroupBuyButton(tag: tag)
        : TEPrimaryButton(
            listenEventLoading: false,
            onTap: () {
              showTEBottomSheet(StoreItemBuyBottomButton(tag));
            },
            text: DS.text.buy,
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppWidget.horizontalPadding,
        right: AppWidget.horizontalPadding,
        top: DS.space.xSmall,
        bottom: DS.space.xBase,
      ),
      decoration: BoxDecoration(
          color: DS.color.background000,
          border: Border(
              top: BorderSide(
            color: DS.color.background100,
            width: DS.space.xxTiny,
          ))),
      child: _buildChild(),
    );
  }
}
