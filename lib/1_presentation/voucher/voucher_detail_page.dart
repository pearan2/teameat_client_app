import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/expandable.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/voucher/voucher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/clipboard.dart';
import 'package:teameat/2_application/voucher/voucher_detail_page_controller.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        bottomSheetBackgroundColor: DS.color.primary700,
        bottomSheet: Obx(
          () => TEPrimaryButton(
            onTap: isUsable(controller.voucher.willBeExpiredAt,
                    controller.voucher.quantity)
                ? () => showTEBottomSheet(const VoucherUseBottomSheet())
                : null,
            text: c.isGifted ? DS.text.use : DS.text.giftOrUse,
            borderRadius: 0,
            listenEventLoading: false,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: AppWidget.horizontalPadding,
            right: AppWidget.horizontalPadding,
            top: AppWidget.horizontalPadding,
            bottom: DS.space.large + AppWidget.horizontalPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DS.space.xTiny),
            color: DS.color.background100,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DS.space.vSmall,
                Center(child: DS.image.mainIconSm),
                DS.space.vSmall,
                const VoucherShadowCard().withBasePadding,
                DS.space.vSmall,
                Obx(() => PageLoadingWrapper(
                        child: TEonTap(
                      onTap: () => controller.react
                          .toStoreDetail(controller.voucher.storeId),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.voucher.storeName,
                              style: DS.textStyle.caption1.b500.h14,
                            ),
                            Text(
                              controller.voucher.itemName,
                              style: DS.textStyle.paragraph1.bold.b800.h14,
                            ),
                          ],
                        ),
                      ),
                    ))),
                DS.space.vBase,
                const _DottedDividerWithHole(),
                DS.space.vBase,
                Obx(() => PageLoadingWrapper(
                        child: VoucherUseInfoRow(
                            title: DS.text.expiredDuration,
                            contents: [
                          controller.voucher.willBeExpiredAt
                              .format(DS.text.voucherExpiredAtFormat)
                        ]))),
                DS.space.vXTiny,
                Obx(() => PageLoadingWrapper(
                        child: TEonTap(
                      onTap: () => launchUrlString(
                          'tel:${controller.voucher.storePhone}'),
                      child: VoucherUseInfoRow(
                          title: DS.text.phone,
                          contents: [controller.voucher.storePhone]),
                    ))),
                DS.space.vXTiny,
                Obx(() => PageLoadingWrapper(
                    child: VoucherUseInfoRow(
                        title: DS.text.storeAddress,
                        contents: [controller.voucher.storeAddress]))),
                DS.space.vXTiny,
                Obx(() => PageLoadingWrapper(
                        child: VoucherUseInfoRow(
                      title: DS.text.voucherUseLog,
                      contents: controller.voucher.useLogs
                          .map((log) =>
                              '${log.usedAt.format(DS.text.voucherUsedAtFormat)}\t\t\t\t${log.quantity.format(DS.text.voucherCountFormat)} ${log.reason}')
                          .toList(),
                    ))),
                DS.space.vXTiny,
                Obx(() => PageLoadingWrapper(
                        child: TEonTap(
                      onTap: () => TEClipboard.setText(c.voucher.orderId),
                      child: VoucherUseInfoRow(
                        title: DS.text.orderId,
                        contents: [c.voucher.orderId],
                      ),
                    ))),
                DS.space.vBase,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TEonTap(
                      onTap: c.react.toCustomerService,
                      child: Container(
                          padding: EdgeInsets.all(DS.space.tiny),
                          decoration: BoxDecoration(
                              color: DS.color.secondary900,
                              borderRadius:
                                  BorderRadius.circular(DS.space.tiny)),
                          child: Text(
                            DS.text.goToRefundVoucher,
                            style: DS.textStyle.caption1.b000.semiBold,
                          )),
                    ),
                    DS.space.hBase
                  ],
                ),
                DS.space.vBase,
              ],
            ),
          ),
        )));
  }
}

class VoucherUseInfoRow extends StatelessWidget {
  final String title;
  final List<String> contents;
  final TextStyle? style;
  const VoucherUseInfoRow({
    super.key,
    required this.title,
    required this.contents,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final contentStyle = style ?? DS.textStyle.caption1.b600.h14;
    final titleStyle = contentStyle.semiBold;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        DS.space.hXTiny,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children:
                contents.map((c) => Text(c, style: contentStyle)).toList(),
          ),
        )
      ],
    ).withBasePadding;
  }
}

