import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/review/review.dart';
import 'package:teameat/2_application/core/login_checker.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/2_application/voucher/voucher_page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/99_util/firebase_cloud_message.dart';

class RootPageController extends PageController {
  final _codeRepo = Get.find<ICodeRepository>();
  final _authService = Get.find<IAuthService>();

  Future<void> _loadCode() {
    return Future.wait([
      _codeRepo.getCode(CodeKey.voucherFilter()),
      _codeRepo.getCode(CodeKey.voucherOrder()),
      _codeRepo.getCode(CodeKey.curationFilter()),
      _codeRepo.getCode(CodeKey.curationOrder()),
      _codeRepo.getSearchableAddress(),
    ]);
  }

  Future<void> _init() async {
    MessageHelper.configMessage();
    _authService.startUpdateToken();
    MessageHelper.consumeCallback = (MessageWrapper wrappedMessage) {
      final message = wrappedMessage.remoteMessage;
      final type = wrappedMessage.callbackType;
      final route = message.data['route'];
      if (route is! String) return true; // route 가 없거나 String 이 아닐 경우 날려준다.
      // login 에서 알람을 연결한 다음 home 으로 라우팅 다 되고 나서 다시 라우팅 하기 위함
      // route 의 케이스별

      Future.delayed(const Duration(milliseconds: 100),
          () => routeMessageCallback(route, type, message.data));
      return true;
    };
    react.toHomeOffAll();

    final appLinks = AppLinks(); // AppLinks is singleton

    appLinks.uriLinkStream.listen((uri) async {
      final params = uri.queryParameters;
      if (uri.path.contains('/item') &&
          params['id'] != null &&
          int.tryParse(params['id']!) is int) {
        Future.delayed(const Duration(milliseconds: 500),
            () => react.toStoreItemDetail(int.parse(params['id']!)));
      } else if (uri.authority.contains('gift') &&
          params['id'] != null &&
          params['id'] is String) {
        Future.delayed(const Duration(milliseconds: 500), () {
          loginWrapper(
              () => react.toGiftReceive(giftId: params['id'] as String));
        });
      } else if (uri.authority.contains('curation') &&
          params['id'] != null &&
          int.tryParse(params['id']!) is int) {
        Future.delayed(const Duration(milliseconds: 500), () {
          react.toCurationOffAll();
          loginWrapper(() => react.toCurationDetail(int.parse(params['id']!)));
        });
      } else if (uri.authority.contains('store') &&
          params['id'] != null &&
          int.tryParse(params['id']!) is int) {
        Future.delayed(const Duration(milliseconds: 500), () {
          react.toStoreDetail(int.parse(params['id']!));
        });
      }
    });
  }

  // message callback setting
  void voucherMessageCallback(MessageHelperCallbackType type) {
    if (type == MessageHelperCallbackType.inApp) {
      if (Get.currentRoute == '/voucher') {
        // inApp 이고 (foreground 에서 메시지가 온것) 이미 해당 페이지 라면
        Get.find<VoucherPageController>().refreshPage();
      }
    } else if (type == MessageHelperCallbackType.openApp) {
      // 앱이 열린것이라면
      Get.offAllNamed('/voucher');
    }
  }

  void voucherUseFeedBackCallback(
      MessageHelperCallbackType type, int voucherId) {
    /// voucherDetailPage 를 거처 가도록 Push 하면
    /// toReview 호출 전 충분한 delay (1초정도) 를 주지않으면 voucherDetailPageController 가 remove 된다
    /// GetX 의 바인딩 문제인것 같다
    /// 해서 우선은 앱을 열었을 경우에만 넘어가도록 해둠
    if (type == MessageHelperCallbackType.openApp) {
      toReview(voucherId, ReviewTargetType.voucher);
    }
  }

  void routeMessageCallback(
      String route, MessageHelperCallbackType type, Map<String, dynamic> data) {
    // Todo... page 에 대한 라우트 메시지가 추가될 때마다 올려야 함.
    if (route == '/voucher') {
      return voucherMessageCallback(type);
      // 또한 왜인진 모르겠지만 /voucher/detail 이런식으로 route 를 넣으면 동작을 안한다
    } else if ((route == '/voucher-review-request') &&
        (data['voucherId'] != null) &&
        (int.tryParse(data['voucherId']!) is int)) {
      return voucherUseFeedBackCallback(type, int.tryParse(data['voucherId'])!);
    }
  }

  @override
  Future<bool> initialLoad() async {
    await _loadCode();
    _init();
    return true;
  }
}
