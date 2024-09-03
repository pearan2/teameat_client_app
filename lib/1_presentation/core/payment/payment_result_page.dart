import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/payment/payment_result_page_controller.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/firebase_cloud_message.dart';
import 'package:teameat/99_util/get.dart';

class PaymentResultPage extends GetView<PaymentResultPageController> {
  const PaymentResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DS.image.mainIconWithText,
          DS.space.vXSmall,
          Text(
            '${c.isGroupBuying ? DS.text.groupBuyingOpened : DS.text.paymentFinished}!',
            style: DS.textStyle.paragraph1,
          ),
          DS.space.vTiny,
          Text(
            '${DS.text.thanks}!',
            style: DS.textStyle.paragraph1,
          ),
          DS.space.vBase,
          SizedBox(
            width: DS.space.large * 4,
            child: TESecondaryButton(
                onTap: controller.react.toHomeOffAll,
                text: DS.text.shoppingContinue),
          ),
          DS.space.vSmall,
          SizedBox(
            width: DS.space.large * 4,
            child: TEPrimaryButton(
              onTap: c.isGroupBuying
                  ? () {
                      c.react.toHomeOffAll();
                      c.react.toStoreItemDetail(c.itemId!);
                    }
                  : controller.react.toVoucherOffAll,
              text: c.isGroupBuying
                  ? DS.text.backToItemPage
                  : DS.text.toVoucherInventory,
            ),
          ),
          DS.space.vSmall.orEmpty(c.isGroupBuying),
          const _AlarmPermissionNotice().orEmpty(c.isGroupBuying)
        ],
      ),
    ));
  }
}

class _AlarmPermissionNotice extends StatefulWidget {
  const _AlarmPermissionNotice();

  @override
  State<_AlarmPermissionNotice> createState() => _AlarmPermissionNoticeState();
}

class _AlarmPermissionNoticeState extends State<_AlarmPermissionNotice> {
  bool? isAlarmPermitted;

  Future<void> _init() async {
    final ret = await MessageHelper.isMessagePermitted();
    if (mounted) {
      setState(() => isAlarmPermitted = ret);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final react = Get.find<IReact>();
    if (isAlarmPermitted == null || isAlarmPermitted!) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DS.text.afterGroupBuyingPermissionRequest,
          style: DS.textStyle.paragraph3.b600.semiBold.h14,
        ),
        DS.space.vTiny,
        TERowButton(
          padding: EdgeInsets.zero,
          onTap: react.toPermissionSetting,
          text: DS.text.permissionSetting,
        ),
      ],
    ).paddingAll(DS.space.medium);
  }
}
