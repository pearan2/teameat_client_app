import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/block/block.dart';

abstract class IUserBlockRepository {
  Future<Either<Failure, Unit>> blockUser(int userId);
  Future<Either<Failure, Unit>> unblockUser(int userId);
  Future<Either<Failure, Unit>> blockCuration(int curationId);
  Future<Either<Failure, Unit>> unblockCuration(int curationId);
  Future<Either<Failure, List<BlockTargetInfo>>> findAll(
      BlockTargetSearchList searchOption);
}
