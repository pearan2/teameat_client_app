import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/2_application/core/page_controller.dart';

class GiftSuccessPageController extends PageController {
  final String giftId;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  GiftSuccessPageController({required this.giftId});

  Future<void> shareGiftCode() async {
    _isLoading.value = true;
    final result = await Share.shareUri(
        Uri.https(Environment().linkBaseUrl, '/gift/$giftId'));
    _isLoading.value = false;
    if (result.status == ShareResultStatus.success) {
      react.back();
    }
  }
}
