import 'package:get/get.dart';
import 'package:teameat/2_application/core/i_react.dart';

class LoadingProvider {
  final _react = Get.find<IReact>();
  bool get isPageLoading => _react.isPageLoading;
  bool get isGlobalLoading => _react.isGlobalLoading;
}
