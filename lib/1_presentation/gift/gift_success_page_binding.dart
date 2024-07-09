import 'package:get/get.dart';
import 'package:teameat/2_application/gift/gift_success_page_controller.dart';

class GiftSuccessPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final giftId = argMap['giftId'] as String;

    Get.put(GiftSuccessPageController(giftId: giftId));
  }
}
