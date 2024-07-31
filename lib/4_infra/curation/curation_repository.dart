import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/4_infra/core/likable_repository.dart';

class CurationRepository extends ICurationRepository<CurationListSimple>
    with LikableRepositoryMixin<CurationListSimple> {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, List<MyCurationSimple>>> findMyAllCurations(
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
          '푸드 로그를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, MyCurationDetail>> findMyCurationById(int id) async {
    try {
      final path = '/api/store/curation/$id';

      final ret = await _conn.get(path, null);
      return ret.fold((l) => left(l),
          (r) => right(MyCurationDetail.fromJson(r as JsonMap)));
    } catch (e) {
      return left(const Failure.fetchCurationFail(
          '푸드 로그를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
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
          const Failure.registerCurationFail('등록에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, List<CurationListSimple>>> findAllCurations(
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
          '푸드 로그를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, CurationListDetail>> findCurationDetailById(
      int id) async {
    try {
      final path = '/api/store/curation/list/$id';

      final ret = await _conn.get(path, null);
      return ret.fold((l) => left(l), (r) {
        return right(CurationListDetail.fromJson(r as JsonMap));
      });
    } catch (e) {
      return left(const Failure.fetchCurationFail(
          '푸드 로그를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCuration(int id) async {
    try {
      final path = '/api/store/curation/$id';

      final ret = await _conn.delete(path, null);
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.deleteCurationFail(
          '푸드 로그를 삭제하는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCuration(
      int id, CurationCreateRequest request) async {
    try {
      final path = '/api/store/curation/$id';
      final ret = await _conn.patch(path, request.toJson());
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.updateCurationFail(
          '푸드 로그를 업데이트 하는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<dynamic, Object>> Function(List<int> ids) get dataLoader =>
      (ids) => _conn
          .get('/api/store/list/by-ids', {'ids': ids.map((e) => e.toString())});

  @override
  String get key => 'curationLikeLocalDateKey';

  @override
  String get likeLoadPath => '/api/member/like/curation';

  @override
  String Function(int id) get likeCallbackPathBuilder =>
      (id) => '/api/store/curation/like/$id';

  @override
  String Function(int id) get unlikeCallbackPathBuilder =>
      (id) => '/api/store/curation/unlike/$id';

  @override
  CurationListSimple Function(JsonMap json) get dataResolver =>
      CurationListSimple.fromJson;

  @override
  int get numberOfLikeDatasPerPage => 20;
}
