import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class StoreItemOriginalPriceText extends StatelessWidget {
  final int originalPrice;
  final int price;
  final MainAxisAlignment? mainAxisAlignment;
  final TextStyle? style;
  const StoreItemOriginalPriceText(
      {super.key,
      required this.originalPrice,
      required this.price,
      this.style,
      this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? DS.textStyle.caption1;

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          DS.text.discountPrice,
          style: style.copyWith(
              color: DS.color.point500, fontWeight: FontWeight.w600),
        ),
        DS.space.hXTiny,
        Text(
          originalPrice.format(DS.text.priceFormat),
          style: style.copyWith(
            color: DS.color.background400,
            decoration: TextDecoration.lineThrough,
            decorationColor: DS.color.background400,
          ),
        ),
      ],
    );
  }
}

class StoreItemPriceDiscountRateText extends StatelessWidget {
  final int originalPrice;
  final int price;
  final TextStyle? style;

  const StoreItemPriceDiscountRateText({
    super.key,
    required this.originalPrice,
    this.style,
    required this.price,
  });

  String calcDiscountRateString() {
    final temp = (1 - (price / originalPrice)) * 100;
    return '${temp.ceil()}%';
  }

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? DS.textStyle.paragraph3;
    return Text(
      calcDiscountRateString(),
      style: style.copyWith(
        color: DS.color.point500,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class StoreItemPrice extends StatelessWidget {
  final int originalPrice;
  final int price;
  final bool isTitle;
  final bool alignRight;

  const StoreItemPrice({
    super.key,
    required this.originalPrice,
    required this.price,
    this.isTitle = false,
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
        isDiscount()
            ? StoreItemOriginalPriceText(
                style: isTitle
                    ? DS.textStyle.paragraph2
                        .copyWith(fontWeight: FontWeight.w600)
                    : null,
                originalPrice: originalPrice,
                price: price,
                mainAxisAlignment: alignRight
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
              )
            : const SizedBox(),
        isDiscount() ? DS.space.vXTiny : const SizedBox(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isDiscount()
                ? StoreItemPriceDiscountRateText(
                    style: isTitle
                        ? DS.textStyle.paragraph2
                            .copyWith(fontWeight: FontWeight.w600)
                        : null,
                    originalPrice: originalPrice,
                    price: price,
                  )
                : const SizedBox(),
            isDiscount() ? DS.space.hXTiny : const SizedBox(),
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

class ItemLike extends GetView<LikeController<IStoreItemRepository>> {
  final int itemId;
  final Widget liked;
  final Widget base;

  const ItemLike({
    super.key,
    required this.itemId,
    required this.liked,
    required this.base,
  });

  factory ItemLike.base(int itemId) {
    return ItemLike(
      itemId: itemId,
      liked: DS.image.iconLikeClicked,
      base: DS.image.iconLike,
    );
  }

  factory ItemLike.border(int itemId) {
    return ItemLike(
      itemId: itemId,
      liked: DS.image.iconLikeBorderClicked,
      base: DS.image.iconLikeBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLike(itemId) ? liked : base,
    );
  }
}

class StoreItemSellType extends StatelessWidget {
  final String sellType;
  final int quantity;
  final DateTime salesWillBeEndedAt;
  final MainAxisAlignment? rowShapeAlignment;
  final bool isColumnShape;
  final bool useDDay;
  final TextStyle? textStyle;

  const StoreItemSellType({
    super.key,
    required this.sellType,
    required this.quantity,
    required this.salesWillBeEndedAt,
    this.rowShapeAlignment,
    this.textStyle,
    this.isColumnShape = false,
    this.useDDay = false,
  });

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DS.color.background400),
        borderRadius: BorderRadius.circular(
          DS.space.xxTiny,
        ),
      ),
      padding: EdgeInsets.all(
        DS.space.tiny,
      ),
      child: child,
    );
  }

  Widget _buildText(String text, Color color) {
    final style = textStyle ?? DS.textStyle.caption1;
    return Text(
      text,
      style: style.copyWith(color: color),
    );
  }

  Widget _buildSellTypeTextAndIcon(String sellType) {
    if (sellType == DS.text.sellTypeTimeLimit) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildText(sellType, DS.color.primary600),
          DS.space.hTiny,
          DS.image.timeLimit
        ],
      );
    } else if (sellType == DS.text.sellTypeQuantityLimit) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildText(sellType, DS.color.primary600),
          DS.space.hTiny,
          DS.image.quantityLimit
        ],
      );
    } else if (sellType == DS.text.groupBuying) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildText(sellType, DS.color.primary600),
          DS.space.hTiny,
          DS.image.mainIconXsm
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildSellTypeContent(String sellType) {
    if (sellType == DS.text.sellTypeTimeLimit) {
      return ItemSaleRemainDurationText(
        salesWillBeEndedAt: salesWillBeEndedAt,
        useDDay: useDDay,
        textStyle: textStyle,
      );
    } else if (sellType == DS.text.sellTypeQuantityLimit) {
      return _buildText(
          quantity.format(DS.text.voucherCountFormat), DS.color.background600);
    } else if (sellType == DS.text.groupBuying) {
      return _buildText(DS.text.ing, DS.color.background600);
    } else {
      return const SizedBox();
    }
  }

  Widget _buildShapeContainer() {
    if (isColumnShape) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSellTypeTextAndIcon(sellType),
          DS.space.vXTiny,
          _buildSellTypeContent(sellType)
        ],
      );
    } else {
      return Row(
          mainAxisAlignment:
              rowShapeAlignment ?? MainAxisAlignment.spaceBetween,
          children: [
            _buildSellTypeTextAndIcon(sellType),
            _buildSellTypeContent(sellType)
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sellType == DS.text.sellTypeVoucher) {
      return const SizedBox();
    }
    return _buildContainer(_buildShapeContainer());
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
          ? DS.textStyle.title1
          : DS.textStyle.paragraph3.copyWith(
              color: DS.color.background800, fontWeight: FontWeight.bold),
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
  final String? curatorProfileImageUrl;

  const StoreItemImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.itemId,
    required this.borderRadius,
    this.curatorProfileImageUrl,
    this.ratio = 3 / 4,
  });

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
          top: DS.space.tiny,
          left: DS.space.tiny,
          child: Visibility(
            visible: curatorProfileImageUrl != null,
            child: DS.image.dangolPick,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: TEonTap(
            onTap: () => controller.toggleLike(itemId),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DS.space.xSmall,
                vertical: DS.space.xTiny,
              ),
              child: ItemLike.base(itemId),
            ),
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

