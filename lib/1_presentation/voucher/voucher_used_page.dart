import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/voucher/voucher_used_page_controller.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/main.dart';

class VoucherUsedPage extends GetView<VoucherUsedPageController> {
  const VoucherUsedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      onPop: (_) => controller.react.toHomeOffAll(),
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.toVoucherOffAll,
        homeOnPressed: controller.react.toHomeOffAll,
        title: DS.text.allUsed,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _VoucherUseMovingBanner(),
            DS.space.vSmall,
            Container(
              height: DS.space.large,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppWidget.horizontalPadding),
              child: Text(
                DS.text.afterVoucherUseNotice,
                style: DS.textStyle.paragraph2.semiBold.b800.h14,
                textAlign: TextAlign.center,
              ),
            ),
            DS.space.vSmall,
            TECacheImage(
              src: controller.voucher.itemImageUrls.first,
              borderRadius: DS.space.xTiny,
            ).withBasePadding,
            DS.space.vXSmall,
            Text(
              controller.voucher.itemName,
              style: DS.textStyle.title2.semiBold.b800.h14,
              textAlign: TextAlign.center,
            ).withBasePadding,
            DS.space.vTiny,
            _VoucherUseQuantityText(controller.usedQuantity),
            DS.space.vSmall,
            Text(DateTime.now().format(DS.text.voucherUseFinishedAtFormat),
                style: DS.textStyle.paragraph2.semiBold.b800.h14),
            DS.space.vXBase,
            TEPrimaryButton(
              text: DS.text.toVoucherInventory,
              onTap: controller.react.toVoucherOffAll,
              fitContentWidth: true,
              contentHorizontalPadding: DS.space.xBase,
            ),
            DS.space.vXSmall,
            const _TimeClock(),
          ],
        ),
      ),
    );
  }
}

class _VoucherUseMovingBanner extends StatelessWidget {
  const _VoucherUseMovingBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DS.space.xBase,
      width: double.infinity,
      color: DS.color.primary700,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => Container(
          height: DS.space.xBase,
          width: DS.space.large,
          alignment: Alignment.centerLeft,
          child: Transform.translate(
            offset: Offset(-DS.space.base, 0),
            child: _PacmanAnimation(width: DS.space.large),
          ),
        ),
        itemCount: 15,
      ),
    );
  }
}

class _PacmanAnimation extends StatefulWidget {
  final double width;
  const _PacmanAnimation({required this.width});

  @override
  State<_PacmanAnimation> createState() => _PacmanAnimationState();
}

class _PacmanAnimationState extends State<_PacmanAnimation>
    with TickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: DS.image.pacman,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(animationController.value * widget.width, 0),
          child: child,
        );
      },
    );
  }
}

class _VoucherUseQuantityText extends StatelessWidget {
  final int usedQuantity;

  const _VoucherUseQuantityText(this.usedQuantity);

  @override
  Widget build(BuildContext context) {
    final style = DS.textStyle.paragraph2.semiBold.h14;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: usedQuantity.format(DS.text.voucherCountFormat),
            style: style.copyWith(color: DS.color.secondary900),
          ),
          const TextSpan(text: ' '),
          TextSpan(text: DS.text.allUsed, style: style),
        ],
      ),
    );
  }
}

class _TimeClock extends StatefulWidget {
  const _TimeClock();

  @override
  State<_TimeClock> createState() => _TimeClockState();
}

class _TimeClockState extends State<_TimeClock> {
  int millis = 0;

  late final Timer? _timer;
  final now = DateTime.now();
  final countFormat = "yyyy / MM / dd - hh : mm : ss.";

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => millis = millis + 100);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        "${now.add(Duration(milliseconds: millis)).format(countFormat)}${((millis % 1000) / 100).round()}");
  }
}
