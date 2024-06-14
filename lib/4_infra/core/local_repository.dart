import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/i_local_repository.dart';
import 'package:teameat/3_domain/core/local.dart';

class LocalRepository implements ILocalRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, List<Local>>> findLocal(String searchText) async {
    try {
      const path = '/api/common/local';
      final ret = await _conn.get(path, {'searchText': searchText});
      return ret.fold(
          (l) => left(l),
          (r) => right(
              (r as Iterable).map((json) => Local.fromJson(json)).toList()));
    } catch (_) {
      return left(const Failure.fetchLocalFail(
          "상점 정보를 검색하는데 실패했습니다. 잠시 후 다시 시도 해주세요."));
    }
  }
}
