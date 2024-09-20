import 'package:get/get.dart';
import 'package:teameat/2_application/event/coupon/coupon_page_controller.dart';

class CouponPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CouponPageController());
  }
}
