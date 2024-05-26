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
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/int.dart';

class VoucherDetailPage extends GetView<VoucherDetailPageController> {
  const VoucherDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
        loading: controller.isLoading,
        appBar: TEAppBar(
          title: DS.text.voucher,
          leadingIconOnPressed: () =>
              controller.react.back(result: controller.isUpdated),
          homeOnPressed: controller.react.toHomeOffAll,
        ),
        bottomSheetBackgroundColor: DS.color.primary500,
        bottomSheet: Obx(
          () => TEPrimaryButton(
            onTap: isUsable(controller.voucher.willBeExpiredAt,
                    controller.voucher.quantity)
                ? () => showTEBottomSheet(const VoucherUseBottomSheet())
                : null,
            text: DS.text.use,
            borderRadius: 0,
            listenEventLoading: false,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: DS.space.xBase,
            right: DS.space.xBase,
            top: DS.space.xBase,
            bottom: DS.space.large + DS.space.xBase,
          ),
          padding: EdgeInsets.all(DS.space.small),
          decoration: BoxDecoration(
            border: Border.all(color: DS.color.background700),
            borderRadius: BorderRadius.circular(DS.space.medium),
            color: DS.color.background000,
            boxShadow: [
              BoxShadow(
                  color: DS.color.background800.withOpacity(0.25),
                  blurRadius: DS.space.xTiny,
                  offset: Offset(0, DS.space.xTiny))
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: DS.image.mainMediumIconNoBg),
                DS.space.vSmall,
                const DottedLine(),
                DS.space.vSmall,
                const VoucherShadowCard(),
                DS.space.vSmall,
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
                DS.space.vSmall,
                Obx(() => PageLoadingWrapper(
                      child: Text(
                        controller.voucher.itemName,
                        style: DS.textStyle.paragraph2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )),
                DS.space.vSmall,
                const DottedLine(),
                DS.space.vSmall,
                Obx(() => PageLoadingWrapper(
                        child: InfoRow(
                      icon: DS.image.storeItemExpired,
                      title: DS.text.expiredDuration,
                      content: controller.voucher.willBeExpiredAt
                          .format(DS.text.voucherExpiredAtFormat),
                    ))),
                DS.space.vTiny,
                Obx(() => PageLoadingWrapper(
                        child: InfoRow(
                      icon: DS.image.storeLocation,
                      title: DS.text.address,
                      content: controller.voucher.storeAddress,
                    ))),
                DS.space.vTiny,
                Obx(() => PageLoadingWrapper(
                        child: InfoRow(
                      icon: DS.image.storeOperationInfo,
                      title: DS.text.operationTime,
                      content: controller.voucher.storeOperationTime,
                    ))),
                DS.space.vSmall,
                const DottedLine(),
                DS.space.vSmall,
                Obx(() => PageLoadingWrapper(
                        child: InfoRow(
                      icon: const Icon(Icons.info),
                      title: DS.text.voucherUseLog,
                      content: controller.voucher.useLogs.fold(
                          '',
                          (prev, e) =>
                              '$prev${e.usedAt.format(DS.text.voucherUsedAtFormat)}\n${e.quantity.format(DS.text.voucherCountFormat)} ${e.reason}\n\n'),
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
        color: DS.color.background800.withOpacity(0.40),
        blurRadius: DS.space.xTiny,
        spreadRadius: DS.space.xxTiny,
        offset: Offset(
          0,
          DS.space.xTiny,
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
                color: DS.color.background000,
                borderRadius: BorderRadius.circular(DS.space.medium)),
            child: VoucherImage(
              willBeExpiredAt: controller.voucher.willBeExpiredAt,
              quantity: controller.voucher.quantity,
              imageUrls: controller.voucher.itemImageUrls,
              stackVerticalOffset: DS.space.medium,
              borderRadius: DS.space.medium,
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
        style: DS.textStyle.title3,
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
      height: DS.space.small,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, idx) => Obx(() => Container(
              width: DS.space.small,
              height: DS.space.small,
              decoration: BoxDecoration(
                  color: (idx < controller.useVoucherPasswordLength)
                      ? DS.color.primary500
                      : DS.color.background400,
                  borderRadius: BorderRadius.circular(300)),
            )),
        separatorBuilder: (_, __) => DS.space.hSmall,
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
        DS.space.vTiny,
        DS.image.mainIconWithText,
        DS.space.vSmall,
        Text(
          controller.voucher.itemName,
          style: DS.textStyle.paragraph2,
        ),
        DS.space.vTiny,
        Text(
            controller.useVoucherQuantity.format(DS.text.useVoucherCountFormat),
            style: DS.textStyle.title2),
        DS.space.vSmall,
        Text(
          controller.voucher.storeName,
          textAlign: TextAlign.center,
          style: DS.textStyle.paragraph2,
        ),
        DS.space.vTiny,
        Text(
          DS.text.pleaseInputStoreVoucherPassword,
          style: DS.textStyle.paragraph2.copyWith(fontWeight: FontWeight.bold),
        ),
        DS.space.vMedium,
        const VoucherUsePasswordLengthChecker(),
        DS.space.vSmall,
        GridView(
          padding: EdgeInsets.all(DS.space.tiny),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 2 / 1, //item 의 가로 1, 세로 2 의 비율
            mainAxisSpacing: DS.space.xTiny, // 수직 padding
            crossAxisSpacing: DS.space.xTiny, // 수평 Padding
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
          style: DS.textStyle.paragraph2,
        ),
        DS.space.vBase,
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
                  DS.space.hTiny,
                  Text(
                    DS.text.useVoucherCount,
                    style: DS.textStyle.paragraph2,
                  ),
                ],
              ),
              Text(
                controller.useVoucherRemainQuantity
                    .format(DS.text.voucherRemainQuantityFormat),
                style: DS.textStyle.paragraph2,
              ),
            ],
          ),
        ),
        DS.space.vBase,
        TEPrimaryButton(
          isLoginRequired: true,
          onTap: () {
            controller.react.closeBottomSheet();
            controller.onVoucherPasswordReset();
            showTEDialog(child: const VoucherUseDialog());
          },
          text: DS.text.use,
        )
      ],
    );
  }
}
