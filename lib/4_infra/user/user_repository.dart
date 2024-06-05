import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserRepository implements IUserRepository {
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
  Future<Either<Failure, User>> updateMe(UserUpdate update) async {
    try {
      const path = 'api/member/me';
      final ret = await _conn.patch(path, update.toJson());
      return ret.fold(
          (l) => left(l), (r) => right(User.fromJson(r as JsonMap)));
    } catch (e) {
      return left(
          const Failure.updateMeFail('내 정보를 업데이트 하는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
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

  Future<Either<Failure, List<int>>> _getMyLikes(String path) async {
    try {
      const path = 'api/member/me';
      final ret = await _conn.delete(path, null);
      return ret.fold((l) => left(l),
          (r) => right((r as Iterable).map((e) => e as int).toList()));
    } catch (e) {
      return left(const Failure.fetchLikeFail(
          '정상적으로 좋아요 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getMyStoreItemLikes() {
    return _getMyLikes('api/member/like/store-item');
  }

  @override
  Future<Either<Failure, List<int>>> getMyStoreLikes() {
    return _getMyLikes('api/member/like/store');
  }
}
