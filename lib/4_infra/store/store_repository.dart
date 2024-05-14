import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreRepository extends IStoreRepository {
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
}
