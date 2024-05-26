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
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/int.dart';

class VoucherPage extends GetView<VoucherPageController> {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cardWith = MediaQuery.of(context).size.width / 2;

    return TEScaffold(
        onPop: (didPop) => controller.react.toHomeOffAll(),
        appBar: TEAppBar(
          leadingIconOnPressed: null,
          title: DS.text.inventory,
          height: DS.space.medium,
        ),
        withBottomNavigator: true,
        body: Padding(
          padding: EdgeInsets.only(
            left: DS.space.xBase,
            right: DS.space.xBase,
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: const SizedBox(),
                backgroundColor: DS.color.background000,
                surfaceTintColor: DS.color.background000,
                snap: true,
                floating: true,
                toolbarHeight: DS.space.large,
                flexibleSpace: Obx(
                  () => Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.numberOfRemainVoucher
                          .format(DS.text.numberOfRemainVoucherFormat),
                      style: DS.textStyle.paragraph1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                leading: const SizedBox(),
                backgroundColor: DS.color.background000,
                surfaceTintColor: DS.color.background000,
                pinned: true,
                toolbarHeight: DS.space.medium + DS.space.medium,
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
                            rowSpacing: DS.space.tiny,
                            builder: (value, isSelected) => TEToggle(
                              isTextBold: true,
                              textUnSelected: DS.color.background000,
                              textSelected: DS.color.background000,
                              boxUnSelected: DS.color.background500,
                              boxSelected: DS.color.primary500,
                              borderRadius: 300,
                              text: value.title,
                              isSelected: isSelected,
                            ),
                          ),
                        ),
                        DS.space.hTiny,
                        TESelectorBottomSheet<Code>(
                          borderRadius: DS.space.tiny,
                          candidates: controller.orders,
                          onSelected: controller.onOrderChanged,
                          isEqual: (lhs, rhs) => lhs.code == rhs.code,
                          toLabel: (v) => v.title,
                          selectedValue: controller.searchOption.orderBy,
                          text: DS.text.order,
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
                            controller.onVoucherCardClickHandler(voucher.id),
                        child: VoucherCard(voucher: voucher)),
                    noItemsFoundIndicatorBuilder: (context) =>
                        const VoucherNotFound(),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:
                        cardWith / (cardWith + DS.space.large + DS.space.base),
                    crossAxisSpacing: DS.space.small,
                    mainAxisSpacing: DS.space.small,
                    crossAxisCount: 2,
                  )),
              SliverToBoxAdapter(child: DS.space.vSmall)
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
          borderRadius: DS.space.tiny,
          imageUrls: [voucher.imageUrl],
          willBeExpiredAt: voucher.willBeExpiredAt,
          quantity: voucher.quantity,
        ),
        DS.space.vXTiny,
        Text(
          voucher.storeName,
          style: DS.textStyle.paragraph2.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        DS.space.vXTiny,
        Text(
          voucher.itemName,
          style: DS.textStyle.paragraph3,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        DS.space.vXTiny,
        Text(
          voucher.willBeExpiredAt.format(DS.text.voucherExpiredAtFormat),
          style: DS.textStyle.caption2.copyWith(color: DS.color.background600),
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
            DS.text.voucherNotFound,
            style: DS.textStyle.paragraph2.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          DS.space.vTiny,
          TEPrimaryButton(
            onTap: controller.react.toHomeOffAll,
            text: DS.text.voucherGoToPurchaseVoucher,
            contentHorizontalPadding: DS.space.small,
            fitContentWidth: true,
          ),
          DS.space.vBase,
          Text(
            DS.text.voucherIfYouNeedHelp,
            style: DS.textStyle.paragraph2.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          DS.space.vTiny,
          TESecondaryButton(
            onTap: controller.react.toCustomerService,
            text: DS.text.voucherGoToCustomerService,
            contentHorizontalPadding: DS.space.small,
            fitContentWidth: true,
          ),
        ],
      ),
    );
  }
}
