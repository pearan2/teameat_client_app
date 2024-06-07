import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

Future<void> showTEBottomSheet(Widget child, {double padding = 20.0}) async {
  return Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: padding,
          left: padding,
          right: padding,
          bottom: GetPlatform.isIOS ? padding : 0.0,
        ),
        decoration: BoxDecoration(
          color: DS.color.background000,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(DS.space.xBase),
            topRight: Radius.circular(DS.space.xBase),
          ),
        ),
        child: child,
      ),
      isScrollControlled: true);
}
