import 'package:url_launcher/url_launcher.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomerServicePageController extends PageController {
  Future<void> onCustomerServiceClickHandler() async {
    final bool nativeAppLaunchSucceeded =
        await launchUrlString('kakaoplus://plusfriend/friend/_LyEixj');
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Uri.https('pf.kakao.com', '/_LyEixj'),
        mode: LaunchMode.inAppBrowserView,
      );
    }
  }
}
