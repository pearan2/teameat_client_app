import 'package:get/get.dart';
import 'package:teameat/2_application/core/root_page_controller.dart';

class RootPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RootPageController());
  }
}
