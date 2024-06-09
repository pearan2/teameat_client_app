import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/location_controller.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/get.dart';

class Distance extends GetView<LocationController> {
  final Point point;

  const Distance({super.key, required this.point});

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
                color: DS.color.primary500,
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
                    kilo.format(DS.text.distanceFormat),
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
