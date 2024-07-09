import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/gift/gift_success_page_controller.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class GiftSuccessPage extends GetView<GiftSuccessPageController> {
  const GiftSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: c.react.back,
          title: DS.text.shareGiftCode,
          homeOnPressed: c.react.toHomeOffAll,
        ),
        loading: c.isLoading,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppWidget.horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DS.text.giftSuccess,
                  style: DS.textStyle.paragraph2Long.semiBold,
                  textAlign: TextAlign.center,
                ),
                DS.space.vSmall,
                TEPrimaryButton(
                  text: DS.text.shareGiftCode,
                  onTap: c.shareGiftCode,
                  fitContentWidth: true,
                  contentHorizontalPadding: DS.space.tiny,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
