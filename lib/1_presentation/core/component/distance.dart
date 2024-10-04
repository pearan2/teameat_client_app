import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/location_controller.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';

class DistanceWithIcon extends GetView<LocationController> {
  final Point point;

  const DistanceWithIcon({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final basePoint = c.data?.toPoint();
      if (basePoint == null) {
        return const SizedBox();
      }
      final kilo = basePoint.distanceKilo(point);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: DS.space.xTiny, horizontal: DS.space.tiny),
              height: DS.space.base,
              decoration: BoxDecoration(
                color: DS.color.primary600,
                borderRadius: BorderRadius.circular(300),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me_outlined,
                    size: DS.space.small,
                    color: DS.color.background000,
                  ),
                  DS.space.hXXTiny,
                  Text(
                    kilo < 1
                        ? (kilo * 1000).format(DS.text.distanceMeterFormat)
                        : kilo.format(DS.text.distanceKiloFormat),
                    style: DS.textStyle.caption1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: DS.color.background000,
                    ),
                  ),
                ],
              )),
        ],
      );
    });
  }
}

class DistanceText extends GetView<LocationController> {
  final Point point;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final bool withDivider;

  const DistanceText(
      {super.key,
      required this.point,
      this.style,
      this.padding,
      this.withDivider = false});

  Widget _defaultDivider() {
    return Container(
      width: 1,
      height: DS.space.tiny,
      color: style?.color ?? DS.color.background500,
    ).paddingSymmetric(horizontal: DS.space.xTiny);
  }

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? DS.textStyle.caption1.b700.semiBold.h14;

    return Obx(() {
      final basePoint = c.data?.toPoint();
      if (basePoint == null) {
        return const SizedBox();
      }
      final kilo = basePoint.distanceKilo(point);

      return Padding(
        padding: padding ?? const EdgeInsets.all(0.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _defaultDivider().orEmpty(withDivider),
            Text(
              kilo < 1
                  ? (kilo * 1000).format(DS.text.distanceMeterFormat)
                  : kilo.format(DS.text.distanceKiloFormat),
              style: style,
            ),
          ],
        ),
      );
    });
  }
}
