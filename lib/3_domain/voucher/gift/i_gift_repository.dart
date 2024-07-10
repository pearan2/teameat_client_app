import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/voucher/gift/gift.dart';

abstract class IGiftRepository {
  Future<Either<Failure, String>> createGiftFromVoucher(
      {required int voucherId, required int quantity, String? message});

  Future<Either<Failure, GiftPreview>> findGiftPreview(String giftId);

  Future<Either<Failure, List<GiftPreview>>> findMyGiftPreview(
      {required int pageNumber, required int pageSize});

  Future<Either<Failure, Unit>> receiveGift(String giftId);
}
