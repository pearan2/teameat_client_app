import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserRepository extends IUserRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, User>> getMe() async {
    try {
      const path = 'api/member/me';
      final ret = await _conn.get(path, null);
      return ret.fold(
          (l) => left(l), (r) => right(User.fromJson(r as JsonMap)));
    } catch (e) {
      return left(
          const Failure.fetchMeFail('내 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMe() async {
    try {
      const path = 'api/member/me';
      final ret = await _conn.delete(path, null);
      return ret.fold((l) => left(l), (r) => right(r as bool));
    } catch (e) {
      return left(const Failure.deleteMeFail('회원탈퇴에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
