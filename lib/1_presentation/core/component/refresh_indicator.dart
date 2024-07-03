import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';

class TERefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final double indicatorBoxHeight;

  const TERefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.indicatorBoxHeight = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: indicatorBoxHeight,
      autoRebuild: false,
      onRefresh: onRefresh,
      builder:
          (BuildContext context, Widget child, IndicatorController controller) {
        return Stack(
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (_, __) {
                  return Container(
                    height: controller.value * indicatorBoxHeight,
                    alignment: Alignment.center,
                    child: const TELoading(),
                  );
                }),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * indicatorBoxHeight),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      child: child,
    );
  }
}
