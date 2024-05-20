import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';

class AuthService extends IAuthService {
  final _conn = Get.find<IConnection>();

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
  void login(String accessToken) {
    return _conn.setAuthentication(accessToken);
  }

  @override
  void logOut() {
    return _conn.removeAuthentication();
  }

  @override
  bool isLogined() {
    return _conn.isLogined;
  }
}
