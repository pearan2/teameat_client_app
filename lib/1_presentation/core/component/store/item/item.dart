import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/expandable.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/container.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/main.dart';

class StoreItemOriginalPriceText extends StatelessWidget {
  final int originalPrice;
  final int price;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isTitle;
  final bool withDiscountText;
  const StoreItemOriginalPriceText({
    super.key,
    required this.originalPrice,
    required this.price,
    this.isTitle = false,
    this.withDiscountText = true,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final style =
        isTitle ? DS.textStyle.paragraph3.h14 : DS.textStyle.caption2.h14;

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(DS.text.discountPrice, style: style.point.semiBold)
            .orEmpty(withDiscountText),
        DS.space.hXTiny.orEmpty(withDiscountText),
        Text(
          originalPrice.format(DS.text.priceFormat),
          style: style.copyWith(
            color: DS.color.background500,
            decoration: TextDecoration.lineThrough,
            decorationColor: DS.color.background500,
          ),
        ),
      ],
    );
  }
}

class StoreItemPriceDiscountRateText extends StatelessWidget {
  final int originalPrice;
  final int price;
  final bool isTitle;

  const StoreItemPriceDiscountRateText({
    super.key,
    required this.originalPrice,
    this.isTitle = false,
    required this.price,
  });

  String calcDiscountRateString() {
    final temp = (1 - (price / originalPrice)) * 100;
    return '${temp.ceil()}%';
  }

  @override
  Widget build(BuildContext context) {
    final style = isTitle
        ? DS.textStyle.paragraph2.point.semiBold.h14
        : DS.textStyle.paragraph3.point.semiBold.h14;
    return Text(calcDiscountRateString(), style: style);
  }
}

class StoreItemPrice extends StatelessWidget {
  final int originalPrice;
  final int price;
  final TextStyle originalPriceStyle;
  final TextStyle priceStyle;

  const StoreItemPrice({
    super.key,
    required this.originalPrice,
    required this.price,
    required this.originalPriceStyle,
    required this.priceStyle,
  });

  bool isDiscount() {
    return price < originalPrice;
  }

  String priceToString(int price) {
    return price.format(DS.text.priceFormat);
  }

  String calcDiscountRateString() {
    final temp = (1 - (price / originalPrice)) * 100;
    return '${temp.ceil()}%';
  }

  @override
  Widget build(BuildContext context) {
    if (!isDiscount()) {
      return Text(priceToString(price), style: priceStyle);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(priceToString(originalPrice),
            style: originalPriceStyle.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationColor: originalPriceStyle.color,
            )),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              calcDiscountRateString(),
              style: priceStyle.copyWith(color: DS.color.point500),
            ),
            DS.space.hXTiny,
            Text(priceToString(price), style: priceStyle),
          ],
        )
      ],
    );
  }
}

class StoreItemPriceOld extends StatelessWidget {
  final int originalPrice;
  final int price;
  final bool isTitle;
  final bool alignRight;
  final bool withDiscountText;

  const StoreItemPriceOld({
    super.key,
    required this.originalPrice,
    required this.price,
    this.isTitle = false,
    this.withDiscountText = true,
    this.alignRight = false,
  });

  bool isDiscount() {
    return price < originalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        StoreItemOriginalPriceText(
          isTitle: isTitle,
          withDiscountText: withDiscountText,
          originalPrice: originalPrice,
          price: price,
          mainAxisAlignment:
              alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        ).orEmpty(isDiscount()),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StoreItemPriceDiscountRateText(
              isTitle: isTitle,
              originalPrice: originalPrice,
              price: price,
            ).orEmpty(isDiscount()),
            isTitle
                ? DS.space.hTiny.orEmpty(isDiscount())
                : DS.space.hXTiny.orEmpty(isDiscount()),
            StoreItemPriceText(price: price, isTitle: isTitle)
          ],
        )
      ],
    );
  }
}

class ItemSaleRemainDurationText extends StatefulWidget {
  final DateTime salesWillBeEndedAt;
  final bool useDDay;
  final TextStyle? textStyle;

  const ItemSaleRemainDurationText(
      {super.key,
      required this.salesWillBeEndedAt,
      this.useDDay = false,
      this.textStyle});

  @override
  State<ItemSaleRemainDurationText> createState() =>
      _ItemSaleRemainDurationTextState();
}

