import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';
import 'package:teameat/3_domain/event/coupon/i_coupon_repository.dart';

class CouponRepository implements ICouponRepository {
  final _conn = Get.find<IConnection>();

  @override
  Future<Either<Failure, Unit>> registerCoupon(String couponId) async {
    try {
      const path = '/api/event/coupon/register';
      final ret = await _conn.post(path, {'couponId': couponId});
      return ret.fold((l) => left(l), (r) => right(unit));
    } catch (_) {
      return left(
          const Failure.couponRegisterFail("쿠폰 등록에 실패했습니다\n잘못된 쿠폰 번호 입니다"));
    }
  }

  @override
  Future<Either<Failure, List<Coupon>>> findMyAllCoupons(
      {required SearchMyCoupons searchOption}) async {
    try {
      const path = '/api/event/coupon/list';
      final ret =
          await _conn.get(path, SearchMyCoupons.toStringJson(searchOption));
      return ret.fold(
          (l) => left(l),
          (r) => right(
              (r as Iterable).map((json) => Coupon.fromJson(json)).toList()));
    } catch (e) {
      return left(const Failure.fetchCouponFail(
          "쿠폰 정보를 가져오는 데 실패했습니다. 잠시 후 다시 시도해주세요."));
    }
  }

  @override
  Future<Either<Failure, CouponApplyResult>> calcCouponAppliedAmount(
      {required int id, required int originalAmount}) async {
    try {
      const path = '/api/event/coupon/apply';
      final ret = await _conn.get(
          path, {'id': id.toString(), 'amount': originalAmount.toString()});
      return ret.fold((l) => left(l),
          (r) => right(CouponApplyResult.fromJson(r as JsonMap)));
    } catch (_) {
      return left(
          const Failure.couponRegisterFail("쿠폰 등록에 실패했습니다\n잘못된 쿠폰 번호 입니다"));
    }
  }
}
