import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';

class LoginPageController extends PageController {
  final _authService = Get.find<IAuthService>();
  final _itemLikeController = Get.find<LikeController<IStoreItemRepository>>();
  final _storeLikeController = Get.find<LikeController<IStoreRepository>>();

  Future<void> loginWithKakao() async {
    return _loginWith('KAKAO');
  }

  Future<void> _loginWith(String socialLoginType) async {
    react.isEventLoading = true;
    final ret = await _authService.getLoginUrl(socialLoginType);
    react.isEventLoading = false;
    if (ret.isLeft()) return;
    final loginUrl = ret.getOrElse(() => '');
    final result = await FlutterWebAuth2.authenticate(
        url: loginUrl, callbackUrlScheme: 'teameatwebauthcallback');
    final accessToken = Uri.parse(result).queryParameters['accessToken'];
    if (accessToken == null) return;
    _authService.login(accessToken);
    _itemLikeController.load();
    _storeLikeController.load();
    react.back(result: true);
  }

  @override
  Future<bool> initialLoad() async {
    return true;
  }
}