class _ItemSaleRemainDurationTextState
    extends State<ItemSaleRemainDurationText> {
  int sec = 0;
  Timer? timer;
  late Duration diff;

  late final style = widget.textStyle ??
      DS.textStyle.caption1.copyWith(color: DS.color.background600);

  @override
  void didUpdateWidget(covariant ItemSaleRemainDurationText oldWidget) {
    if (widget.salesWillBeEndedAt != oldWidget.salesWillBeEndedAt) {
      init();
    }
    super.didUpdateWidget(oldWidget);
  }

  void timerCallback() {
    setState(() {
      sec++;
    });
  }

  void init() {
    sec = 0;
    diff = widget.salesWillBeEndedAt.difference(DateTime.now());
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCallback();
    });
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
    final remainSec = diff.inSeconds - sec;
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

  Widget _buildRemainDuration() {
    if (widget.useDDay) {
      return Text('D-${diff.inDays}', style: style);
    }
    return Text(calcRemainSaleDuration(), style: style);
  }

  Widget _buildSaleEndText() {
    return Text(DS.text.saleEnd, style: style);
  }

  @override
  Widget build(BuildContext context) {
    final remainHours = diff.inHours;
    if (remainHours > 9999) {
      return const SizedBox();
    }
    if (remainHours < 0) {
      return _buildSaleEndText();
    }
    return _buildRemainDuration();
  }
}

class StoreItemSellTypeBadge extends StatelessWidget {
  final String sellType;
  final TextStyle? textStyle;

  const StoreItemSellTypeBadge({
    super.key,
    required this.sellType,
    this.textStyle,
  });

  Widget _buildText(String text) {
    final style = textStyle ?? DS.textStyle.caption1.semiBold.h14.s900;
    return Text(text, style: style);
  }

  Widget _getSellTypeImage(String sellType) {
    final style = textStyle ?? DS.textStyle.caption1.semiBold.h14.s900;
    if (sellType == DS.text.sellTypeTimeLimit) {
      return DS.image.timeLimit(size: style.fontSize, color: style.color);
    } else if (sellType == DS.text.sellTypeQuantityLimit) {
      return DS.image.quantityLimit(size: style.fontSize, color: style.color);
    } else if (sellType == DS.text.groupBuying) {
      return DS.image.groupBuying(size: style.fontSize, color: style.color);
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sellType == DS.text.sellTypeVoucher) {
      return const SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        color: DS.color.background100,
        borderRadius: BorderRadius.circular(DS.space.xxTiny),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xxTiny,
        horizontal: DS.space.xTiny,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getSellTypeImage(sellType),
          DS.space.hXXTiny,
          _buildText(sellType),
        ],
      ),
    );
  }
}

class StoreItemPriceText extends StatelessWidget {
  final int price;
  final bool isTitle;

  const StoreItemPriceText(
      {super.key, required this.price, this.isTitle = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      price.format(DS.text.priceFormat),
      style: isTitle
          ? DS.textStyle.paragraph2.b800.semiBold.h14
          : DS.textStyle.paragraph3.b800.semiBold.h14,
    );
  }
}

class StoreItemQuantityPicker extends StatelessWidget {
  final int quantity;

  final void Function(int nextQuantity) onQuantityChanged;

  const StoreItemQuantityPicker({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
  });

