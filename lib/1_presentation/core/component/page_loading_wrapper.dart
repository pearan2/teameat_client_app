import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/loading_provider.dart';

class PageLoadingWrapper extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;

  const PageLoadingWrapper(
      {super.key,
      required this.child,
      this.borderRadius = 8,
      this.baseColor = Colors.grey,
      this.highlightColor = Colors.white});

  @override
  State<PageLoadingWrapper> createState() => _PageLoadingWrapperState();
}

class _PageLoadingWrapperState extends State<PageLoadingWrapper> {
  bool firstLoadingEnded = false;

  @override
  Widget build(BuildContext context) {
    if (firstLoadingEnded) {
      return widget.child;
    }
    final c = Get.find<LoadingProvider>();

    return Obx(() {
      if (!c.isPageLoading) {
        Future.delayed(Duration.zero, () {
          setState(() {
            firstLoadingEnded = true;
          });
        });
      }
      return TEShimmer(
        baseColor: widget.baseColor,
        highlightColor: widget.highlightColor,
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              child: Container(
                color: widget.baseColor,
              ),
            )),
            Padding(
              padding: EdgeInsets.all(DS.space.xxTiny),
              child: widget.child,
            ),
          ],
        ),
      );
    });
  }
}

class TEShimmer extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final Widget child;
  const TEShimmer({
    super.key,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    required this.child,
  });

  factory TEShimmer.fromSize({
    required double width,
    required double height,
  }) {
    return TEShimmer(
        child: Container(
      width: width,
      height: height,
      color: Colors.grey,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}
