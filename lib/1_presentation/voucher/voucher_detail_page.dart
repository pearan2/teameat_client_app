import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/info_row.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/component/voucher/voucher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/voucher/voucher_detail_page_controller.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';
import 'package:teameat/99_util/extension.dart';

class VoucherDetailPage extends GetView<VoucherDetailPageController> {
  const VoucherDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
        loading: controller.isLoading,
        appBar: TEAppBar(
          title: DS.getText().voucher,
          leadingIconOnPressed: () =>
              controller.react.back(result: controller.isUpdated),
          homeOnPressed: controller.react.toHomeOffAll,
        ),
        bottomSheet: Obx(
          () => TEPrimaryButton(
            onTap: isUsable(controller.voucher.willBeExpiredAt,
                    controller.voucher.quantity)
                ? () => showTEBottomSheet(const VoucherUseBottomSheet())
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
                        child: InfoRow(
                      icon: DS.getImage().storeItemExpired,
                      title: DS.getText().expiredDuration,
                      content: controller.voucher.willBeExpiredAt
                          .format(DS.getText().voucherExpiredAtFormat),
                    ))),
                DS.getSpace().vTiny,
                Obx(() => PageLoadingWrapper(
                        child: InfoRow(
                      icon: DS.getImage().storeLocation,
                      title: DS.getText().address,
                      content: controller.voucher.storeAddress,
                    ))),
                DS.getSpace().vTiny,
                Obx(() => PageLoadingWrapper(
                        child: InfoRow(
                      icon: DS.getImage().storeOperationInfo,
                      title: DS.getText().operationTime,
                      content: controller.voucher.storeOperationTime,
                    ))),
                DS.getSpace().vSmall,
                const DottedLine(),
                DS.getSpace().vSmall,
                Obx(() => PageLoadingWrapper(
                        child: InfoRow(
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
        )));
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

class VoucherUseDialogGridButton extends StatelessWidget {
  final dynamic content;
  final void Function() onTap;

  const VoucherUseDialogGridButton(
      {super.key, required this.content, required this.onTap})
      : assert(content is String || content is Widget);

  Widget _buildContentWidget() {
    if (content is Widget) {
      return content;
    } else {
      return Text(
        content as String,
        style: DS.getTextStyle().title3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: _buildContentWidget(),
      ),
    );
  }
}

class VoucherUsePasswordLengthChecker
    extends GetView<VoucherDetailPageController> {
  const VoucherUsePasswordLengthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DS.getSpace().small,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, idx) => Obx(() => Container(
              width: DS.getSpace().small,
              height: DS.getSpace().small,
              decoration: BoxDecoration(
                  color: (idx < controller.useVoucherPasswordLength)
                      ? DS.getColor().primary500
                      : DS.getColor().background400,
                  borderRadius: BorderRadius.circular(300)),
            )),
        separatorBuilder: (_, __) => DS.getSpace().hSmall,
        itemCount: controller.useVoucherPasswordMaxLength,
      ),
    );
  }
}

class VoucherUseDialog extends GetView<VoucherDetailPageController> {
  const VoucherUseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DS.getSpace().vTiny,
        DS.getImage().mainIconWithText,
        DS.getSpace().vSmall,
        Text(
          controller.voucher.itemName,
          style: DS.getTextStyle().paragraph2,
        ),
        DS.getSpace().vTiny,
        Text(
            controller.useVoucherQuantity
                .format(DS.getText().useVoucherCountFormat),
            style: DS.getTextStyle().title2),
        DS.getSpace().vSmall,
        Text(
          controller.voucher.storeName,
          style: DS.getTextStyle().paragraph2,
        ),
        Text(
          DS.getText().pleaseInputStoreVoucherPassword,
          style: DS
              .getTextStyle()
              .paragraph2
              .copyWith(fontWeight: FontWeight.bold),
        ),
        DS.getSpace().vMedium,
        const VoucherUsePasswordLengthChecker(),
        DS.getSpace().vSmall,
        GridView(
          padding: EdgeInsets.all(DS.getSpace().tiny),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 2 / 1, //item 의 가로 1, 세로 2 의 비율
            mainAxisSpacing: DS.getSpace().xTiny, // 수직 padding
            crossAxisSpacing: DS.getSpace().xTiny, // 수평 Padding
          ),
          children: [
            VoucherUseDialogGridButton(
              content: '1',
              onTap: () => controller.onVoucherPasswordAppended('1'),
            ),
            VoucherUseDialogGridButton(
              content: '2',
              onTap: () => controller.onVoucherPasswordAppended('2'),
            ),
            VoucherUseDialogGridButton(
              content: '3',
              onTap: () => controller.onVoucherPasswordAppended('3'),
            ),
            VoucherUseDialogGridButton(
              content: '4',
              onTap: () => controller.onVoucherPasswordAppended('4'),
            ),
            VoucherUseDialogGridButton(
              content: '5',
              onTap: () => controller.onVoucherPasswordAppended('5'),
            ),
            VoucherUseDialogGridButton(
              content: '6',
              onTap: () => controller.onVoucherPasswordAppended('6'),
            ),
            VoucherUseDialogGridButton(
              content: '7',
              onTap: () => controller.onVoucherPasswordAppended('7'),
            ),
            VoucherUseDialogGridButton(
              content: '8',
              onTap: () => controller.onVoucherPasswordAppended('8'),
            ),
            VoucherUseDialogGridButton(
              content: '9',
              onTap: () => controller.onVoucherPasswordAppended('9'),
            ),
            VoucherUseDialogGridButton(
              content: const Icon(Icons.refresh),
              onTap: controller.onVoucherPasswordReset,
            ),
            VoucherUseDialogGridButton(
              content: '0',
              onTap: () => controller.onVoucherPasswordAppended('0'),
            ),
            VoucherUseDialogGridButton(
              content: const Icon(Icons.arrow_back),
              onTap: controller.onVoucherPasswordDeleteLast,
            ),
          ],
        ),
      ],
    );
  }
}

class VoucherUseBottomSheet extends GetView<VoucherDetailPageController> {
  const VoucherUseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.voucher.itemName,
          style: DS.getTextStyle().paragraph2,
        ),
        DS.getSpace().vBase,
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  StoreItemQuantityPicker(
                    quantity: controller.useVoucherQuantity,
                    onQuantityChanged: controller.onUseQuantityChanged,
                  ),
                  DS.getSpace().hTiny,
                  Text(
                    DS.getText().useVoucherCount,
                    style: DS.getTextStyle().paragraph2,
                  ),
                ],
              ),
              Text(
                controller.useVoucherRemainQuantity
                    .format(DS.getText().voucherRemainQuantityFormat),
                style: DS.getTextStyle().paragraph2,
              ),
            ],
          ),
        ),
        DS.getSpace().vBase,
        TEPrimaryButton(
          isLoginRequired: true,
          onTap: () {
            controller.react.closeBottomSheet();
            controller.onVoucherPasswordReset();
            showTEDialog(child: const VoucherUseDialog());
          },
          text: DS.getText().use,
        )
      ],
    );
  }
}
