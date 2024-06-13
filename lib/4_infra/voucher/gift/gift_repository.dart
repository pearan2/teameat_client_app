import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/voucher/gift/i_gift_repository.dart';

class GiftRepository implements IGiftRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, Unit>> createGiftFromVoucher(
      {required int voucherId, required int quantity}) async {
    try {
      const path = "api/voucher/gift/by-voucher";
      final ret = await _conn
          .post(path, {'voucherId': voucherId, 'quantity': quantity});
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(
          const Failure.createGiftFail('선물하기에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
