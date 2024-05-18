import 'package:url_launcher/url_launcher.dart';
import 'package:teameat/2_application/core/page_controller.dart';

class CustomerServicePageController extends PageController {
  Future<void> _launchUniversalLinkIOS(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppBrowserView,
      );
    }
  }

  void onCustomerServiceClickHandler() {
    _launchUniversalLinkIOS(Uri.https('pf.kakao.com', '/_LyEixj'));
  }
}
