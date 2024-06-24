import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class IAuthService {
  Future<Either<Failure, String>> getLoginUrl(String socialLoginType);
  Future<void> login(String accessToken);
  void startUpdateToken();
  void logOut();
  bool isLogined();
}
