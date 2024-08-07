import 'package:get/get.dart';
import 'package:teameat/2_application/user/user_block_page_controller.dart';
import 'package:teameat/3_domain/user/block/block.dart';

class UserBlockPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final blockTargetType = argMap['blockTargetType'] as BlockTargetType;

    Get.put(UserBlockPageController(blockTargetType));
  }
}
