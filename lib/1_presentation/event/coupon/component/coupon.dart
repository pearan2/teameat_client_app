import 'package:flutter/widgets.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;

  const CouponCard(this.coupon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(coupon.event.title),
    );
  }
}
