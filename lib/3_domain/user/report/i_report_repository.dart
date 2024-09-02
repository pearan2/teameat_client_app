import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class IReportRepository {
  Future<Either<Failure, Unit>> reportCuration(int curationId, String? report);
  Future<Either<Failure, Unit>> reportUser(int userId, String? report);
  Future<Either<Failure, Unit>> review(
      {String? report,
      required int score,
      required int targetId,
      required String targetTypeCode});
}
