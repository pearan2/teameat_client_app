import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/main.dart';

class StoreItemOriginalPriceText extends StatelessWidget {
  final int originalPrice;
  final int price;

  const StoreItemOriginalPriceText(
      {super.key, required this.originalPrice, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      originalPrice.format(DS.text.priceFormat),
      style: DS.textStyle.caption1.copyWith(
        color: DS.color.background500,
        fontWeight: FontWeight.w300, // demi-light
        decoration: TextDecoration.lineThrough,
        decorationColor: DS.color.background500,
      ),
    );
  }
}

class StoreItemPriceDiscountRateText extends StatelessWidget {
  final int originalPrice;
  final int price;

  const StoreItemPriceDiscountRateText({
    super.key,
    required this.originalPrice,
    required this.price,
  });

  String calcDiscountRateString() {
    final temp = (1 - (price / originalPrice)) * 100;
    return '${temp.ceil()}%';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      calcDiscountRateString(),
      style: DS.textStyle.paragraph3.copyWith(
        color: DS.color.secondary700,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class StoreItemPrice extends StatelessWidget {
  final int originalPrice;
  final int price;
  final bool isTitle;
  final CrossAxisAlignment? crossAxisAlignment;

  const StoreItemPrice({
    super.key,
    required this.originalPrice,
    required this.price,
    this.isTitle = false,
    this.crossAxisAlignment,
  });

  bool isDiscount() {
    return price < originalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        isDiscount()
            ? StoreItemOriginalPriceText(
                originalPrice: originalPrice, price: price)
            : const SizedBox(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isDiscount()
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: DS.space.xTiny),
                    child: StoreItemPriceDiscountRateText(
                        originalPrice: originalPrice, price: price),
                  )
                : const SizedBox(),
            StoreItemPriceText(price: price, isTitle: isTitle)
          ],
        )
      ],
    );
  }
}

class ItemSaleRemainDurationText extends StatefulWidget {
  final DateTime salesWillBeEndedAt;
  final double borderRadius;

  const ItemSaleRemainDurationText(
      {super.key, required this.salesWillBeEndedAt, this.borderRadius = 0.0});

  @override
  State<ItemSaleRemainDurationText> createState() =>
      _ItemSaleRemainDurationTextState();
}

class _ItemSaleRemainDurationTextState
    extends State<ItemSaleRemainDurationText> {
  int sec = 0;
  Timer? timer;
  late Duration diff;

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
    return SizedBox(
      width: DS.space.medium + DS.space.base,
      child: Text(
        calcRemainSaleDuration(),
        style: DS.textStyle.caption2.copyWith(
          color: DS.color.background000,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSaleEndText() {
    return Text(
      DS.text.saleEnd,
      style: DS.textStyle.caption2.copyWith(
        color: DS.color.background000,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      height: DS.space.base,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: DS.color.background800.withOpacity(0.3),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius),
              topRight: Radius.circular(widget.borderRadius))),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final remainHours = diff.inHours;
    if (remainHours > 99) {
      return const SizedBox();
    }
    if (remainHours < 0) {
      return _buildContainer(_buildSaleEndText());
    }
    return _buildContainer(_buildRemainDuration());
  }
}

class ItemLike extends GetView<LikeController<IStoreItemRepository>> {
  final int itemId;

  const ItemLike({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLike(itemId)
          ? DS.image.iconLikeClicked
          : DS.image.iconLike,
    );
  }
}

class StoreItemImageCarousel extends StatelessWidget {
  final double width;
  final double height;

  final ItemDetail item;

  const StoreItemImageCarousel({
    super.key,
    required this.width,
    required this.height,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        TEImageCarousel(width: width, imageUrls: item.imageUrls),
        Positioned(
          left: 0,
          bottom: DS.space.xTiny,
          child: PageLoadingWrapper(
            child: ItemSaleRemainDurationText(
                key: ValueKey(item.id),
                salesWillBeEndedAt: item.salesWillBeEndedAt),
          ),
        )
      ],
    );
  }
}

class StoreItemSellTypeText extends StatelessWidget {
  final String sellType;

  const StoreItemSellTypeText({super.key, required this.sellType});

  @override
  Widget build(BuildContext context) {
    if (sellType == DS.text.sellTypeVoucher) {
      return const SizedBox();
    }
    return Container(
      color: DS.color.secondary700,
      padding: EdgeInsets.all(DS.space.xxTiny),
      child: Text(
        sellType,
        style: DS.textStyle.caption2.copyWith(
          color: DS.color.background000,
          fontWeight: FontWeight.bold,
        ),
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
          ? DS.textStyle.title1
          : DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
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
  final DateTime salesWillBeEndedAt;
  final double ratio;

  const StoreItemImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.itemId,
    required this.borderRadius,
    required this.salesWillBeEndedAt,
    this.ratio = 3 / 4,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TENetworkCacheImage(
          url: imageUrl,
          width: width,
          ratio: ratio,
          borderRadius: borderRadius,
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ItemSaleRemainDurationText(
              key: ValueKey(itemId),
              salesWillBeEndedAt: salesWillBeEndedAt,
              borderRadius: borderRadius,
            )),
        Positioned(
          bottom: 0,
          right: 0,
          child: TEonTap(
            onTap: () => controller.toggleLike(itemId),
            child: Padding(
              padding: EdgeInsets.all(DS.space.xSmall),
              child: ItemLike(itemId: itemId),
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
      style: DS.textStyle.paragraph3
          .copyWith(fontWeight: FontWeight.w600, color: DS.color.background600),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
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
              imageUrl: item.imageUrl,
              width: imageWidth,
              itemId: item.id,
              borderRadius: borderRadius,
              salesWillBeEndedAt: item.salesWillBeEndedAt,
            ),
            DS.space.vXTiny,
            StoreItemNameText(name: item.name),
            DS.space.vXTiny,
            StoreItemSellTypeText(sellType: item.sellType),
            DS.space.vXTiny,
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
              salesWillBeEndedAt: item.salesWillBeEndedAt,
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
                      StoreItemSellTypeText(sellType: item.sellType),
                      DS.space.vTiny,
                      StoreItemPrice(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
