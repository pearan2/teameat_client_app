import 'package:get/get.dart';
import 'package:teameat/2_application/store/item/purchase_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class PurchasePageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final items = argMap['items'] as Map<ItemDetail, int>;
    final withOpenGroupBuying = argMap['withOpenGroupBuying'] as bool;
    final groupBuyingId = argMap['groupBuyingId'] as int?;
    final isForGift = argMap['isForGift'] as bool;

    Get.put(PurchasePageController(
      items: items,
      withOpenGroupBuying: withOpenGroupBuying,
      groupBuyingId: groupBuyingId,
      isForGift: isForGift,
    ));
  }
}
