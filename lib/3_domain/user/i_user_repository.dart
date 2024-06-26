import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/user.dart';

abstract class IUserRepository {
  void clearCache();

  Future<Either<Failure, User>> getMe();

  Future<Either<Failure, bool>> deleteMe();

  Future<Either<Failure, User>> updateMe(UserUpdate update);

  Future<Either<Failure, Unit>> updateToken(String token);

  Future<Either<Failure, List<int>>> getMyStoreItemLikes();

  Future<Either<Failure, List<int>>> getMyStoreLikes();
}
