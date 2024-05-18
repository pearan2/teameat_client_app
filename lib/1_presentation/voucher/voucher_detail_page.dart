import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/component/voucher/voucher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/voucher/voucher_detail_page_controller.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';
import 'package:teameat/99_util/extension.dart';

class VoucherDetailPage extends GetView<VoucherDetailPageController> {
  const VoucherDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        appBar: TEAppBar(
          title: DS.getText().voucher,
          leadingIconOnPressed: controller.react.back,
          homeOnPressed: controller.react.toHomeOffAll,
        ),
        bottomSheet: Obx(
          () => TEPrimaryButton(
            onTap: isUsable(controller.voucher.willBeExpiredAt,
                    controller.voucher.quantity)
                ? controller.onUseVoucherHandler
                : null,
            text: DS.getText().use,
            borderRadius: 0,
            listenEventLoading: false,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: DS.getSpace().xBase,
            right: DS.getSpace().xBase,
            top: DS.getSpace().xBase,
            bottom: DS.getSpace().large + DS.getSpace().xBase,
          ),
          padding: EdgeInsets.all(DS.getSpace().small),
          decoration: BoxDecoration(
            border: Border.all(color: DS.getColor().background700),
            borderRadius: BorderRadius.circular(DS.getSpace().medium),
            color: DS.getColor().background000,
            boxShadow: [
              BoxShadow(
                  color: DS.getColor().background800.withOpacity(0.25),
                  blurRadius: DS.getSpace().xTiny,
                  offset: Offset(0, DS.getSpace().xTiny))
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: DS.getImage().mainMediumIconNoBg),
                DS.getSpace().vSmall,
                const DottedLine(),
                DS.getSpace().vSmall,
                const VoucherShadowCard(),
                DS.getSpace().vSmall,
                Obx(() => PageLoadingWrapper(
                      child: StoreSimpleInfoRow(
                        profileImageUrl:
                            controller.voucher.storeProfileImageUrl,
                        name: controller.voucher.storeName,
                        subInfo: controller.voucher.storeOneLineIntroduce,
                        storeId: controller.voucher.storeId,
                        isButton: true,
                      ),
                    )),
                DS.getSpace().vSmall,
                Obx(() => PageLoadingWrapper(
                      child: Text(
                        controller.voucher.itemName,
                        style: DS
                            .getTextStyle()
                            .paragraph2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                DS.getSpace().vSmall,
                const DottedLine(),
                DS.getSpace().vSmall,
                Obx(() => PageLoadingWrapper(
                        child: StoreInfoRow(
                      icon: DS.getImage().storeItemExpired,
                      title: DS.getText().expiredDuration,
                      content: controller.voucher.willBeExpiredAt
                          .format(DS.getText().voucherExpiredAtFormat),
                    ))),
                DS.getSpace().vTiny,
                Obx(() => PageLoadingWrapper(
                        child: StoreInfoRow(
                      icon: DS.getImage().storeLocation,
                      title: DS.getText().address,
                      content: controller.voucher.storeAddress,
                    ))),
                DS.getSpace().vTiny,
                Obx(() => PageLoadingWrapper(
                        child: StoreInfoRow(
                      icon: DS.getImage().storeOperationInfo,
                      title: DS.getText().operationTime,
                      content: controller.voucher.storeOperationTime,
                    ))),
                DS.getSpace().vSmall,
                const DottedLine(),
                DS.getSpace().vSmall,
                Obx(() => PageLoadingWrapper(
                        child: StoreInfoRow(
                      icon: const Icon(Icons.info),
                      title: DS.getText().voucherUseLog,
                      content: controller.voucher.useLogs.fold(
                          '',
                          (prev, e) =>
                              '$prev${e.usedAt.format(DS.getText().voucherUsedAtFormat)}\n${e.quantity.format(DS.getText().voucherCountFormat)} ${e.reason}\n\n'),
                    ))),
              ],
            ),
          ),
        ));
  }
}

class VoucherShadowCard extends GetView<VoucherDetailPageController> {
  const VoucherShadowCard({super.key});
  List<BoxShadow> _buildShadow() {
    return [
      BoxShadow(
        color: DS.getColor().background800.withOpacity(0.40),
        blurRadius: DS.getSpace().xTiny,
        spreadRadius: DS.getSpace().xxTiny,
        offset: Offset(
          0,
          DS.getSpace().xTiny,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PageLoadingWrapper(
          child: Container(
            decoration: BoxDecoration(
                boxShadow: _buildShadow(),
                color: DS.getColor().background000,
                borderRadius: BorderRadius.circular(DS.getSpace().medium)),
            child: VoucherImage(
              willBeExpiredAt: controller.voucher.willBeExpiredAt,
              quantity: controller.voucher.quantity,
              imageUrls: controller.voucher.itemImageUrls,
              stackVerticalOffset: DS.getSpace().medium,
              borderRadius: DS.getSpace().medium,
            ),
          ),
        ));
  }
}
