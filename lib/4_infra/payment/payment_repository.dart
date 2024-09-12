import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/payment/i_payment_repository.dart';

class PaymentRepository implements IPaymentRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, Unit>> isPaid(
      {required String orderId, required String paymentId}) async {
    try {
      const path = '/api/payment/callback';
      final ret = await _conn.post(path, {
        'merchant_uid': orderId,
        'imp_uid': paymentId,
        'status': 'PAID',
      });
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(const Failure.paymentCheckPaidFail(
          "결제가 정상적으로 이루어지지 않았습니다. 잠시 후 다시 시도해주세요."));
    }
  }
}
