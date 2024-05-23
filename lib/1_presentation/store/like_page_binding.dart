import 'package:get/get.dart';
import 'package:teameat/2_application/store/like_page_controller.dart';

class StoreLikePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(StoreLikePageController());
  }
}