  void onClickHandler(int addValue) {
    final nextQuantityCandidate = quantity + addValue;
    if (nextQuantityCandidate > 9 || nextQuantityCandidate < 1) return;
    onQuantityChanged.call(nextQuantityCandidate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DS.color.background300),
        borderRadius: BorderRadius.circular(DS.space.xTiny),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TEonTap(
              child: Padding(
                padding: EdgeInsets.all(DS.space.xTiny),
                child: const Icon(Icons.remove),
              ),
              onTap: () => onClickHandler(-1),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: DS.color.background300),
                  right: BorderSide(color: DS.color.background300),
                ),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: DS.space.medium,
                child: Text(
                  quantity.toString(),
                  style: DS.textStyle.paragraph3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TEonTap(
              child: Padding(
                padding: EdgeInsets.all(DS.space.xTiny),
                child: const Icon(Icons.add),
              ),
              onTap: () => onClickHandler(1),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreItemImage extends GetView<LikeController<IStoreItemRepository>> {
  final String imageUrl;
  final double width;
  final int itemId;
  final double borderRadius;
  final double ratio;
  final String sellType;
  final String? curatorProfileImageUrl;
  final String? curatorNickname;
  final bool withCuratorInfo;
  final bool withSellTypeBadge;

  const StoreItemImage._({
    required this.imageUrl,
    required this.width,
    required this.itemId,
    required this.borderRadius,
    required this.sellType,
    this.curatorProfileImageUrl,
    this.curatorNickname,
    this.withCuratorInfo = true,
    this.withSellTypeBadge = true,
    this.ratio = 3 / 4,
  });

  factory StoreItemImage.fromItemSimple(
    ItemSimple item, {
    required double width,
    double ratio = 3 / 4,
    required double borderRadius,
    bool withCuratorInfo = true,
    bool withSellTypeBadge = true,
  }) {
    return StoreItemImage._(
      imageUrl: item.imageUrl,
      width: width,
      itemId: item.id,
      borderRadius: borderRadius,
      sellType: item.sellType,
      curatorProfileImageUrl: item.curatorProfileImageUrl,
      curatorNickname: item.curatorNickname,
      withCuratorInfo: withCuratorInfo,
      withSellTypeBadge: withSellTypeBadge,
      ratio: ratio,
    );
  }

  Widget _buildCurationBadge() {
    if (curatorNickname == null || curatorProfileImageUrl == null) {
      return const SizedBox();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xxTiny,
        horizontal: DS.space.xTiny,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DS.space.xxTiny),
        color: DS.color.secondary900,
      ),
      child: Text(
        DS.text.curation,
        style: DS.textStyle.caption2.b000.h14.semiBold,
      ),
    );
  }

  Widget _buildDangolPickOverlay() {
    if (curatorNickname == null || curatorProfileImageUrl == null) {
      return const SizedBox();
    }

    return TEGradientContainer(
      height: DS.space.medium,
      borderRadius: borderRadius,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              TECacheImage(
                src: curatorProfileImageUrl!,
                width: DS.space.base,
                ratio: 1 / 1,
                borderRadius: 300,
              ),
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: DS.color.background000),
                  borderRadius: BorderRadius.circular(300),
                ),
              )),
            ],
          ),
          DS.space.hXTiny,
          Flexible(
            child: Text(
              curatorNickname!,
              style: DS.textStyle.caption2.semiBold.b000,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            DS.text.dangolPickCuratorNicknameFormat,
            style: DS.textStyle.caption2.semiBold.b000,
          ),
          DS.space.hXXTiny,
          _buildCurationBadge(),
        ],
      ).paddingHorizontal(DS.space.tiny),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TECacheImage(
          src: imageUrl,
          width: width,
          ratio: ratio,
          borderRadius: borderRadius,
        ),
        Positioned(
          top: withCuratorInfo ? 0 : DS.space.xxTiny,
          left: withCuratorInfo ? 0 : DS.space.xxTiny,
          right: withCuratorInfo ? 0 : null,
          child: Visibility(
            visible:
                (curatorProfileImageUrl != null) && (curatorNickname != null),
            child: withCuratorInfo
                ? _buildDangolPickOverlay()
                : _buildCurationBadge(),
          ),
        ),
        Positioned(
          left: DS.space.tiny,
          bottom: DS.space.xTiny,
          child: Visibility(
            visible: withSellTypeBadge,
            child: StoreItemSellTypeBadge(sellType: sellType),
          ),
        ),
      ],
    );
  }
}

class StoreItemNameText extends StatelessWidget {
  final String name;
  final TextAlign? textAlign;

  const StoreItemNameText({super.key, required this.name, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: textAlign,
      style: DS.textStyle.paragraph3.copyWith(color: DS.color.background700),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class StoreItemColumnCard extends StatelessWidget {
  final ItemSimple item;
  final void Function(int itemId, {ItemSimple? item}) onTap;
  final double borderRadius;
  final double? imageWidth;

  static const infoBoxHeight = 99;
  static const imageRatio = 3 / 4;

  static double calcTotalHeight(double imageWidth) {
    return (imageWidth / imageRatio) + infoBoxHeight;
  }

  const StoreItemColumnCard(
      {super.key,
      required this.item,
      required this.onTap,
      this.borderRadius = 0.0,
      this.imageWidth});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = this.imageWidth ??
        (screenWidth -
                (AppWidget.horizontalPadding * 2) -
                (AppWidget.itemHorizontalSpace)) /
            2;

    return TEonTap(
      onTap: () => onTap(item.id, item: item),
      child: SizedBox(
        width: imageWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreItemImage.fromItemSimple(
              item,
              width: imageWidth,
              borderRadius: borderRadius,
              ratio: imageRatio,
            ),
            DS.space.vTiny,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TELeftRightText(
                        item.storeName,
                        DistanceText(
                          point: item.storeLocation,
                          style: DS.textStyle.caption2.b500.h14,
                          withDivider: true,
                        ),
                        useDefaultDivider: false,
                      ),
                      Text(
                        item.name,
                        style: DS.textStyle.paragraph3.bold.b800.h14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                DS.space.hTiny,
                Like<IStoreItemRepository>.base(item.id),
              ],
            ).paddingHorizontal(DS.space.tiny),
            DS.space.vXSmall,
            StoreItemPrice(
              originalPrice: item.originalPrice,
              price: item.price,
              originalPriceStyle: DS.textStyle.caption1.b500.h14,
              priceStyle: DS.textStyle.paragraph3.semiBold.b800.h14,
            ).paddingHorizontal(DS.space.tiny),
          ],
        ),
      ),
    );
  }
}

