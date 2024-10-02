import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/code/statistics/i_statistics_repository.dart';
import 'package:teameat/3_domain/core/code/statistics/statistics.dart';
import 'package:teameat/3_domain/core/failure.dart';

class StatisticsRepository implements IStatisticsRepository {
  final _conn = Get.find<IConnection>();

  Future<Either<Failure, List<T>>> _find<T>({
    required String path,
    required Map<String, dynamic> param,
    required T Function(Map<String, Object?> json) fromJson,
  }) async {
    try {
      final ret = await _conn.get(path, param);
      return ret.fold((l) => left(l),
          (r) => right((r as Iterable).map((json) => fromJson(json)).toList()));
    } catch (_) {
      return left(const Failure.fetchStatisticsFail(
          "통계 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도 해주세요."));
    }
  }

  @override
  Future<Either<Failure, List<CurationRewardStatistics>>>
      findCurationStatistics({
    required SearchList searchOption,
  }) =>
          _find(
            path: '/api/common/statistics/curation/reward',
            param: SearchList.toStringJson(searchOption),
            fromJson: CurationRewardStatistics.fromJson,
          );

  @override
  Future<Either<Failure, List<StoreItemSalesStatistics>>> findItemStatistics({
    required SearchList searchOption,
  }) =>
      _find(
        path: '/api/common/statistics/item/sales',
        param: SearchList.toStringJson(searchOption),
        fromJson: StoreItemSalesStatistics.fromJson,
      );
}
