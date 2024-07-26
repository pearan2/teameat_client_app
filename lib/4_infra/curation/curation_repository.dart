import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';

class CurationRepository implements ICurationRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, List<MyCurationSimple>>> findAll(
      SearchMyCurationSimpleList searchOption) async {
    try {
      const path = '/api/store/curation/list-by-creator';

      final ret = await _conn.get(
          path, SearchMyCurationSimpleList.toStringJson(searchOption));
      return ret.fold(
          (l) => left(l),
          (r) => right((r as Iterable)
              .map((json) => MyCurationSimple.fromJson(json as JsonMap))
              .toList()));
    } catch (e) {
      return left(const Failure.fetchCurationFail(
          '신청 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, MyCurationDetail>> findById(int id) async {
    try {
      final path = '/api/store/curation/$id';

      final ret = await _conn.get(path, null);
      return ret.fold((l) => left(l),
          (r) => right(MyCurationDetail.fromJson(r as JsonMap)));
    } catch (e) {
      return left(const Failure.fetchCurationFail(
          '신청 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, MyCurationDetail>> registerCuration(
      CurationCreateRequest request) async {
    try {
      const path = '/api/store/curation';

      final ret = await _conn.post(path, request.toJson());
      return ret.fold((l) => left(l),
          (r) => right(MyCurationDetail.fromJson(r as JsonMap)));
    } catch (e) {
      return left(
          const Failure.registerCurationFail('신청에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, List<CurationListSimple>>> findCurationList(
      SearchCurationSimpleList searchOption) async {
    try {
      const path = '/api/store/curation/list';

      final ret = await _conn.get(
          path, SearchCurationSimpleList.toStringJson(searchOption));
      return ret.fold(
          (l) => left(l),
          (r) => right((r as Iterable)
              .map((json) => CurationListSimple.fromJson(json as JsonMap))
              .toList()));
    } catch (e) {
      return left(const Failure.fetchCurationFail(
          '신청 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
