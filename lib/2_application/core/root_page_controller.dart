import 'package:teameat/2_application/core/page_controller.dart';

class RootPageController extends PageController {
  @override
  Future<bool> initialLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    react.toHomeOffAll();
    return true;
  }
}
