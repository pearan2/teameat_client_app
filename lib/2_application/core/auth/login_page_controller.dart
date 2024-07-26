import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';

class LoginPageController extends PageController {
  final _authService = Get.find<IAuthService>();
  final _itemLikeController = Get.find<LikeController<IStoreItemRepository>>();
  final _storeLikeController = Get.find<LikeController<IStoreRepository>>();
  final _curationLikeController =
      Get.find<LikeController<ICurationRepository>>();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  Future<void> loginWithKakao() async {
    return _loginWith('KAKAO');
  }

  Future<void> loginWithApple() async {
    return _loginWith('APPLE');
  }

  Future<void> _loginWith(String socialLoginType) async {
    _isLoading.value = true;
    final ret = await _authService.getLoginUrl(socialLoginType);
    _isLoading.value = false;
    if (ret.isLeft()) return;
    final loginUrl = ret.getOrElse(() => '');
    try {
      final result = await FlutterWebAuth2.authenticate(
          url: loginUrl, callbackUrlScheme: 'teameatwebauthcallback');
      final accessToken = Uri.parse(result).queryParameters['accessToken'];
      if (accessToken == null) return;
      _authService.login(accessToken);
      _itemLikeController.load();
      _storeLikeController.load();
      _curationLikeController.load();
      react.back(result: true);
    } catch (_) {}
  }

  @override
  Future<bool> initialLoad() async {
    return true;
  }
}
