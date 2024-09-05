import 'package:get/get.dart';
import 'package:teameat/2_application/user/user_follower_page_controller.dart';

class UserFollowerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserFollowerPageController());
  }
}
