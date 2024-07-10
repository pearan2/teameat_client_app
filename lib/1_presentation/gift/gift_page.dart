import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';

import 'package:teameat/1_presentation/core/component/not_found.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/gift/gift_page_controller.dart';
import 'package:teameat/3_domain/voucher/gift/gift.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class GiftPage extends GetView<GiftPageController> {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
        loading: c.isLoading,
        appBar: TEAppBar(
          leadingIconOnPressed: c.react.back,
          title: DS.text.toGiftPage,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: TERefreshIndicator(
            onRefresh: () async {
              c.pagingController.refresh();
            },
            child: PagedListView.separated(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<GiftPreview>(
                noItemsFoundIndicatorBuilder: (_) => Center(
                  child: SimpleNotFound(
                    title: DS.text.giftNotFound,
                    buttonText: DS.text.goToBuyGift,
                    onTap: controller.react.toHomeOffAll,
                  ),
                ),
                itemBuilder: (_, gift, __) =>
                    GiftPreviewCard(gift, onShare: () => c.onShare(gift)),
              ),
              separatorBuilder: (_, __) => DS.space.vMedium,
            ),
          ),
        )));
  }
}

class GiftPreviewCard extends StatelessWidget {
  final GiftPreview gift;
  final void Function() onShare;

  const GiftPreviewCard(this.gift, {super.key, required this.onShare});

  Widget _buildStatusButton() {
    if (gift.isUsable) {
      return TEPrimaryButton(
        text: DS.text.shareGiftCodeAgain,
        fitContentWidth: true,
        textStyle: DS.textStyle.paragraph3,
        contentHorizontalPadding: DS.space.tiny,
        height: DS.space.medium,
        borderRadius: DS.space.xTiny,
        onTap: onShare,
      );
    } else {
      return TESecondaryButton(
        text: DS.text.giftReceived,
        fitContentWidth: true,
        textStyle: DS.textStyle.paragraph3,
        contentHorizontalPadding: DS.space.tiny,
        height: DS.space.medium,
        borderRadius: DS.space.xTiny,
        onTap: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width / 3;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TECacheImage(
          src: gift.profileImageUrl,
          width: imageWidth,
          ratio: 3 / 4,
          borderRadius: DS.space.xTiny,
        ),
        DS.space.hSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusButton(),
              DS.space.vTiny,
              Text(
                gift.title,
                style: DS.textStyle.paragraph1.semiBold,
              ),
              DS.space.vTiny,
              Text(
                gift.description,
                style: DS.textStyle.paragraph2Long,
              )
            ],
          ),
        )
      ],
    );
  }
}
