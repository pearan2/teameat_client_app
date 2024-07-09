import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/gift/gift_create_page_controller.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class GiftCreatePage extends GetView<GiftCreatePageController> {
  const GiftCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
          loading: c.isLoading,
          appBar: TEAppBar(
            leadingIconOnPressed: c.react.back,
            title: DS.text.gift,
            homeOnPressed: c.react.toHomeOffAll,
          ),
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(AppWidget.horizontalPadding),
            child: Column(
              children: [
                ItemInfoCard(voucher: c.voucher, quantity: c.giftQuantity),
                DS.space.vBase,
                TECupertinoTextField(
                  autoFocus: true,
                  helperText: DS.text.giftMessage,
                  hintText: DS.text.giftMessageHint,
                  maxLines: 4,
                  controller: c.messageController,
                  errorText: DS.text.giftMessageError,
                  validate: (value) =>
                      value.isEmpty ||
                      (value.isNotEmpty && value.length <= 255),
                ),
                DS.space.vSmall,
                TEPrimaryButton(
                  isLoginRequired: true,
                  text: DS.text.gift,
                  onTap: c.onGift,
                ),
              ],
            ),
          ),
        ));
  }
}

class ItemInfoCard extends StatelessWidget {
  final VoucherDetail voucher;
  final int quantity;

  const ItemInfoCard(
      {super.key, required this.voucher, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final imageWith = MediaQuery.of(context).size.width / 3;

    return Row(
      children: [
        TECacheImage(
          src: voucher.itemImageUrls.first,
          width: imageWith,
          borderRadius: DS.space.small,
        ),
        DS.space.hSmall,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              voucher.storeName,
              style:
                  DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
            ),
            DS.space.vXTiny,
            Text(voucher.storeAddress,
                style: DS.textStyle.caption1.copyWith(
                  color: DS.color.background600,
                )),
            DS.space.vBase,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(voucher.itemName, style: DS.textStyle.paragraph1.semiBold),
                DS.space.hTiny,
                Text(
                  quantity.format(DS.text.voucherCountFormat),
                  style: DS.textStyle.paragraph2.semiBold.s900,
                )
              ],
            ),
          ],
        )),
      ],
    );
  }
}
