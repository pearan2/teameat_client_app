import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:teameat/2_application/core/loading_provider.dart';

class PageLoadingWrapper extends GetView<LoadingProvider> {
  final Widget child;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;

  const PageLoadingWrapper(
      {super.key,
      required this.child,
      this.borderRadius = 20,
      this.baseColor = Colors.black,
      this.highlightColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isPageLoading) return child;
      return Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Container(
                color: baseColor,
              ),
            )),
            child,
          ],
        ),
      );
    });
  }
}
