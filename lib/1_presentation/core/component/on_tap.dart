import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';

class TEonTap extends GetView<LoadingProvider> {
  final Widget child;
  final bool isLoginRequired;
  final void Function() onTap;

  const TEonTap(
      {super.key,
      required this.child,
      required this.onTap,
      this.isLoginRequired = false});

  Future<bool> checkLoginIfNotTryLogin() async {
    if (Get.find<IConnection>().isLogined) return true;
    final react = Get.find<IReact>();
    await react.toLogin();
    return Get.find<IConnection>().isLogined;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (controller.isGlobalLoading || controller.isPageLoading) {
          return;
        }
        if (isLoginRequired && !await checkLoginIfNotTryLogin()) {
          return;
        }
        onTap.call();
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
