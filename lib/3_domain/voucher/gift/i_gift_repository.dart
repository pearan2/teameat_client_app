import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class IGiftRepository {
  Future<Either<Failure, Unit>> createGiftFromVoucher(
      {required int voucherId, required int quantity});
}
