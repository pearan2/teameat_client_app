import 'package:get/get.dart';
import 'package:teameat/2_application/gift/gift_receive_page_controller.dart';

class GiftReceivePageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final giftId = argMap['giftId'] as String;

    Get.put(GiftReceivePageController(giftId: giftId));
  }
}
