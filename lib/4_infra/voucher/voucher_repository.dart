import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/voucher/i_voucher_repository.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class VoucherRepository implements IVoucherRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, List<VoucherSimple>>> findAllVouchers(
      SearchVoucherSimpleList searchOption) async {
    try {
      const path = 'api/voucher/list';
      final ret = await _conn.get(
          path, SearchVoucherSimpleList.toStringJson(searchOption));
      return ret.fold(
          (l) => left(l),
          (r) => right((r as Iterable)
              .map((json) => VoucherSimple.fromJson(json))
              .toList()));
    } catch (_) {
      return left(const Failure.fetchVoucherFail(
          '이용권 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, int>> findNumberOfUsableVouchers() async {
    try {
      const path = 'api/voucher/count-usable';
      final ret = await _conn.get(path, null);
      return ret.fold((l) => left(l), (r) => right(r as int));
    } catch (_) {
      return left(const Failure.fetchVoucherFail(
          '이용권 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  Future<Either<Failure, VoucherDetail>> _findBy(String path) async {
    try {
      final ret = await _conn.get(path, null);
      return ret.fold(
          (l) => left(l), (r) => right(VoucherDetail.fromJson(r as JsonMap)));
    } catch (_) {
      return left(const Failure.fetchVoucherFail(
          '이용권 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, VoucherDetail>> findById(int id) async {
    return _findBy('api/voucher/$id');
  }

  @override
  Future<Either<Failure, VoucherDetail>> findByOrderId(String orderId) {
    return _findBy('api/voucher/$orderId');
  }

  @override
  Future<Either<Failure, VoucherDetail>> useVoucher(
      int id, UseVoucher useVoucher) async {
    try {
      final path = 'api/voucher/use/$id';
      final ret = await _conn.post(path, useVoucher.toJson());
      return ret.fold(
          (l) => left(l), (r) => right(VoucherDetail.fromJson(r as JsonMap)));
    } catch (_) {
      return left(const Failure.useVoucherFail(
          '이용권을 사용하는데 실패하였습니다. 비밀번호를 다시 확인해주세요. 문제가 지속된다면 고객센터로 문의해주세요.'));
    }
  }
}
