import 'package:get/get.dart';
import 'package:teameat/2_application/home/store_search_page_controller.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreSearchPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final initialSearchOption = argMap['searchOption'] as SearchSimpleList;

    Get.put(
        StoreSearchPageController(initialSearchOption: initialSearchOption));
  }
}
