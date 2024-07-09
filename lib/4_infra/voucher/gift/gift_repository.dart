import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/voucher/gift/gift.dart';
import 'package:teameat/3_domain/voucher/gift/i_gift_repository.dart';

class GiftRepository implements IGiftRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, String>> createGiftFromVoucher(
      {required int voucherId, required int quantity, String? message}) async {
    try {
      const path = "api/voucher/gift/by-voucher";
      final ret = await _conn.post(path,
          {'voucherId': voucherId, 'quantity': quantity, 'message': message});
      return ret.fold(
          (l) => left(l), (r) => right(((r as JsonMap)['id']) as String));
    } catch (e) {
      return left(
          const Failure.createGiftFail('선물하기에 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, GiftPreview>> findGiftPreview(String giftId) async {
    try {
      final path = "api/voucher/gift/$giftId";
      final ret = await _conn.get(path, null);
      return ret.fold(
          (l) => left(l), (r) => right(GiftPreview.fromJson(r as JsonMap)));
    } catch (e) {
      return left(
          const Failure.fetchGiftFail('선물 데이터를 불러오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> receiveGift(String giftId) async {
    try {
      final path = "api/voucher/gift/receive/$giftId";
      final ret = await _conn.get(path, null);
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (e) {
      return left(
          const Failure.createGiftFail('선물코드를 입력하는데 실패하였습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
