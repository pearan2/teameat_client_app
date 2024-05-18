import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/voucher/voucher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/voucher/voucher_page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';
import 'package:teameat/99_util/extension.dart';

class VoucherPage extends GetView<VoucherPageController> {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cardWith = MediaQuery.of(context).size.width / 2;

    return TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: null,
          title: DS.getText().inventory,
          height: DS.getSpace().medium,
        ),
        withBottomNavigator: true,
        body: Padding(
          padding: EdgeInsets.only(
            left: DS.getSpace().xBase,
            right: DS.getSpace().xBase,
            bottom: DS.getSpace().small,
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: const SizedBox(),
                backgroundColor: DS.getColor().background000,
                surfaceTintColor: DS.getColor().background000,
                snap: true,
                floating: true,
                toolbarHeight: DS.getSpace().large,
                flexibleSpace: Obx(
                  () => Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.numberOfRemainVoucher
                          .format(DS.getText().numberOfRemainVoucherFormat),
                      style: DS
                          .getTextStyle()
                          .paragraph1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                leading: const SizedBox(),
                backgroundColor: DS.getColor().background000,
                surfaceTintColor: DS.getColor().background000,
                pinned: true,
                toolbarHeight: DS.getSpace().medium + DS.getSpace().medium,
                flexibleSpace: Obx(
                  () => Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: TESelectorGrid<Code>(
                            selectedValues: [controller.searchOption.status],
                            numberOfRowChildren: controller.filters.length,
                            candidates: controller.filters,
                            isEqual: (lhs, rhs) => lhs.code == rhs.code,
                            onTap: controller.onFilterChanged,
                            rowSpacing: DS.getSpace().tiny,
                            builder: (value, isSelected) => TEToggle(
                              isTextBold: true,
                              textUnSelected: DS.getColor().background000,
                              textSelected: DS.getColor().background000,
                              boxUnSelected: DS.getColor().background500,
                              boxSelected: DS.getColor().primary500,
                              borderRadius: 300,
                              text: value.title,
                              isSelected: isSelected,
                            ),
                          ),
                        ),
                        DS.getSpace().hTiny,
                        TESelectorBottomSheet<Code>(
                          borderRadius: DS.getSpace().tiny,
                          candidates: controller.orders,
                          onSelected: controller.onOrderChanged,
                          isEqual: (lhs, rhs) => lhs.code == rhs.code,
                          toLabel: (v) => v.title,
                          selectedValue: controller.searchOption.orderBy,
                          text: DS.getText().order,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PagedSliverGrid(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<VoucherSimple>(
                    itemBuilder: (_, voucher, idx) => TEonTap(
                        isLoginRequired: true,
                        onTap: () =>
                            controller.react.toVoucherDetailPage(voucher.id),
                        child: VoucherCard(voucher: voucher)),
                    noItemsFoundIndicatorBuilder: (context) =>
                        const VoucherNotFound(),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: cardWith /
                        (cardWith + DS.getSpace().large + DS.getSpace().base),
                    crossAxisSpacing: DS.getSpace().small,
                    mainAxisSpacing: DS.getSpace().small,
                    crossAxisCount: 2,
                  ))
            ],
          ),
        ));
  }
}

class VoucherCard extends StatelessWidget {
  final VoucherSimple voucher;

  const VoucherCard({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        VoucherImage(
          imageUrls: [voucher.imageUrl],
          willBeExpiredAt: voucher.willBeExpiredAt,
          quantity: voucher.quantity,
        ),
        DS.getSpace().vXTiny,
        Text(
          voucher.storeName,
          style: DS.getTextStyle().paragraph2.copyWith(
                fontWeight: FontWeight.bold,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        DS.getSpace().vXTiny,
        Text(
          voucher.itemName,
          style: DS.getTextStyle().paragraph3,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        DS.getSpace().vXTiny,
        Text(
          voucher.willBeExpiredAt.format(DS.getText().voucherExpiredAtFormat),
          style: DS
              .getTextStyle()
              .caption2
              .copyWith(color: DS.getColor().background600),
        )
      ],
    );
  }
}

class VoucherNotFound extends GetView<VoucherPageController> {
  const VoucherNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DS.getText().voucherNotFound,
            style: DS.getTextStyle().paragraph2.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          DS.getSpace().vTiny,
          TEPrimaryButton(
            onTap: controller.react.toHomeOffAll,
            text: DS.getText().voucherGoToPurchaseVoucher,
            contentHorizontalPadding: DS.getSpace().small,
            fitContentWidth: true,
          ),
          DS.getSpace().vBase,
          Text(
            DS.getText().voucherIfYouNeedHelp,
            style: DS.getTextStyle().paragraph2.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
          ),
          DS.getSpace().vTiny,
          TESecondaryButton(
            onTap: controller.react.toCustomerService,
            text: DS.getText().voucherGoToCustomerService,
            contentHorizontalPadding: DS.getSpace().small,
            fitContentWidth: true,
          ),
        ],
      ),
    );
  }
}
