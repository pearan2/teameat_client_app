import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/user/user_page_controller.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';

Future<T?> loginWrapper<T>(T Function() callback) async {
  if (Get.find<IConnection>().isLogined) return callback();

  final isToLoginConfirm = await showTEConfirmDialog(
    content: DS.text.needToLoginContent,
    leftButtonText: DS.text.refuseToLogin,
    rightButtonText: DS.text.confirmToLogin,
  );
  if (!isToLoginConfirm) return null;
  final react = Get.find<IReact>();
  await react.toLogin();
  if (Get.find<IConnection>().isLogined) {
    if (Get.isRegistered<UserPageController>()) {
      Get.find<UserPageController>().user.load();
    }
    return callback();
  }
  return null;
}
