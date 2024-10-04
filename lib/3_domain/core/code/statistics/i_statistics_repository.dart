import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/code/statistics/statistics.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class IStatisticsRepository {
  Future<Either<Failure, List<StoreItemSalesStatistics>>> findItemStatistics({
    required SearchList searchOption,
  });

  Future<Either<Failure, List<CurationRewardStatistics>>>
      findCurationStatistics({
    required SearchList searchOption,
  });
}