class StoreItemStoreSimpleRow extends GetView<IReact> {
  final String name;
  final int id;
  final Point location;

  const StoreItemStoreSimpleRow({
    super.key,
    required this.name,
    required this.id,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => c.toStoreDetail(id),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: DS.textStyle.caption1.copyWith(
                      color: DS.color.background500,
                    ),
                  ),
                ),
                DS.space.hXXTiny,
                DS.image.rightArrow,
              ],
            ),
          ),
          DistanceText(point: location),
        ],
      ),
    );
  }
}

class StoreItemColumnCard extends StatelessWidget {
  final ItemSimple item;
  final void Function(int itemId) onTap;
  final double borderRadius;

  const StoreItemColumnCard(
      {super.key,
      required this.item,
      required this.onTap,
      this.borderRadius = 0.0});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = (screenWidth -
            (AppWidget.horizontalPadding * 2) -
            (AppWidget.itemHorizontalSpace)) /
        2;

    return TEonTap(
      onTap: () => onTap(item.id),
      child: SizedBox(
        width: imageWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreItemImage(
              curatorProfileImageUrl: item.curatorProfileImageUrl,
              imageUrl: item.imageUrl,
              width: imageWidth,
              itemId: item.id,
              borderRadius: borderRadius,
            ),
            DS.space.vXTiny,
            StoreItemSellType(
              sellType: item.sellType,
              salesWillBeEndedAt: item.salesWillBeEndedAt,
              quantity: item.quantity,
            ),
            DS.space.vXTiny,
            StoreItemStoreSimpleRow(
              id: item.storeId,
              name: item.storeName,
              location: item.storeLocation,
            ),
            DS.space.vXTiny,
            StoreItemNameText(name: item.name),
            DS.space.vTiny,
            StoreItemPrice(
                originalPrice: item.originalPrice, price: item.price),
          ],
        ),
      ),
    );
  }
}

class StoreItemRowCard extends StatelessWidget {
  final ItemSimple item;
  final double borderRadius;
  final void Function(int itemId) onTap;

  const StoreItemRowCard(
      {super.key,
      required this.item,
      required this.onTap,
      this.borderRadius = 0.0});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = (screenWidth -
            (AppWidget.horizontalPadding * 2) -
            (AppWidget.itemHorizontalSpace)) /
        2;

    return TEonTap(
      onTap: () => onTap(item.id),
      child: SizedBox(
        height: imageWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StoreItemImage(
              imageUrl: item.imageUrl,
              width: imageWidth,
              itemId: item.id,
              ratio: 1 / 1,
              borderRadius: borderRadius,
              curatorProfileImageUrl: item.curatorProfileImageUrl,
            ),
            DS.space.hBase,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StoreItemNameText(
                    name: item.name,
                    textAlign: TextAlign.end,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StoreItemSellType(
                        sellType: item.sellType,
                        salesWillBeEndedAt: item.salesWillBeEndedAt,
                        quantity: item.quantity,
                        isColumnShape: true,
                      ),
                      DS.space.vTiny,
                      StoreItemPrice(
                        alignRight: true,
                        originalPrice: item.originalPrice,
                        price: item.price,
                      )
                    ],
                  )
                ],
              ),
            ),
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
