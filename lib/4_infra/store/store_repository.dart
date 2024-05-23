import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/4_infra/core/likable_repository.dart';

class StoreRepository extends IStoreRepository<StoreSimple>
    with LikableRepositoryMixin<StoreSimple> {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, List<StoreSimple>>> getStores(
      SearchStoreSimpleList searchOption) async {
    try {
      const path = '/api/store/list';
      final ret = await _conn.get(
          path, SearchStoreSimpleList.toStringJson(searchOption));
      return ret.fold(
          (l) => left(l),
          (r) => right((r as Iterable)
              .map((json) => StoreSimple.fromJson(json))
              .toList()));
    } catch (_) {
      return left(const Failure.fetchStoreFail(
          "상점 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도 해주세요."));
    }
  }

  @override
  Future<Either<Failure, StoreDetail>> getStoreDetail(int storeId) async {
    try {
      final path = '/api/store/$storeId';
      final ret = await _conn.get(path, null);
      return ret.fold(
          (l) => left(l), (r) => right(StoreDetail.fromJson(r as JsonMap)));
    } catch (e) {
      return left(const Failure.fetchStoreFail(
          "상점 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도 해주세요."));
    }
  }

  @override
  Future<Either<dynamic, Object>> Function(List<int> ids) get dataLoader =>
      (ids) => _conn
          .get('/api/store/list/by-ids', {'ids': ids.map((e) => e.toString())});

  @override
  String get key => 'storeLikeLocalDateKey';

  @override
  String get likeLoadPath => '/api/member/like/store';

  @override
  String Function(int id) get likeCallbackPathBuilder =>
      (id) => '/api/store/like/$id';

  @override
  String Function(int id) get unlikeCallbackPathBuilder =>
      (id) => '/api/store/unlike/$id';

  @override
  StoreSimple Function(JsonMap json) get dataResolver => StoreSimple.fromJson;

  @override
  int get numberOfLikeDatasPerPage => 20;
}
