import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/1_presentation/event/coupon/component/coupon.dart';
import 'package:teameat/2_application/event/coupon/coupon_page_controller.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CouponPage extends GetView<CouponPageController> {
  const CouponPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
          loading: c.isLoading,
          appBar: TEAppBar(
            leadingIconOnPressed: controller.react.back,
            title: DS.text.couponPage,
            action: TEonTap(
              onTap: () => showTEDialog(child: const _RegisterCouponForm()),
              child: Text(
                DS.text.registerCoupon,
                style: DS.textStyle.paragraph3.semiBold.b800,
              ),
            ),
          ),
          body: TERefreshIndicator(
            onRefresh: () async {
              c.pagingController.refresh();
            },
            child: PagedListView.separated(
              pagingController: c.pagingController,
              separatorBuilder: (_, __) => DS.space.vBase,
              builderDelegate: PagedChildBuilderDelegate<Coupon>(
                noItemsFoundIndicatorBuilder: (_) => Center(
                  child: Text(
                    DS.text.noCouponFound,
                    style: DS.textStyle.paragraph2.semiBold.b800,
                  ),
                ),
                itemBuilder: (_, coupon, __) => CouponCard(coupon),
              ),
            ),
          ).paddingAll(AppWidget.horizontalPadding),
        ));
  }
}

class _RegisterCouponForm extends GetView<CouponPageController> {
  const _RegisterCouponForm();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.tiny),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TECupertinoTextField(
            isEssential: true,
            autoFocus: false,
            helperText: DS.text.registerCouponHelperText,
            hintText: DS.text.registerCouponHintText,
            maxLines: null,
            controller: c.couponIdInputController,
            validate: (value) => value.isNotEmpty,
          ),
          TEPrimaryButton(
            text: DS.text.registerCoupon,
            onTap: () {
              c.react.back();
              c.onRegisterCoupon();
            },
          ),
        ],
      ),
    );
  }
}
