import 'package:get/get.dart';
import 'package:teameat/2_application/user/user_curation_page_controller.dart';

class UserCurationPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserCurationPageController());
  }
}
