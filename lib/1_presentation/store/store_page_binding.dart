import 'package:get/get.dart';
import 'package:teameat/2_application/store/store_page_controller.dart';

class StorePageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final storeId = argMap['storeId'] as int;

    Get.put(StorePageController(storeId: storeId), tag: storeId.toString());
  }
}
