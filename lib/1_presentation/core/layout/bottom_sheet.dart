import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

Future<void> showTEBottomSheet(Widget child) async {
  return Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: DS.getSpace().xBase,
          left: DS.getSpace().xBase,
          right: DS.getSpace().xBase,
          bottom: GetPlatform.isIOS ? DS.getSpace().xBase : 0.0,
        ),
        decoration: BoxDecoration(
          color: DS.getColor().background000,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(DS.getSpace().xBase),
            topRight: Radius.circular(DS.getSpace().xBase),
          ),
        ),
        child: child,
      ),
      isScrollControlled: true);
}
