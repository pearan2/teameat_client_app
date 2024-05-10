import 'package:get/get.dart';
import 'package:teameat/2_application/core/i_react.dart';

class React extends IReact {
  @override
  void toRoot() {
    Get.offAllNamed('/');
  }

  @override
  void toHomeOffAll() {
    Get.offAllNamed('/home');
  }

  @override
  void showError() {
    throw "NOT IMPLEMENTED";
  }
}
