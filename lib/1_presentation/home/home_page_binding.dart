import 'package:get/get.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController(), permanent: true);
  }
}
