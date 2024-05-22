import 'package:get/get.dart';
import 'package:teameat/2_application/store/item/like_page_controller.dart';

class LikePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LikePageController());
  }
}