class StoreItemList extends GetView<IReact> {
  final Widget? notFound;
  final List<ItemSimple> items;
  final double borderRadius;

  const StoreItemList(
      {super.key, required this.items, this.borderRadius = 0.0, this.notFound});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && notFound != null) {
      return notFound!;
    }
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(left: AppWidget.horizontalPadding),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => Padding(
                  padding: EdgeInsets.only(
                      right: items.indexOf(item) % 2 == 1
                          ? AppWidget.horizontalPadding
                          : AppWidget.itemHorizontalSpace),
                  child: StoreItemColumnCard(
                    borderRadius: borderRadius,
                    item: item,
                    onTap: controller.toStoreItemDetail,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class StoreItemInSaleIcon extends StatelessWidget {
  const StoreItemInSaleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DS.color.primary500,
        borderRadius: BorderRadius.circular(DS.space.xxTiny),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xxTiny,
        horizontal: DS.space.xTiny,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DS.image
              .forkAndKnife(color: DS.color.primary700, size: DS.space.xSmall),
          DS.space.hXXTiny,
          Text(DS.text.inSale, style: DS.textStyle.caption2.h14.p700.semiBold),
        ],
      ),
    );
  }
}

class _NoticeText extends StatelessWidget {
  final String title;
  final String content;
  const _NoticeText(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: DS.textStyle.caption1.b700.h14),
        Text(content, style: DS.textStyle.caption1.b500.h14)
      ],
    );
  }
}

class StoreItemNotice extends StatelessWidget {
  final String title;
  final List<String> titles;
  final List<String> contents;

  const StoreItemNotice(this.title,
      {super.key, required this.titles, required this.contents})
      : assert(titles.length == contents.length);

  factory StoreItemNotice.refund() {
    return StoreItemNotice(
      DS.text.itemRefundNotice,
      titles: [
        DS.text.itemRefundNoticeRefundMethodTitle,
        DS.text.itemRefundNoticeWithdrawalTitle,
        DS.text.itemRefundNoticeAfterExpiredTitle
      ],
      contents: [
        DS.text.itemRefundNoticeRefundMethodContent,
        DS.text.itemRefundNoticeWithdrawalContent,
        DS.text.itemRefundNoticeAfterExpiredContent
      ],
    );
  }

  factory StoreItemNotice.warning() {
    return StoreItemNotice(
      DS.text.itemPurchaseWarning,
      titles: [
        DS.text.itemPurchaseWarningRefundAmountTitle,
        DS.text.itemPurchaseWarningPrivacyTitle,
        DS.text.itemPurchaseWarningUsageLimitationTitle,
        DS.text.itemPurchaseWarningLawInfoTitle,
      ],
      contents: [
        DS.text.itemPurchaseWarningRefundAmountContent,
        DS.text.itemPurchaseWarningPrivacyContent,
        DS.text.itemPurchaseWarningUsageLimitationContent,
        DS.text.itemPurchaseWarningLawInfoContent,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TEExpandable(
      header: Container(
        height: DS.space.large,
        alignment: Alignment.centerLeft,
        child: Text(title, style: DS.textStyle.paragraph2.b800),
      ),
      spaceHeaderAndContent: 0.0,
      content: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: DS.space.tiny),
        itemBuilder: (_, idx) => _NoticeText(titles[idx], contents[idx]),
        separatorBuilder: (_, __) => DS.space.vBase,
        itemCount: titles.length,
      ),
    );
  }
}
