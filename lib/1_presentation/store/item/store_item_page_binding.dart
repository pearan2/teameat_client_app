import 'package:get/get.dart';
import 'package:teameat/2_application/store/item/store_item_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class StoreItemPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final itemId = argMap['itemId'] as int;
    final itemDetail = argMap['itemDetail'] as ItemDetail?;
    final onApplyCuration =
        argMap['onApplyCuration'] as Future<void> Function()?;

    Get.put(
        StoreItemPageController(
          itemId: itemId,
          itemDetail: itemDetail,
          onApplyCuration: onApplyCuration,
        ),
        tag: itemId.toString());
  }
}
