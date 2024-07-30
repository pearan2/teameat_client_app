import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/block/i_user_block_repository.dart';

class UserBlockRepository implements IUserBlockRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, Unit>> blockCuration(int curationId) async {
    try {
      final path = '/api/member/block/curation/$curationId';
      final ret = await _conn.post(path, null);
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.blockFail('차단에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> blockUser(int userId) async {
    try {
      final path = '/api/member/block/member/$userId';
      final ret = await _conn.post(path, null);
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.blockFail('차단에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> unblockCuration(int curationId) async {
    try {
      final path = '/api/member/block/curation/$curationId';
      final ret = await _conn.delete(path, null);
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.blockFail('차단 해제에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> unblockUser(int userId) async {
    try {
      final path = '/api/member/block/member/$userId';
      final ret = await _conn.delete(path, null);
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.blockFail('차단 해제에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
