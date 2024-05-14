import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
      return Shimmer.fromColors(
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
            widget.child,
          ],
        ),
      );
    });
  }
}
