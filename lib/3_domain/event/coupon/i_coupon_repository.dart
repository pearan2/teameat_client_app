import 'package:dartz/dartz.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';

abstract class ICouponRepository {
  Future<Either<Failure, List<Coupon>>> findMyAllCoupons(
      {required SearchMyCoupons searchOption});

  Future<Either<Failure, Unit>> registerCoupon(String couponId);

  Future<Either<Failure, CouponApplyResult>> calcCouponAppliedAmount(
      {required int id, required int originalAmount});
}
