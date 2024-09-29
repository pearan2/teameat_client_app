import 'package:get/get.dart';
import 'package:teameat/2_application/home/section/group_buying_search_page_controller.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';

class GroupBuyingSearchPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final selectedAddress = argMap['selectedAddress'] as SearchableAddress?;

    Get.put(GroupBuyingSearchPageController(
        initialSelectedAddress: selectedAddress));
  }
}
