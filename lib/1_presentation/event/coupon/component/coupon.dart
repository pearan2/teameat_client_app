import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final bool isSelected;

  const CouponCard(this.coupon, {super.key, this.isSelected = false});

  String getProperDiscountText() {
    if (coupon.event.discountAmount != null) {
      return coupon.event.discountAmount!
          .format(DS.text.couponDiscountAmountFormat);
    } else if (coupon.event.discountRatio != null) {
      return coupon.event.discountRatio!
          .format(DS.text.couponDiscountRatioFormat);
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: DS.color.background000,
          border: Border.all(
              color: isSelected ? DS.color.primary600 : DS.color.background300,
              width: DS.space.xxTiny),
          borderRadius: BorderRadius.circular(DS.space.tiny),
          boxShadow: [
            BoxShadow(
              color: DS.color.background600.withOpacity(0.5),
              blurRadius: DS.space.xTiny,
              offset: Offset(0, DS.space.xTiny),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(coupon.event.title, style: DS.textStyle.paragraph3.bold.h12),
          DS.space.vXTiny,
          Text(
            coupon.event.description,
            style: DS.textStyle.caption2.h12,
          ),
          DS.space.vTiny,
          Text(
            coupon.event.expiredAt.format(DS.text.couponExpiredAtFormat),
            style: DS.textStyle.caption2.h12,
          ),
          DS.space.vTiny,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              coupon.event.storeName == null
                  ? const SizedBox()
                  : Expanded(
                      child: Text(
                        '${coupon.event.storeName!} ${DS.text.couponOnlyForStoreFormat}',
                        style: DS.textStyle.paragraph3.p600.bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
              Text(
                getProperDiscountText(),
                style: DS.textStyle.paragraph3.point.bold,
              )
            ],
          ),
        ],
      ).paddingAll(DS.space.small),
    );
  }
}
