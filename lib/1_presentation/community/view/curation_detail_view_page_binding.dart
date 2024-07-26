import 'package:get/get.dart';
import 'package:teameat/2_application/community/community_view_page_controller.dart';

class CommunityViewPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final curationId = argMap['curationId'] as int;

    Get.put(CommunityViewPageController(curationId));
  }
}
