import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';

Future<T?> loginWrapper<T>(T Function() callback) async {
  if (Get.find<IConnection>().isLogined) return callback();

  final isToLoginConfirm = await showTEConfirmDialog(
    content: DS.getText().needToLoginContent,
    leftButtonText: DS.getText().refuseToLogin,
    rightButtonText: DS.getText().confirmToLogin,
  );
  if (!isToLoginConfirm) return null;
  final react = Get.find<IReact>();
  await react.toLogin();
  if (Get.find<IConnection>().isLogined) return callback();
  return null;
}
