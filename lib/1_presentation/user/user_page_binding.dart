import 'package:get/get.dart';
import 'package:teameat/2_application/user/user_page_controller.dart';

class UserPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserPageController());
  }
}
