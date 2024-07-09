import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/gift/gift_receive_page_controller.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class GiftReceivePage extends GetView<GiftReceivePageController> {
  const GiftReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TEScaffold(
        bottomSheet: TEPrimaryButton(
          isLoginRequired: true,
          text: DS.text.receiveGift,
          onTap: c.onReceiveGift,
        ),
        bottomSheetBackgroundColor: DS.color.primary600,
        loading: c.isLoading,
        appBar: TEAppBar(
          leadingIconOnPressed: c.react.back,
          title: DS.text.receiveGift,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                c.gift.obx((gift) => TECacheImage(
                      src: gift.profileImageUrl,
                      borderRadius: DS.space.xTiny,
                    )),
                DS.space.vTiny,
                c.gift.obx((gift) => Text(
                      gift.title,
                      style: DS.textStyle.paragraph1.semiBold,
                    )),
                DS.space.vTiny,
                c.gift.obx((gift) => Text(
                      gift.description,
                      style: DS.textStyle.paragraph2Long,
                    )),
                DS.space.vLarge,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
