import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';

abstract class IPaymentRepository {
  Future<Either<Failure, Unit>> isPaid({
    required String orderId,
    required String paymentId,
  });
}
