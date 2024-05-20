import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension.dart';

class ItemPriceDiscountRateText extends StatelessWidget {
  final int originalPrice;
  final int price;
  final bool withPercentage;

  const ItemPriceDiscountRateText({
    super.key,
    this.withPercentage = true,
    required this.originalPrice,
    required this.price,
  });

  String calcDiscountRateString() {
    final temp = (1 - (price / originalPrice)) * 100;
    return '${temp.ceil()}%';
  }

  @override
  Widget build(BuildContext context) {
    if (originalPrice <= price) {
      return const SizedBox();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          originalPrice.format(DS.getText().priceFormat),
          style: DS.getTextStyle().caption1.copyWith(
                color: DS.getColor().background600,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
                decorationColor: DS.getColor().background600,
              ),
        ),
        withPercentage ? DS.getSpace().hXTiny : const SizedBox(),
        withPercentage
            ? Text(
                calcDiscountRateString(),
                style: DS.getTextStyle().caption2.copyWith(
                      color: DS.getColor().secondary500,
                      fontWeight: FontWeight.bold,
                    ),
              )
            : const SizedBox()
      ],
    );
  }
}

class ItemSaleRemainDurationText extends StatefulWidget {
  final DateTime salesWillBeEndedAt;

  const ItemSaleRemainDurationText(
      {super.key, required this.salesWillBeEndedAt});

  @override
  State<ItemSaleRemainDurationText> createState() =>
      _ItemSaleRemainDurationTextState();
}

class _ItemSaleRemainDurationTextState
    extends State<ItemSaleRemainDurationText> {
  int sec = 0;
  Timer? timer;
  late final diff = widget.salesWillBeEndedAt.difference(DateTime.now());
  void timerCallback() {
    setState(() {
      sec++;
    });
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCallback();
    });
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

  @override
  Widget build(BuildContext context) {
    final remainHours = diff.inHours;
    if (remainHours > 100) {
      return const SizedBox();
    }
    return Container(
      color: DS.getColor().secondary500,
      padding: EdgeInsets.all(DS.getSpace().xxTiny),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DS.getSpace().hXXTiny,
          Icon(
            Icons.timer_sharp,
            color: DS.getColor().background000,
            size: DS.getSpace().xSmall,
          ),
          DS.getSpace().hXTiny,
          SizedBox(
            width: DS.getSpace().medium + DS.getSpace().base,
            child: Text(
              calcRemainSaleDuration(),
              style: DS.getTextStyle().caption1.copyWith(
                    color: DS.getColor().background000,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemLike extends StatefulWidget {
  final ItemSimple item;
  final bool isLike;

  const ItemLike({super.key, required this.item, this.isLike = false});

  @override
  State<ItemLike> createState() => _ItemLikeState();
}

class _ItemLikeState extends State<ItemLike> {
  late bool isLike = widget.isLike;

  Widget _buildLikeWidget() {
    return Icon(
      key: const ValueKey(true),
      Icons.favorite,
      size: DS.getSpace().base,
      color: DS.getColor().secondary400,
    );
  }

  Widget _buildUnLikeWidget() {
    return Icon(
      key: const ValueKey(false),
      Icons.favorite_outline,
      size: DS.getSpace().base,
      color: DS.getColor().background000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => setState(() => isLike = !isLike),
      child: AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          duration: const Duration(milliseconds: 200),
          child: isLike ? _buildLikeWidget() : _buildUnLikeWidget()),
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
        CarouselSlider(
          items: item.imageUrls
              .map((e) => PageLoadingWrapper(
                    child: TENetworkImage(url: e, width: width),
                  ))
              .toList(),
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            aspectRatio: 1.0,
          ),
        ),
        Positioned(
          left: 0,
          bottom: DS.getSpace().xTiny,
          child: PageLoadingWrapper(
            child: ItemSaleRemainDurationText(
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
    return Text(
      sellType,
      style: DS.getTextStyle().paragraph3.copyWith(
            color: DS.getColor().primary400,
            fontWeight: FontWeight.bold,
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
      price.format(DS.getText().priceFormat),
      style: isTitle
          ? DS.getTextStyle().title1
          : DS.getTextStyle().paragraph1.copyWith(fontWeight: FontWeight.bold),
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
    if (quantity > 99 || quantity < 1) return;
    onQuantityChanged.call(nextQuantityCandidate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DS.getColor().background300),
        borderRadius: BorderRadius.circular(DS.getSpace().xTiny),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TEonTap(
              child: Padding(
                padding: EdgeInsets.all(DS.getSpace().xTiny),
                child: const Icon(Icons.remove),
              ),
              onTap: () => onClickHandler(-1),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: DS.getColor().background300),
                  right: BorderSide(color: DS.getColor().background300),
                ),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: DS.getSpace().medium,
                child: Text(
                  quantity.toString(),
                  style: DS.getTextStyle().paragraph3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TEonTap(
              child: Padding(
                padding: EdgeInsets.all(DS.getSpace().xTiny),
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
    final imageWidth = MediaQuery.of(context).size.width / 2;

    return TEonTap(
      onTap: () => onTap(item.id),
      child: SizedBox(
        width: imageWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TENetworkImage(
              url: item.imageUrl,
              width: imageWidth,
              borderRadius: borderRadius,
            ),
            DS.getSpace().vTiny,
            Text(
              item.name,
              style: DS
                  .getTextStyle()
                  .paragraph2
                  .copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            DS.getSpace().vTiny,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemSaleRemainDurationText(
                    salesWillBeEndedAt: item.salesWillBeEndedAt),
                StoreItemSellTypeText(sellType: item.sellType)
              ],
            ),
            DS.getSpace().vTiny,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemPriceDiscountRateText(
                  price: item.price,
                  originalPrice: item.originalPrice,
                ),
                StoreItemPriceText(price: item.price)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StoreItemRowCard extends StatelessWidget {
  final ItemSimple item;
  final void Function(int itemId) onTap;

  const StoreItemRowCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width / 2.5;

    return TEonTap(
      onTap: () => onTap(item.id),
      child: SizedBox(
        height: imageWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TENetworkImage(
              url: item.imageUrl,
              width: imageWidth,
              borderRadius: DS.getSpace().small,
            ),
            DS.getSpace().hBase,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: DS
                        .getTextStyle()
                        .paragraph2
                        .copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StoreItemSellTypeText(sellType: item.sellType),
                      DS.getSpace().vTiny,
                      StoreItemPriceText(price: item.price),
                      DS.getSpace().vTiny,
                      ItemPriceDiscountRateText(
                        price: item.price,
                        originalPrice: item.originalPrice,
                      ),
                      DS.getSpace().vTiny,
                      ItemSaleRemainDurationText(
                          salesWillBeEndedAt: item.salesWillBeEndedAt),
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
  final List<ItemSimple> items;
  final double borderRadius;

  const StoreItemList(
      {super.key, required this.items, this.borderRadius = 0.0});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: DS.getSpace().small),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
                  padding: EdgeInsets.only(right: DS.getSpace().small),
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
