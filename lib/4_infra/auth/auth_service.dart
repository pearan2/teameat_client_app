import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/99_util/firebase_cloud_message.dart';

class AuthService extends IAuthService {
  final _conn = Get.find<IConnection>();
  final _userRepo = Get.find<IUserRepository>();

  @override
  Future<Either<Failure, String>> getLoginUrl(String socialLoginType) async {
    try {
      const path = '/api/auth/social-login-url';
      final ret = await _conn.get(path, {'socialLoginType': socialLoginType});
      return ret.fold(
          (l) => left(l), (r) => right((r as JsonMap)['socialLoginUrl']));
    } catch (e) {
      return left(const Failure.fetchSocialLoginUrlFail(
          "로그인에 실패하였습니다. 잠시 후 다시 시도해주세요."));
    }
  }

  @override
  void startUpdateToken() {
    if (!isLogined()) {
      return;
    }
    MessageHelper.startUpdateToken(_tokenUpdate);
  }

  Future<void> _tokenUpdate(String token) async {
    await _userRepo.updateToken(token);
  }

  @override
  Future<void> login(String accessToken) async {
    _conn.setAuthentication(accessToken);
    startUpdateToken();
    return;
  }

  @override
  void logOut() {
    _userRepo.clearCache();

    return _conn.removeAuthentication();
  }

  @override
  bool isLogined() {
    return _conn.isLogined;
  }
}
