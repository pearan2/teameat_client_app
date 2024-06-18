import 'package:get/get.dart';
import 'package:teameat/2_application/community/community_create_page_controller.dart';

class CommunityCreatePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CommunityCreatePageController());
  }
}
