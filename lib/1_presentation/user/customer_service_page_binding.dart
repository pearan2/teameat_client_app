import 'package:get/get.dart';
import 'package:teameat/2_application/user/customer_service_page_controller.dart';

class CustomerServicePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CustomerServicePageController());
  }
}
