import 'package:get/get.dart';
import 'package:teameat/2_application/community/curator_summary_view_page_controller.dart';

class CuratorSummaryViewPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final curatorId = argMap['curatorId'] as int;

    Get.put(CuratorSummaryViewPageController(curatorId));
  }
}
