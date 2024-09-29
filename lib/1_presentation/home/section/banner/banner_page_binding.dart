import 'package:get/get.dart';
import 'package:teameat/2_application/home/section/banner_page_controller.dart';

class BannerPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final url = argMap['url'] as String;

    Get.put(BannerPageController(url: url));
  }
}
