import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/99_util/extension/text_style.dart';

const bottomSheetDefaultBarHeight = 24.0;
const bottomSheetDefaultCloseHeight = 32.0;

Future<void> showTEBottomSheet(Widget child,
    {double padding = 20.0,
    bool withBar = false,
    bool withClose = false}) async {
  return Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: withBar ? 0 : padding,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            withBar ? const _TEBottomSheetTopBar() : const SizedBox(),
            child,
            withClose ? const _TEBottomSheetCloser() : const SizedBox(),
          ],
        ),
      ),
      isScrollControlled: true);
}

class _TEBottomSheetTopBar extends StatelessWidget {
  const _TEBottomSheetTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomSheetDefaultBarHeight,
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        width: DS.space.large + DS.space.xSmall,
        height: DS.space.xTiny,
        decoration: BoxDecoration(
          color: DS.color.background100,
          borderRadius: BorderRadius.circular(
            DS.space.xTiny,
          ),
        ),
      ),
    );
  }
}

class _TEBottomSheetCloser extends StatelessWidget {
  const _TEBottomSheetCloser();

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: Get.find<IReact>().back,
      child: Container(
        width: double.infinity,
        height: bottomSheetDefaultCloseHeight,
        alignment: Alignment.center,
        child:
            Text(DS.text.close, style: DS.textStyle.caption1.semiBold.b500.h14),
      ),
    );
  }
}
