import 'package:get/get.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPageController extends PageController {
  final _authService = Get.find<IAuthService>();

  final _user = User.visitor().obs;

  User get user => _user.value;

  void toPrivacyPolicy() {
    final url = Uri.https(
        '80000coding.notion.site', '/6c327d4888414099b737cce42add2de5');
    launchUrl(url);
  }

  void toServicePolicy() {
    final url = Uri.https(
        '80000coding.notion.site', '/a12fbdc3259c49158e93ff99fbdc173b');
    launchUrl(url);
  }

  void toBusinessRegistrationInformation() {}

  void onLogOut() {
    _authService.logOut();
    _user.value = User.visitor();
  }

  Future<void> onSignOut() async {}
}
