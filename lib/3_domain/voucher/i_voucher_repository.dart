import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

abstract class IVoucherRepository {
  Future<Either<Failure, int>> findNumberOfUsableVouchers();
  Future<Either<Failure, List<VoucherSimple>>> findAllVouchers(
      SearchVoucherSimpleList searchOption);
  Future<Either<Failure, VoucherDetail>> findById(int id);
  Future<Either<Failure, VoucherDetail>> findByOrderId(String orderId);
  Future<Either<Failure, VoucherDetail>> useVoucher(
      int id, UseVoucher useVoucher);
}
