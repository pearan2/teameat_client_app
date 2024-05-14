import 'package:get/get.dart';
import 'package:teameat/2_application/core/auth/login_page_controller.dart';

class LoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginPageController());
  }
}
