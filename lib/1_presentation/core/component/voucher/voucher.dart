import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';
import 'package:teameat/99_util/extension.dart';

class VoucherDDay extends StatelessWidget {
  final DateTime willBeExpiredAt;

  const VoucherDDay({
    super.key,
    required this.willBeExpiredAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DS.getColor().background600,
      padding: EdgeInsets.symmetric(
        vertical: DS.getSpace().xxTiny,
        horizontal: DS.getSpace().xTiny,
      ),
      child: Text(
        willBeExpiredAt.dDay(),
        style: DS.getTextStyle().paragraph3.copyWith(
              color: DS.getColor().background000,
            ),
      ),
    );
  }
}

class VoucherBlur extends StatelessWidget {
  const VoucherBlur({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: DS.getColor().background600.withOpacity(0.5),
    );
  }
}

class VoucherUsedMark extends StatelessWidget {
  const VoucherUsedMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: DS.getSpace().xTiny, horizontal: DS.getSpace().xSmall),
        decoration: BoxDecoration(
            border: Border.all(
              color: DS.getColor().secondary500,
              width: DS.getSpace().xxTiny,
            ),
            borderRadius: BorderRadius.circular(DS.getSpace().tiny)),
        child: Text(
          DS.getText().allUsed,
          style: DS.getTextStyle().paragraph1.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: DS.getColor().secondary500,
              ),
        ),
      ),
    );
  }
}

class VoucherQuantity extends StatelessWidget {
  final int quantity;

  const VoucherQuantity({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DS.getColor().primary500,
      padding: EdgeInsets.symmetric(
        vertical: DS.getSpace().xxTiny,
        horizontal: DS.getSpace().xTiny,
      ),
      child: Text(
        quantity.format(DS.getText().voucherRemainQuantityFormat),
        style: DS.getTextStyle().caption1.copyWith(
              color: DS.getColor().background000,
            ),
      ),
    );
  }
}

class VoucherImage extends StatelessWidget {
  final double stackVerticalOffset;
  final double borderRadius;

  final DateTime willBeExpiredAt;
  final int quantity;
  final List<String> imageUrls;

  const VoucherImage({
    super.key,
    required this.willBeExpiredAt,
    required this.quantity,
    required this.imageUrls,
    this.stackVerticalOffset = 0.0,
    this.borderRadius = 0.0,
  }) : assert(imageUrls.length > 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageUrls.length == 1
            ? TENetworkImage(
                url: imageUrls.first,
                borderRadius: borderRadius,
              )
            : CarouselSlider(
                items: imageUrls
                    .map((e) => TENetworkImage(
                          url: e,
                          borderRadius: borderRadius,
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  aspectRatio: 1.0,
                ),
              ),
        Visibility(
          visible: isUsable(willBeExpiredAt, quantity),
          child: Positioned(
              left: 0,
              top: stackVerticalOffset,
              child: VoucherDDay(
                willBeExpiredAt: willBeExpiredAt,
              )),
        ),
        Visibility(
          visible: !isUsable(willBeExpiredAt, quantity),
          child: Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: const VoucherBlur()),
          ),
        ),
        Visibility(
          visible: isAllUsed(
            quantity,
          ),
          child: const Positioned.fill(child: VoucherUsedMark()),
        ),
        Visibility(
          visible: isUsable(willBeExpiredAt, quantity),
          child: Positioned(
            bottom: stackVerticalOffset,
            right: 0,
            child: VoucherQuantity(quantity: quantity),
          ),
        )
      ],
    );
  }
}