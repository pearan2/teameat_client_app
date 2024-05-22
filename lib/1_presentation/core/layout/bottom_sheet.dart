import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

Future<void> showTEBottomSheet(Widget child) async {
  return Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: DS.space.xBase,
          left: DS.space.xBase,
          right: DS.space.xBase,
          bottom: GetPlatform.isIOS ? DS.space.xBase : 0.0,
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
