import 'package:get/get.dart';
import 'package:teameat/2_application/home/store_item_search_page_controller.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreItemSearchPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final initialSearchOption = argMap['searchOption'] as SearchSimpleList;

    Get.put(StoreItemSearchPageController(
        initialSearchOption: initialSearchOption));
  }
}
