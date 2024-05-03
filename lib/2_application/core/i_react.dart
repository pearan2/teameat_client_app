import 'package:get/get.dart';
import 'package:teameat/2_application/core/i_router.dart';

abstract class IReact extends IRouter {
  // loading
  final _isPageLoading = false.obs;
  final _isGlobalLoading = false.obs;

  set isPageLoading(bool value) => _isPageLoading.value = value;
  bool get isPageLoading => _isPageLoading.value;

  set isGlobalLoading(bool value) => _isGlobalLoading.value = value;
  bool get isGlobalLoading => _isGlobalLoading.value;
  // loading end
}
