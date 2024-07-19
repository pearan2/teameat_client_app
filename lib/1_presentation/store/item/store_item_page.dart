import 'dart:async';

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
import 'package:teameat/3_domain/order/order.dart';
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

    return Obx(() => TEScaffold(
          loading: c.isLoading,
          appBar: TEAppBar(
            leadingIconOnPressed: controller.react.back,
            homeOnPressed: c.absorbing ? null : controller.react.toHomeOffAll,
            titleWidget: c.item.obx(
              (item) => Container(
                alignment: Alignment.center,
                width: width / 2,
                child: Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  style: DS.textStyle.paragraph2
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          bottomFloatingButton: c.onApplyCuration != null
              ? StoreItemCurationButton(tag: tag)
              : StoreItemBuyButton(tag: tag),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemImageCarousel(
                    imageWidth: imageWidth, imageRatio: imageRatio, tag: tag),
                AbsorbPointer(
                  absorbing: c.absorbing,
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
                        c.groupBuyings
                            .obx((groupBuyings) => OpenedGroupBuyingList(
                                  groupBuyings: groupBuyings,
                                  onGroupBuyingClick: c.onEnterGroupBuying,
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
                        ItemPriceAndShareRow(tag: tag),
                      ],
                    ),
                  ),
                ),
                DS.space.vMedium,
                TEDivider.thick(),
                c.item.obx((i) => i.curation == null
                    ? const SizedBox()
                    : (CurationInfo(i.curation!))),
                c.item.obx((i) => StoreItemUsageInfo(item: i)),
                c.item.obx((i) => StoreLocation(i)),
                DS.space.vBase,
                // Todo 이 사이에 상품고시정보, 취소/환불 안내 들어가야함
                TEDivider.thin(),
                const ItemNotice(),
                DS.space.vLarge,
                DS.space.vLarge,
              ],
            ),
          ),
        ));
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
    return '$hourString:$minString:$secString.${((remainMillis % 1000) / 100).floor()}';
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
        Text("${widget.gb.creatorNickname.substring(0, 2)}*"),
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
        padding: EdgeInsets.all(DS.space.tiny),
        decoration: BoxDecoration(
          color: DS.color.point500,
          borderRadius: BorderRadius.circular(DS.space.xTiny),
        ),
        child: Text(
          DS.text.joinToGroupBuying,
          style: DS.textStyle.paragraph3.b000,
        ),
      ),
    );
  }

  Widget _remainSaleDurationColumn() {
    final remainMillis = diff.inMilliseconds - millis;
    if (remainMillis < 0) return const SizedBox();

    final style = DS.textStyle.caption1.b700;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(DS.text.onePerson, style: style.point.bold),
            DS.space.hXXTiny,
            Text(DS.text.remain, style: style)
          ],
        ),
        DS.space.vXXTiny,
        Text(calcRemainSaleDuration(), style: style),
      ],
    );
  }

  Widget _buildRemainTimeAndJoinButtonRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _remainSaleDurationColumn(),
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
  const OpenedGroupBuyingList({
    super.key,
    required this.groupBuyings,
    required this.onGroupBuyingClick,
  });

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: DS.color.background400);

    if (groupBuyings.isEmpty) {
      return const SizedBox();
    }
    return Container(
      constraints: BoxConstraints(maxHeight: DS.space.large * 4),
      decoration: BoxDecoration(
        border: Border(right: borderSide, left: borderSide, bottom: borderSide),
        borderRadius: BorderRadius.circular(DS.space.xxTiny),
      ),
      child: ListView.separated(
        padding: EdgeInsets.all(DS.space.small),
        shrinkWrap: true,
        itemBuilder: (_, idx) => GroupBuyingListItem(
            key: ValueKey(groupBuyings[idx].id),
            gb: groupBuyings[idx],
            onClick: () => onGroupBuyingClick(groupBuyings[idx].id)),
        separatorBuilder: (_, __) => DS.space.vTiny,
        itemCount: groupBuyings.length,
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
                imageSrcs: curation.storeImageUrls,
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

class ItemPriceAndShareRow extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;
  const ItemPriceAndShareRow({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        c.item.obx((item) => StoreItemPrice(
              originalPrice: item.originalPrice,
              price: item.price,
              isTitle: true,
            )),
        TEonTap(
          onTap: c.onShareClickHandler,
          child: const Icon(Icons.share),
        ),
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
          imageSrcs: item.imageUrls,
          ratio: 3 / 4,
          bottomLeft: Padding(
            padding:
                EdgeInsets.only(left: DS.space.xSmall, bottom: DS.space.tiny),
            child:
                item.curation == null ? const SizedBox() : DS.image.dangolPick,
          ),
        ));
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
    final store = StorePoint.fromDetail(item.store);

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
            store: store,
            isLoading: item == ItemDetail.empty(),
          ),
        ),
        DS.space.vTiny,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GoToMap(
              store: store,
              name: item.store.name,
            ),
            TETextCopyButton(
              textData: item.store.address,
              style: DS.textStyle.caption1,
              text: DS.text.copyAddress,
            ),
          ],
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
        DS.space.hTiny,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
      child: c.item.obx((item) => item.sellType == DS.text.groupBuying
          ? StoreItemGroupBuyButton(tag: tag)
          : TEPrimaryButton(
              listenEventLoading: false,
              onTap: () {
                showTEBottomSheet(StoreItemBuyBottomButton(tag));
              },
              text: DS.text.buy,
            )),
    );
  }
}

class StoreItemCurationButton extends GetView<StoreItemPageController> {
  @override
  // ignore: overridden_fields
  final String tag;
  const StoreItemCurationButton({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
      child: TEPrimaryButton(
        listenEventLoading: false,
        onTap: c.onApplyCuration,
        text: DS.text.menuApplication,
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
