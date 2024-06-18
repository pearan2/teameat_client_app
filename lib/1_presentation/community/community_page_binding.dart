import 'package:get/get.dart';
import 'package:teameat/2_application/community/community_page_controller.dart';

class CommunityPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunityPageController(), fenix: true);
  }
}
