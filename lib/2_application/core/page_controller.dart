import 'package:get/get.dart';
import 'package:teameat/2_application/core/i_react.dart';

abstract class PageController extends GetxController {
  final react = Get.find<IReact>();

  Future<bool> initialLoad() async => true;

  @override
  Future<void> onInit() async {
    super.onInit();
    react.isPageLoading = true;
    final initLoadingResult = await initialLoad();
    react.isPageLoading = false;
    if (!initLoadingResult) react.showError();
  }
}