class VoucherShadowCard extends GetView<VoucherDetailPageController> {
  const VoucherShadowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => PageLoadingWrapper(
          child: VoucherImage(
            willBeExpiredAt: controller.voucher.willBeExpiredAt,
            quantity: controller.voucher.quantity,
            imageSrcs: controller.voucher.itemImageUrls,
            stackVerticalOffset: DS.space.medium,
            borderRadius: DS.space.xTiny,
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

class _DottedDividerWithHole extends StatelessWidget {
  const _DottedDividerWithHole();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TEDivider.dot().paddingVertical(DS.space.tiny),
        Positioned(
          left: -DS.space.tiny,
          child: Container(
            width: DS.space.small,
            height: DS.space.small,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              color: DS.color.background000,
            ),
          ),
        ),
        Positioned(
          right: -DS.space.tiny,
          child: Container(
            width: DS.space.small,
            height: DS.space.small,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              color: DS.color.background000,
            ),
          ),
        ),
      ],
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
                      ? DS.color.primary600
                      : DS.color.background400,
                  borderRadius: BorderRadius.circular(300)),
            )),
        separatorBuilder: (_, __) => DS.space.hSmall,
        itemCount: controller.useVoucherPasswordMaxLength,
      ),
    );
  }
}

class VoucherUseByPasswordDialog extends GetView<VoucherDetailPageController> {
  const VoucherUseByPasswordDialog({super.key});

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
              onTap: controller.onVoucherUseReset,
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

class VoucherUseByQRScanDialog extends GetView<VoucherDetailPageController> {
  const VoucherUseByQRScanDialog({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.find<VoucherDetailPageController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DS.space.vTiny,
        DS.image.mainIconWithText,
        DS.space.vSmall,
        Text(
          c.voucher.itemName,
          style: DS.textStyle.paragraph2,
        ),
        DS.space.vTiny,
        Text(c.useVoucherQuantity.format(DS.text.useVoucherCountFormat),
            style: DS.textStyle.title2),
        DS.space.vSmall,
        Text(
          c.voucher.storeName,
          textAlign: TextAlign.center,
          style: DS.textStyle.paragraph2,
        ),
        DS.space.vTiny,
        Text(
          DS.text.pleaseScanStoreVoucherQRCode,
          style: DS.textStyle.paragraph2.copyWith(fontWeight: FontWeight.bold),
        ),
        DS.space.vSmall,
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            padding: EdgeInsets.all(DS.space.tiny),
            width: double.infinity,
            child: QRView(
                onPermissionSet: (_, isPermitted) =>
                    c.onCameraPermissionChanged(isPermitted),
                overlay: QrScannerOverlayShape(
                  borderRadius: DS.space.tiny,
                  borderColor: DS.color.primary600,
                ),
                key: GlobalKey(),
                onQRViewCreated: (controller) {
                  controller.scannedDataStream.listen(c.scanDataListener);
                }),
          ),
        ),
        Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DS.text.voucherQRCodeScanCameraPermissionDeniedNotice,
                  style: DS.textStyle.caption1.point.semiBold.h14,
                ).paddingHorizontal(DS.space.xBase),
                TERowButton(
                  onTap: c.react.toPermissionSetting,
                  text: DS.text.permissionSetting,
                ),
              ],
            ).orEmpty(!c.isCameraPermitted)),
        TEExpandable(
            isHeaderExpand: true,
            header: Text(DS.text.voucherQRCodeScanIfNotPossible,
                style: DS.textStyle.caption1.b400),
            content: TERowButton(
              padding: EdgeInsets.only(top: DS.space.tiny),
              onTap: () {
                c.react.back();
                controller.react.closeBottomSheet();
                controller.onVoucherUseReset();
                showTEDialog(child: const VoucherUseByPasswordDialog());
              },
              text: DS.text.useVoucherByPassword,
            )).paddingHorizontal(DS.space.xBase),
        DS.space.vTiny,
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
        Row(
          children: [
            c.isGifted
                ? const SizedBox()
                : Expanded(
                    child: TESecondaryButton(
                    isLoginRequired: true,
                    onTap: controller.onGiftHandler,
                    text: DS.text.gift,
                  )),
            c.isGifted ? const SizedBox() : DS.space.hTiny,
            Expanded(
              child: TEPrimaryButton(
                isLoginRequired: true,
                onTap: () {
                  controller.react.closeBottomSheet();
                  controller.onVoucherUseReset();
                  if (controller.voucher.voucherUseDefaultType ==
                      'QR_CODE_SCAN') {
                    showTEDialog(child: const VoucherUseByQRScanDialog());
                  } else {
                    showTEDialog(child: const VoucherUseByPasswordDialog());
                  }
                },
                text: DS.text.use,
              ),
            ),
          ],
        )
      ],
    );
  }
}
