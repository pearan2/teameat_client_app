import 'package:get/get.dart';
import 'package:teameat/2_application/community/curation_create_page_controller.dart';

class CurationCreatePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CurationCreatePageController());
  }
}
