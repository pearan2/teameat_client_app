import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/2_application/core/login_checker.dart';

class TEonTap extends GetView<LoadingProvider> {
  final Widget child;
  final bool isLoginRequired;
  final void Function()? onDoubleTap;
  final void Function() onTap;

  const TEonTap(
      {super.key,
      required this.child,
      required this.onTap,
      this.onDoubleTap,
      this.isLoginRequired = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onTap: () {
        if (controller.isGlobalLoading ||
            controller.isPageLoading ||
            controller.isEventLoading) {
          return;
        }
        if (isLoginRequired) {
          loginWrapper(() => onTap());
          return;
        }
        onTap.call();
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
