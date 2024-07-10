import 'package:get/get.dart';
import 'package:teameat/2_application/gift/gift_page_controller.dart';

class GiftPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GiftPageController());
  }
}
