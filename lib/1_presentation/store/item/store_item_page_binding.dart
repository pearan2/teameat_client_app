import 'package:get/get.dart';
import 'package:teameat/2_application/store/item/store_item_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class StoreItemPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final itemId = argMap['itemId'] as int;
    final itemSimple = argMap['item'] as ItemSimple?;

    Get.put(
        StoreItemPageController(
          itemId: itemId,
          itemSimple: itemSimple,
        ),
        tag: itemId.toString());
  }
}
