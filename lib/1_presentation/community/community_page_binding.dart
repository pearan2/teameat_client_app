import 'package:get/get.dart';
import 'package:teameat/2_application/community/community_page_controller.dart';

class CommunityPageBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => CommunityPageController(), fenix: true);
    // 글을 다 작성하고 되돌아오면 PagingController 가 동작하지 않는 버그 때문에 fenix 를 제거
    Get.put(CommunityPageController());
  }
}
