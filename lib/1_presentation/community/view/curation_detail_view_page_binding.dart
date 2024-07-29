import 'package:get/get.dart';
import 'package:teameat/2_application/community/curation_detail_view_page_controller.dart';

class CurationDetailViewPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final curationId = argMap['curationId'] as int;

    Get.put(CurationDetailViewPageController(curationId),
        tag: curationId.toString());
  }
}
