import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';

class CurationRepository implements ICurationRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, List<CurationSimple>>> findAll({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      const path = '/api/store/curation/list-by-creator';

      final ret = await _conn
          .get(path, {'pageNumber': pageNumber, 'pageSize': pageSize});
      return ret.fold(
          (l) => left(l),
          (r) => right((r as Iterable)
              .map((json) => CurationSimple.fromJson(json as JsonMap))
              .toList()));
    } catch (e) {
      return left(const Failure.fetchCurationFail(
          '신청 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, CurationDetail>> findById(int id) async {
    try {
      final path = '/api/store/curation/$id';

      final ret = await _conn.get(path, null);
      return ret.fold(
          (l) => left(l), (r) => right(CurationDetail.fromJson(r as JsonMap)));
    } catch (e) {
      return left(const Failure.fetchCurationFail(
          '신청 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, CurationDetail>> registerCuration(
      CurationCreateRequest request) async {
    try {
      const path = '/api/store/curation';

      final ret = await _conn.post(path, request.toJson());
      return ret.fold(
          (l) => left(l), (r) => right(CurationDetail.fromJson(r as JsonMap)));
    } catch (e) {
      return left(
          const Failure.registerCurationFail('신청에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
