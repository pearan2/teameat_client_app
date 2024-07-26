import 'package:get/get.dart';
import 'package:teameat/2_application/community/curation_page_controller.dart';

class CurationPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CurationPageController(), permanent: true);
  }
}
