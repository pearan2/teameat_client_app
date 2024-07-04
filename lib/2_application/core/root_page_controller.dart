import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
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
      Future.delayed(Duration.zero, () => routeMessageCallback(route, type));
      return true;
    };
    react.toHomeOffAll();

    final appLinks = AppLinks(); // AppLinks is singleton

    appLinks.uriLinkStream.listen((uri) async {
      final params = uri.queryParameters;
      if (uri.path.contains('/item') &&
          params['id'] != null &&
          int.tryParse(params['id']!) is int) {
        // Todo 우선은 1초로 해둠.
        Future.delayed(const Duration(seconds: 1),
            () => react.toStoreItemDetail(int.parse(params['id']!)));
      }
    });
  }

  // message callback setting
  void voucherMessageCallback(MessageHelperCallbackType type) {
    if (type == MessageHelperCallbackType.inApp) {
      if (Get.currentRoute == '/voucher') {
        // inApp 이고 (foreground 에서 메시지가 온것) 이미 해당 페이지 라면
        Get.find<VoucherPageController>().refreshData();
      }
    } else if (type == MessageHelperCallbackType.openApp) {
      // 앱이 열린것이라면
      Get.offAllNamed('/voucher');
    }
  }

  void routeMessageCallback(String route, MessageHelperCallbackType type) {
    // Todo... page 에 대한 라우트 메시지가 추가될 때마다 올려야 함.
    if (route == '/voucher') {
      voucherMessageCallback(type);
    }
  }

  @override
  Future<bool> initialLoad() async {
    await _loadCode();
    _init();
    return true;
  }
}
